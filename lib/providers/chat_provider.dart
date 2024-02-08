import 'package:flutter/material.dart';
import 'package:friend_flow/controllers/chat_controller.dart';
import 'package:friend_flow/models/conversation_model.dart';
import 'package:friend_flow/models/message_model.dart';
import 'package:friend_flow/models/user_model.dart';
import 'package:friend_flow/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  UserModel? _me;
  UserModel? get me => _me;
  UserModel? _user;
  UserModel? get user => _user;
  final TextEditingController _msgController = TextEditingController();
  TextEditingController get msgController => _msgController;

  Stream<UserModel> startListenToUser() {
    final stream = ChatController().listenToUser(_user!.uid);
    stream.listen((event) {
      _user = event;
    });
    return stream;
  }

  void setUser(UserModel model) {
    _user = model;
    notifyListeners();
  }

  Future<void> startSenderMessage(BuildContext context) async {
    if (_msgController.text.isNotEmpty) {
      final user = Provider.of<AuthProvider>(context, listen: false).user!;
      _me = UserModel(
          name: user.displayName!,
          image: user.photoURL!,
          uid: user.uid,
          lastSeen: DateTime.now().toString(),
          isOnline: true,
          token: "");
      MessageModel message = MessageModel(
        uid: _me!.uid,
        message: _msgController.text,
        time: DateTime.now().toString(),
        id: "",
      );
      ConversationModel senderModel = ConversationModel(
          user: _user!,
          lastMesssage: _msgController.text,
          lastTime: DateTime.now().toString());
      ConversationModel receiverModel = ConversationModel(
          user: _me!,
          lastMesssage: _msgController.text,
          lastTime: DateTime.now().toString());
      ChatController()
          .sendMessage(senderModel, receiverModel, message, context);
    }
  }

  void clearMessages() {
    _msgController.clear();
    notifyListeners();
  }

  Stream<List<ConversationModel>> fetchonversations(BuildContext context) {
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;

    return ChatController().getConversations(uid);
  }

  Stream<List<MessageModel>> getAllMessages(BuildContext context) {
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;

    return ChatController().getMessages(uid, _user!.uid);
  }
}
