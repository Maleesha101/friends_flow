import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friend_flow/conts/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.icon, required this.ontap});
  final String icon;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23), color: AppColor.kBlack),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Transform.rotate(
                angle: -math.pi / 4,
                child: SvgPicture.asset(
                  "assets/icons/$icon.svg",
                  height: 20,
                  width: 20,
                )),
          ),
        ),
      ),
    );
  }
}
