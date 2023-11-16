import 'package:FilmFlu/ui/pages/splash/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

class DefaultAsyncLoading extends StatelessWidget {
  final Widget child;
  final ImageChunkEvent? loadingProgress;

  const DefaultAsyncLoading(
      {super.key, required this.child, required this.loadingProgress});

  @override
  Widget build(BuildContext context) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress!.expectedTotalBytes != null
            ? loadingProgress!.cumulativeBytesLoaded /
                loadingProgress!.expectedTotalBytes!
            : null,
      ),
    );
  }
}

class DefaultSyncLoading extends StatelessWidget {
  const DefaultSyncLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: kIsWeb ? CircularProgressIndicator() : SplashScreen()));
  }
}
