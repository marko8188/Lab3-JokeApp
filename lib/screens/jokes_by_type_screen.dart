import '../models/joke.dart';
import 'package:flutter/material.dart';
import '../services/api_services.dart';
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

class JokesByTypeScreen extends StatelessWidget {
  final String type;
  final Function(Joke) onAddFavorite;

  const JokesByTypeScreen({required this.type, required this.onAddFavorite, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jokes: $type',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No jokes available',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            );
          }
          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final joke = jokes[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    joke.setup,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  subtitle: Text(
                    joke.punchline,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    color: Colors.red,
                    onPressed: () {
                      onAddFavorite(joke); // Add to favorites
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to favorites!'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              FavoriteJokesService.removeFavorite(joke);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
