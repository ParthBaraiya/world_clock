import 'package:flutter/material.dart';
import 'package:world_clock/service/theme/theme.dart';
import 'package:world_clock/values/world_clock_icons.dart';

class WorldClockSearchBar extends StatelessWidget {
  const WorldClockSearchBar({
    super.key,
    required this.onSearch,
    this.hintText = 'Search location',
  });

  final ValueChanged<String> onSearch;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          WorldClockIcons.search,
          color: CustomTheme.instance.primaryTextColor,
          size: 30,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: CustomTheme.instance.searchBarHintStyle,
            ),
            onChanged: onSearch,
          ),
        )
      ],
    );
  }
}
