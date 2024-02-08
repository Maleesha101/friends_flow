class MessageModel {
  final String uid;
  final String message;
  final String time;
  String id;
  MessageModel({
    required this.uid,
    required this.message,
    required this.time,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'message': message,
      'time': time,
      'id': id,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      uid: map['uid'] as String,
      message: map['message'] as String,
      time: map['time'] as String,
      id: map['id'] as String,
    );
  }
}
