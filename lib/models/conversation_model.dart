// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:friend_flow/models/user_model.dart';

class ConversationModel {
  final UserModel user;

  final String lastMesssage;
  final String lastTime;
  ConversationModel({
    required this.user,
    required this.lastMesssage,
    required this.lastTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'lastMesssage': lastMesssage,
      'lastTime': lastTime,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      lastMesssage: map['lastMesssage'] as String,
      lastTime: map['lastTime'] as String,
    );
  }
}
