import '../responsive_home_page.dart';
import 'favorites_list_page.dart';

class FavoritesDesktopPage extends DesktopHomePage {
  const FavoritesDesktopPage({super.key})
      : super(
          widget: const FavoritesListPage(),
          index: 0,
        );
}
