import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../app_services.dart';
import '../service/mixins.dart';
import '../service/theme/theme.dart';
import '../service/timezone.dart';
import '../values/world_clock_icons.dart';
import 'world_clock_searchbar.dart';

class LocationSelectorDialog extends StatefulWidget
    with ShowDialogMixin<Location> {
  // TODO: Move this to routes...
  static const name = 'selectLocationDialog';

  const LocationSelectorDialog({super.key});

  @override
  bool get barrierDismissible => false;

  @override
  RouteSettings get settings => const RouteSettings(name: name);

  @override
  State<LocationSelectorDialog> createState() => _LocationSelectorDialogState();
}

class _LocationSelectorDialogState extends State<LocationSelectorDialog> {
  late final _locations = ValueNotifier<Iterable<Location>>(
      TimeZoneUtility.i.getFilteredLocations(''));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: LayoutBuilder(
          builder: (_, constraints) {
            final width = math.min(900.0, constraints.maxWidth * 0.85);
            final padding = width * 0.05;

            return SizedBox(
              width: width,
              height: constraints.maxHeight * 0.9,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: CustomTheme.instance.clockBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: CustomTheme.instance.backgroundColor,
                      blurRadius: 10,
                      offset: const Offset(4, 4),
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: padding,
                    left: padding,
                    bottom: padding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Location',
                            style: CustomTheme.instance.titleStyle,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => AppServices.navigationService.navigator
                                ?.pop(_locations.value.first),
                            child: Icon(
                              WorldClockIcons.close,
                              size: 40,
                              color: CustomTheme.instance.primaryTextColor,
                            ),
                          ),
                          const SizedBox(width: 40),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 2,
                        width: double.infinity,
                        child: ColoredBox(
                          color: CustomTheme.instance.accentTextColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      WorldClockSearchBar(
                        onSearch: (value) => _locations.value = TimeZoneUtility
                            .i
                            .getFilteredLocations(value.trim()),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: _locations,
                          builder: (_, value, __) {
                            final locations = value.toList();

                            return ListView.builder(
                              itemCount: locations.length,
                              physics: const AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              itemBuilder: (_, index) {
                                final location = locations[index];
                                final timezone = location.currentTimeZone;

                                return InkWell(
                                  onTap: () {
                                    final navigator =
                                        AppServices.navigationService.navigator;

                                    AppServices.app.currentState
                                        ?.setLocation(location)
                                        .then((value) {
                                      navigator?.pop(location);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                      left: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${location.name} - ',
                                          style: CustomTheme.instance.heading4,
                                        ),
                                        Text(
                                          timezone.abbreviation,
                                          style: CustomTheme.instance.heading4
                                              .copyWith(
                                            color: CustomTheme
                                                .instance.subtitleStyle.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
