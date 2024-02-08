import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friend_flow/conts/app_colors.dart';
import 'package:friend_flow/views/background/profile_background.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgtes/tab_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _HomePageState();
}

class _HomePageState extends State<ProfileScreen> {
  String _selectedTab = "photos";

  void _changeTab(String tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileBackground(
      index: 1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: math.pi / 4,
                    child: Container(
                      width: 95,
                      height: 98,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColor.kBlack),
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut(context);
                    },
                    child: ClipPath(
                      clipper: ProfileClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.kBlack.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Image.network(
                          Provider.of<AuthProvider>(context).user!.photoURL!,
                          width: 115,
                          height: 115,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text(
                Provider.of<AuthProvider>(context).user!.displayName!,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                Provider.of<AuthProvider>(context).user!.email!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 30,
              ),
              const TabWidget(),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _changeTab("photos"),
                    child: SvgPicture.asset(
                      "assets/icons/Button-photos.svg",
                      width: 20,
                      height: 26,
                      color: _selectedTab == "photos"
                          ? AppColor.primaryColor
                          : AppColor.kBlack,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeTab("saved"),
                    child: SvgPicture.asset(
                      "assets/icons/Button-saved.svg",
                      width: 20,
                      height: 26,
                      color: _selectedTab == "saved"
                          ? AppColor.primaryColor
                          : AppColor.kBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: StaggeredGrid.count(
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      crossAxisCount: 2,
                      children: List.generate(
                        4,
                        (index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(19),
                            child: Image.asset(
                              "assets/images/Rectangle-${index + 1}.png",
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileClipper extends CustomClipper<Path> {
  double radius = 25;
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width / 2 - radius, radius)
      ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + radius, radius)
      ..lineTo(size.width - radius, size.height / 2 - radius)
      ..quadraticBezierTo(size.width, size.height / 2, size.width - radius,
          size.height / 2 + radius)
      ..lineTo(size.width / 2 + radius, size.height - radius)
      ..quadraticBezierTo(size.width / 2, size.height, size.width / 2 - radius,
          size.height - radius)
      ..lineTo(radius, size.height / 2 + radius)
      ..quadraticBezierTo(0, size.height / 2, radius, size.height / 2 - radius)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
