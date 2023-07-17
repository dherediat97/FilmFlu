//Core Packages
import 'package:flutter/material.dart';

//My Packages
import 'package:FilmFlu/dto/movie.dart';
import 'package:FilmFlu/network/api.dart';
import 'package:FilmFlu/ui/components/movie_list.dart';

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      appBar: AppBar(
          toolbarHeight: 75,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextField(
                        autocorrect: true,
                        controller: _searchController,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            hintText: 'Busca aquí tu película favorita...',
                            hintStyle: TextStyle(color: Colors.white54),
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            border: InputBorder.none),
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          title: Image.asset('assets/images/transparent_logo.png', height: 60),
          elevation: 48,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    icon: Icon(
                      Icons.login,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        //Descargar App Android
                      },
                      icon: Icon(
                        Icons.android,
                        color: Theme.of(context).colorScheme.primary,
                      ))
                ],
              ),
            ),
          ]),
      body: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.background,
          child: ListView(children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Cartelera',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Barlow',
                        fontSize: 40),
                  ),
                ),
              ],
            ),
            FutureBuilder<List<Movie>>(
                future: api.fetchPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MovieList(items: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ])),
    );
  }
}
