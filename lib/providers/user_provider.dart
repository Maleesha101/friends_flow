import 'package:flutter/material.dart';
import 'package:friend_flow/controllers/user_controller.dart';
import 'package:friend_flow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  UserController userController = UserController();

  Future<void> updateOnlineStatus(bool isOnline, BuildContext context) async {
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    userController.updateOlineState(isOnline, uid);
  }
}
