// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MessageBackground extends StatelessWidget {
  const MessageBackground({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/bg 3.png",
              fit: BoxFit.cover,
            ),
          ),
          child
        ],
      ),
    );
  }
}
