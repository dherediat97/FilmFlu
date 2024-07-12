import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/presentation/widgets/custom_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
    this.routePath = '/',
  });

  final String routePath;

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
                  () {
                    return context.push(widget.routePath);
                  },
                );
            },
          )),
          Center(
            child: Text(
              context.localizations.loading_title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
