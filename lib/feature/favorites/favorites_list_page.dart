import 'package:world_clock/widget/timezone_listing_widgets/favorites_timezones/favorites_timezone_list_widget.dart';

import '../../widget/gradient_scaffold.dart';

class FavoritesListPage extends GradientScaffold {
  const FavoritesListPage({super.key})
      : super(
          body: const FavoritesTimezonesListWidget(),
          title: 'Favorites',
        );
}
