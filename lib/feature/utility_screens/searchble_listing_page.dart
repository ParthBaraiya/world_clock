import 'package:flutter/material.dart';
import 'package:world_clock/widget/world_clock_searchbar.dart';

mixin SearchableListingPageMixin<T extends StatefulWidget, L> on State<T> {
  var _searchedItems = <L>[];

  List<L> get items;

  @override
  void initState() {
    super.initState();

    _searchedItems = items;
  }

  bool includeItem(String query, L item);

  Widget builder(BuildContext context, int index);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: WorldClockSearchBar(
            onSearch: (query) {
              // TODO: Add debouncer.

              if (query.isEmpty) {
                _searchedItems = items;
              } else {
                final q = query.toLowerCase();

                _searchedItems = items.where((e) => includeItem(q, e)).toList();
              }

              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),
        SliverList.builder(
          itemBuilder: builder,
          itemCount: _searchedItems.length,
        ),
      ],
    );
  }
}
