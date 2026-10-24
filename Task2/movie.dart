
class Movie {
  final String title;
  final String genre;
  final int year;
  final double rating;
  final String image;

  const Movie({
    required this.title,
    required this.genre,
    required this.year,
    required this.rating,
    required this.image,
  });
}

final List<Movie> movies = [
  Movie(
    title: 'The Boss Baby',
    genre: 'Animation, Comedy',
    year: 2017,
    rating: 6.3,
    image: 'assets/posters/baby_boss.jpg',
  ),
  Movie(
    title: 'Coco',
    genre: 'Animation, Family',
    year: 2017,
    rating: 8.4,
    image: 'assets/posters/coco.jpg',
  ),
  Movie(
    title: 'Forgotten',
    genre: 'Mystery, Thriller',
    year: 2017,
    rating: 7.4,
    image: 'assets/posters/forgotten.jpg',
  ),
  Movie(
    title: 'Green Book',
    genre: 'Drama, Comedy',
    year: 2018,
    rating: 8.2,
    image: 'assets/posters/green_book.jpg',
  ),
  Movie(
    title: 'Harry Potter',
    genre: 'Fantasy, Adventure',
    year: 2001,
    rating: 7.6,
    image: 'assets/posters/harry_potter.jpg',
  ),
  Movie(
    title: 'Home Alone',
    genre: 'Comedy, Family',
    year: 1990,
    rating: 7.7,
    image: 'assets/posters/home_alone.jpg',
  ),
  Movie(
    title: 'It',
    genre: 'Horror, Thriller',
    year: 2017,
    rating: 7.3,
    image: 'assets/posters/it.webp',
  ),
  Movie(
    title: 'Rampage',
    genre: 'Action, Adventure',
    year: 2018,
    rating: 6.1,
    image: 'assets/posters/rampage.jpg',
  ),
  Movie(
    title: 'Shutter Island',
    genre: 'Mystery, Thriller',
    year: 2010,
    rating: 8.2,
    image: 'assets/posters/shutter_island.jpg',
  ),
  Movie(
    title: 'The Invisible Guest',
    genre: 'Mystery, Crime',
    year: 2016,
    rating: 8.0,
    image: 'assets/posters/the_invisible_guest.jpg',
  ),
  Movie(
    title: 'The Maze Runner',
    genre: 'Sci-Fi, Action',
    year: 2014,
    rating: 6.8,
    image: 'assets/posters/the_maze_runner.jpg',
  ),
];
