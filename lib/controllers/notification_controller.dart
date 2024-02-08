import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class NotificationController {
  final users = FirebaseFirestore.instance.collection("user");
  Future<void> updateToken() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String? token = await FirebaseMessaging.instance.getToken();
    await users.doc(uid).update({'token ': token ?? ""});
  }

  void handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().f('Got a message whilst in the foreground!');
      Logger().f('Message data: ${message.data}');

      if (message.notification != null) {
        Logger().f(
            'Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {}
  }
}
