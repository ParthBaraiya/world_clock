import 'package:flutter/material.dart';
import 'package:world_clock/service/theme/theme.dart';
import 'package:world_clock/values/enumerations.dart';
import 'package:world_clock/widget/timezone_listing_widgets/timezone_list_builder_state.dart';
import 'package:world_clock/widget/world_clock_searchbar.dart';
import 'package:world_clock_widgets/interfaces/world_clock_data_filter.dart';

import '../../service/timezone.dart';

abstract class TimezoneListingWithFiltersWidgetState<T extends StatefulWidget>
    extends TimeZoneListState<T> {
  // NOTE: Use _setFilters to update the filter.
  var _filters = WorldClockTimeZoneFilters.reset;

  late final _sortBy = ValueNotifier(_filters.sortBy);
  late final _sortingOrder = ValueNotifier(_filters.order);
  late final _search = ValueNotifier(_filters.search);

  final _sortByState = GlobalKey<PopupMenuButtonState>();

  WorldClockTimeZoneFilters get filters => _filters;

  @override
  Widget build(BuildContext context) {
    final list = super.build(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: WorldClockSearchBar(
                  hintText: 'Search by Timezone',
                  onSearch: (value) {
                    if (value != _search.value) {
                      _setFilters(_filters.copyWith(search: value));
                    }
                  },
                ),
              ),
              const Text('Sort By: '),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  _sortByState.currentState?.showButtonMenu();
                },
                child: ValueListenableBuilder(
                  valueListenable: _sortBy,
                  builder: (_, value, __) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedSize(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          child: Text(_filters.sortBy.display),
                        ),
                        const SizedBox(width: 10),
                        IgnorePointer(
                          child: PopupMenuButton(
                            key: _sortByState,
                            onSelected: (value) {
                              if (_filters.sortBy != value) {
                                _setFilters(_filters.copyWith(sortBy: value));
                              }
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: CustomTheme.instance.primaryTextColor,
                            ),
                            initialValue: _filters.sortBy,
                            itemBuilder: (_) {
                              return TimezoneSortBy.values.map((e) {
                                return PopupMenuItem(
                                  child: Text(e.display),
                                  value: e,
                                );
                              }).toList();
                            },
                            tooltip: '',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 40),
              ValueListenableBuilder(
                valueListenable: _sortingOrder,
                builder: (_, value, __) {
                  return InkWell(
                    onTap: () {
                      if (value == SortingOrder.asc) {
                        _setFilters(
                            _filters.copyWith(order: SortingOrder.desc));
                      } else {
                        _setFilters(_filters.copyWith(order: SortingOrder.asc));
                      }
                    },
                    child: Icon(
                      Icons.sort_by_alpha_rounded,
                      color: value == SortingOrder.asc
                          ? CustomTheme.instance.primaryTextColor
                          : CustomTheme.instance.accentTextColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: list,
        ),
      ],
    );
  }

  void _setFilters(WorldClockTimeZoneFilters newFilter) {
    if (newFilter != _filters) {
      _filters = newFilter;
      _sortBy.value = _filters.sortBy;
      _search.value = _filters.search;
      _sortingOrder.value = _filters.order;
      loadItems();
    }
  }
}

@immutable
class WorldClockTimeZoneFilters extends WorldClockDataFilter<TimeZone> {
  static const reset = WorldClockTimeZoneFilters(
    search: null,
    order: SortingOrder.asc,
    sortBy: TimezoneSortBy.timezone,
  );

  final TimezoneSortBy sortBy;
  final SortingOrder order;
  final String? search;

  const WorldClockTimeZoneFilters({
    required this.sortBy,
    required this.order,
    required this.search,
  });

  WorldClockTimeZoneFilters copyWith({
    TimezoneSortBy? sortBy,
    SortingOrder? order,
    String? search,
  }) {
    return WorldClockTimeZoneFilters(
      sortBy: sortBy ?? this.sortBy,
      order: order ?? this.order,
      search: search ?? this.search,
    );
  }

  /// Returns a new [Iterable] with the applied filters.
  @override
  Iterable<TimeZone> apply(Iterable<TimeZone> timezones) {
    var filtered = timezones;

    // Applies search
    if (search != null && search!.isNotEmpty) {
      final expr = RegExp(search!.toLowerCase());
      filtered = filtered.where(
          (element) => expr.hasMatch(element.abbreviation.toLowerCase()));
    }

    final list = filtered.toList();

    /// Applies sorting
    switch (sortBy) {
      case TimezoneSortBy.location:
        list.sort((t1, t2) {
          final l1 = TimeZoneUtility.i.locationMap[t1]?.first.name;
          final l2 = TimeZoneUtility.i.locationMap[t2]?.first.name;

          return (l1 ?? '').compareTo(l2 ?? '');
        });
        break;
      case TimezoneSortBy.timezone:
        list.sort((t1, t2) {
          return (t1.abbreviation).compareTo(t2.abbreviation);
        });
        break;
      case TimezoneSortBy.offset:
        list.sort((t1, t2) {
          return (t1.offset).compareTo(t2.offset);
        });
        break;
    }

    // Applies order
    switch (order) {
      case SortingOrder.asc:
        return list;
      case SortingOrder.desc:
        return list.reversed;
    }
  }
}
