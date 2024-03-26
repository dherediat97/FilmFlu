//Core Packages
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//My Packages
import 'package:FilmFlu/modules/shared/widgets/scaffold_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
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
      isSearchVisible: false,
      containerChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset(
            'assets/animations/splash_animation.json',
            controller: _controller,
            height: MediaQuery.of(context).size.height / 2,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().whenComplete(
                    () => Modular.to.pushReplacementNamed('/FilmFlu'));
            },
          )),
          Center(
              child: Text('AppLocalizations.of(context)',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
        ],
      ),
    );
  }
}
