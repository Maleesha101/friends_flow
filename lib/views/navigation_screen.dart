// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friend_flow/controllers/notification_controller.dart';
import 'package:friend_flow/conts/app_colors.dart';
import 'package:friend_flow/providers/user_provider.dart';
import 'package:friend_flow/views/contact_screen.dart';
import 'package:friend_flow/views/home_page.dart';
import 'package:friend_flow/views/message_screen.dart';
import 'package:friend_flow/views/profile_page.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../widgtes/custom_button.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    NotificationController().updateToken();
    NotificationController().handleForegroundMessages();
    NotificationController().setupInteractedMessage();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      Logger().e("message");
      Provider.of<UserProvider>(context, listen: false)
          .updateOnlineStatus(true, context);
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .updateOnlineStatus(false, context);
      Logger().e("flase");
    }
  }

  int _selectIndex = 0;
  final _pages = [
    const HomePage(),
    const MessegeScreen(),
    const Text("fav"),
    const ProfileScreen()
  ];
  void _clicked(index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: _pages,
      ),
      floatingActionButton: CustomButton(
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Contacts()),
          );
        },
        icon: "plus",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 82,
        decoration: BoxDecoration(
          color: AppColor.kWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                blurRadius: 15,
                color: AppColor.kBlack.withOpacity(.15),
                offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => _clicked(0),
              child: SvgPicture.asset(
                "assets/icons/home.svg",
                color:
                    _selectIndex == 0 ? AppColor.primaryColor : AppColor.kBlack,
              ),
            ),
            GestureDetector(
              onTap: () => _clicked(1),
              child: SvgPicture.asset(
                "assets/icons/message.svg",
                color:
                    _selectIndex == 1 ? AppColor.primaryColor : AppColor.kBlack,
              ),
            ),
            const SizedBox(),
            GestureDetector(
              onTap: () => _clicked(2),
              child: SvgPicture.asset(
                "assets/icons/favorite_border.svg",
                color:
                    _selectIndex == 2 ? AppColor.primaryColor : AppColor.kBlack,
              ),
            ),
            GestureDetector(
              onTap: () => _clicked(3),
              child: SvgPicture.asset(
                "assets/icons/profile.svg",
                color:
                    _selectIndex == 3 ? AppColor.primaryColor : AppColor.kBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
