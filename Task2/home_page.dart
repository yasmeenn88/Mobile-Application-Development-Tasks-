
import 'package:flutter/material.dart';
import 'movie.dart';
import 'movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  bool isGridView = true;
  int discount = 20;

  @override
  Widget build(BuildContext context) {
    final filteredMovies = movies.where((movie) {
      final title = movie.title.toLowerCase();
      final genre = movie.genre.toLowerCase();
      final query = searchQuery.toLowerCase();

      return title.contains(query) || genre.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Text(
          'MOVIE LIBRARY',
          style: TextStyle(
            color: Color(0xFFE50914),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies or genres...',
                hintStyle: const TextStyle(
                  color: Color(0xFFB3B3B3),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFB3B3B3),
                ),
                filled: true,
                fillColor: const Color(0xFF222222),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredMovies.length} Movies',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isGridView = false;
                        });
                      },
                      icon: Icon(
                        Icons.view_list,
                        color: !isGridView
                            ? const Color(0xFFE50914)
                            : Colors.white70,
                      ),
                      tooltip: 'List View',
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isGridView = true;
                        });
                      },
                      icon: Icon(
                        Icons.grid_view,
                        color: isGridView
                            ? const Color(0xFFE50914)
                            : Colors.white70,
                      ),
                      tooltip: 'Grid View',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            Expanded(
              child: filteredMovies.isEmpty
                  ? const Center(
                child: Text(
                  'No movies found',
                  style: TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 16,
                  ),
                ),
              )
                  : isGridView
                  ? GridView.builder(
                itemCount: filteredMovies.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.49,
                ),
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: filteredMovies[index],
                    discount: discount,
                    onDiscountTap: () {
                      setState(() {
                        discount--;
                      });
                    },
                  );
                },
              )
                  : ListView.builder(
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MovieCard(
                      movie: filteredMovies[index],
                      discount: discount,
                      onDiscountTap: () {
                        setState(() {
                          discount--;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
