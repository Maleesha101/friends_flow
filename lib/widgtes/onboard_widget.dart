import 'package:flutter/material.dart';

class OnboardWidget extends StatelessWidget {
  const OnboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(),
          ),
        ],
      ),
    );
  }
}
