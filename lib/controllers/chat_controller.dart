import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:friend_flow/models/conversation_model.dart';
import 'package:friend_flow/models/message_model.dart';
import 'package:friend_flow/models/user_model.dart';
import 'package:friend_flow/providers/chat_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ChatController {
  CollectionReference users = FirebaseFirestore.instance.collection("user");
  final firestore = FirebaseFirestore.instance;
  Stream<UserModel> listenToUser(String uid) {
    return users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  CollectionReference msgCollection =
      FirebaseFirestore.instance.collection("Messages");

  CollectionReference conversationCollection =
      FirebaseFirestore.instance.collection("Conversations");
  Future<void> sendMessage(
    ConversationModel senderModel,
    ConversationModel receiverModel,
    MessageModel message,
    BuildContext context,
  ) async {
    String messageId = msgCollection.doc().id;

    message.id = messageId;

    await msgCollection
        .doc(senderModel.user.uid)
        .collection(receiverModel.user.uid)
        .doc(messageId)
        .set(message.toMap())
        .then((value) {
      Logger().f("Messsage send form ${senderModel.user.name}");
      Provider.of<ChatProvider>(context, listen: false).clearMessages();
    });
    await msgCollection
        .doc(receiverModel.user.uid)
        .collection(senderModel.user.uid)
        .doc(messageId)
        .set(message.toMap())
        .then((value) =>
            Logger().f("Messsage send form ${receiverModel.user.name}"));

    conversationCollection
        .doc(senderModel.user.uid)
        .collection("List")
        .doc(receiverModel.user.uid)
        .set(receiverModel.toMap());
  }

  Stream<List<ConversationModel>> getConversations(String uid) {
    List<ConversationModel> list = [];
    return conversationCollection
        .doc(uid)
        .collection("List")
        .orderBy("lastTime", descending: true)
        .snapshots()
        .map((event) {
      list.clear();
      for (var element in event.docs) {
        ConversationModel conModel = ConversationModel.fromMap(element.data());
        list.add(conModel);
      }
      return list;
    });
  }

  Stream<List<MessageModel>> getMessages(String myUid, String uid) {
    List<MessageModel> list = [];
    return msgCollection
        .doc(myUid)
        .collection(uid)
        .orderBy('time', descending: true)
        .snapshots()
        .map((event) {
      list.clear();
      for (var element in event.docs) {
        MessageModel msgModel = MessageModel.fromMap(element.data());
        list.add(msgModel);
      }
      return list;
    });
  }
}
