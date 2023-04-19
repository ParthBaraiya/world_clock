import '../../widget/gradient_scaffold.dart';
import 'favorite.dart';

class FavoritesListPage extends GradientScaffold {
  const FavoritesListPage({super.key})
      : super(
          body: const Favorites(),
          title: 'Favorites',
        );
}
