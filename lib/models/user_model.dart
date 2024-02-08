// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String name;
  String image;
  String uid;
  String lastSeen;
  bool isOnline;
  String token;
  UserModel({
    required this.name,
    required this.image,
    required this.uid,
    required this.lastSeen,
    required this.isOnline,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'uid': uid,
      'lastSeen': lastSeen,
      'isOnline': isOnline,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] as String,
        image: map['image'] as String,
        uid: map['uid'] as String,
        lastSeen: map['lastSeen'] as String,
        isOnline: map['isOnline'] as bool,
        token: map['token'] ?? "");
  }
}
