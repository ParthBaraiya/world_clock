part of 'favorite.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites...'),
      ),
      body: const FavoritesTimezonesListWidget(),
    );
  }
}
