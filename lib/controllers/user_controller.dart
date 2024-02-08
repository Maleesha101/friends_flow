import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:friend_flow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserController {
  final user = FirebaseFirestore.instance.collection("user");
  Stream<QuerySnapshot> getAllUers(BuildContext context) {
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    return user.where('uid', isNotEqualTo: uid).snapshots();
  }

  Future<void> updateOlineState(bool isOnline, String uid) async {
    await user
        .doc(uid)
        .update({'isOnline': isOnline, 'lastSeen': DateTime.now().toString()});
  }
}
