import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String imagePath;

  const Logo({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: 100,
    );
  }
}
