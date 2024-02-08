import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:friend_flow/controllers/auth_controller.dart';
import 'package:friend_flow/models/user_model.dart';
import 'package:friend_flow/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../views/navigation_screen.dart';
import '../views/sign_in_page.dart';

class AuthProvider extends ChangeNotifier {
  AuthController authController = AuthController();
  User? _user;
  User? get user => _user;
  Future<void> listenAuth(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInPage(),
            ));
      } else {
        print('User is signed in!');
        _user = user;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NavigationScreen(),
            ));
      }
    });
  }

  Future<void> signInWithGoogle() async {
    final credential = await authController.signInWithGoogle();
    if (credential != null) {
      UserModel user = UserModel(
          token: "",
          name: _user!.displayName!,
          image: _user!.photoURL!,
          uid: _user!.uid,
          lastSeen: DateTime.now().toString(),
          isOnline: true);
      await authController.saveUserData(user);
    }
  }

  Future<void> signOut(BuildContext context) async {
    Provider.of<UserProvider>(context).updateOnlineStatus(false, context);
    authController.userSignOut();
  }
}
