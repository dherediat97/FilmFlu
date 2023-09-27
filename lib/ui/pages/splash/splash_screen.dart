//Core Packages
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//My Packages
import 'package:FilmFlu/ui/pages/main/main_screen.dart';
import 'package:FilmFlu/ui/components/scaffold_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      routeName: "",
      isSearchVisible: false,
      containerChild: Center(
        child: Lottie.asset(
          'assets/animations/splash_animation.json',
          controller: _controller,
          height: MediaQuery.of(context).size.height,
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
