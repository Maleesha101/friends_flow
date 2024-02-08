import 'package:flutter/material.dart';
import 'package:friend_flow/models/user_model.dart';

import '../conts/app_colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.user,
  });
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: 66,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.kBlack, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user!.image),
        ),
      ),
    );
  }
}
