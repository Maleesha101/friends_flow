import 'package:flutter/material.dart';
import 'package:friend_flow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .signInWithGoogle();
              },
              child: const Text("data"))
        ],
      ),
    );
  }
}
