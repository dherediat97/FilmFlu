import 'package:flutter/material.dart';

class DefaultCircularLoader extends StatelessWidget {
  const DefaultCircularLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
