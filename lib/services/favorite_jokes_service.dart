import '../models/joke.dart';

class FavoriteJokesService {
  static List<Joke> favoriteJokes = [];

  static void addFavorite(Joke joke) {
    favoriteJokes.add(joke);
  }

  static void removeFavorite(Joke joke) {
    favoriteJokes.remove(joke);
  }

  static List<Joke> getFavorites() {
    return List.unmodifiable(favoriteJokes);
  }
}