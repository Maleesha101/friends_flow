import 'package:flutter/material.dart';

class ProfileBackground extends StatelessWidget {
  const ProfileBackground(
      {super.key, required this.child, required this.index});
  final Widget child;
  final int index;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: -100,
          child: SizedBox(
            // height: 700,
            width: size.width,
            child: Image.asset("assets/images/bg $index.png"),
          ),
        ),
        child
      ]),
    );
  }
}
