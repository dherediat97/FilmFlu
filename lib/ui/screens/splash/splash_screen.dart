import 'package:FilmFlu/ui/screens/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (2)),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "Film Flu",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Barlow"),
                      textAlign: TextAlign.center,
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
      ),
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash_animation.json',
          controller: _controller,
          height: MediaQuery.of(context).size.height / 2,
          animate: true,
          reverse: false,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(() => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  ));
          },
        ),
      ),
    );
  }
}
