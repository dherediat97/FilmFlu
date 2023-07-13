import 'package:FilmFlu/dto/tv_show.dart';
import 'package:flutter/material.dart';

import '../../../dto/movie.dart';
import '../../../network/api.dart';
import '../../components/movie_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Api api = Api();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 75,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: TextField(
                        autocorrect: true,
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            hintText: 'Busca aquí tu película favorita...',
                            hintStyle: TextStyle(color: Colors.white54),
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            border: InputBorder.none),
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ),
            ),
            title: Center(
                child: Image.asset('assets/images/transparent_logo.png',
                    height: 60)),
            elevation: 48,
            backgroundColor: Theme.of(context).colorScheme.background,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'Películas populares hoy',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  ],
                ),
                FutureBuilder<List<Movie>>(
                    future: api.fetchPopularMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center();
                      } else if (snapshot.hasData) {
                        return MovieList(items: snapshot.data!);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                const Row(
                  children: [
                    Text(
                      'Programas TV populares hoy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                FutureBuilder<List<TvShow>>(
                    future: api.fetchPopularTvShows(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center();
                      } else if (snapshot.hasData) {
                        return MovieList(items: snapshot.data!);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
