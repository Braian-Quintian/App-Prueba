import 'package:flutter/material.dart';

class GifView extends StatelessWidget {
  const GifView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/animations/animation.gif'),
      ),
    );
  }
}
