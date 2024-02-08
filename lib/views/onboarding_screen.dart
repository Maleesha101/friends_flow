import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friend_flow/conts/app_colors.dart';
import 'package:friend_flow/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int indexNum = 0;
  _onPageChanged(index) {
    setState(() {
      indexNum = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Provider.of<AuthProvider>(context, listen: false).listenAuth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    PageController pageController = PageController();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -20,
              child: Image.asset(
                "assets/images/bg.png",
                height: 600,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome to",
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
                Text("Friends Flow",
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 300,
                  width: size.width,
                  child: PageView.builder(
                    itemCount: 2,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.asset(
                            "assets/images/hero$indexNum.png",
                            height: 240,
                          ),
                        ],
                      );
                    },
                    onPageChanged: _onPageChanged,
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  effect: const WormEffect(
                      activeDotColor: AppColor.kBlack,
                      dotHeight: 11,
                      dotWidth: 11,
                      dotColor: AppColor.kBlack,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1),
                  count: 2,
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              height: 200,
              width: 200,
              child: GestureDetector(
                onTap: () {
                  print("$indexNum");
                },
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/Button-next$indexNum.png",
                      height: 240,
                    ),
                    Positioned(
                      left: 105,
                      top: 110,
                      child: Row(
                        children: [
                          Text(
                            "Next",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: indexNum == 0
                                        ? AppColor.kWhite
                                        : AppColor.kBlack),
                          ),
                          const SizedBox(width: 16.0),
                          SvgPicture.asset("assets/icons/arrow_forward.svg",
                              color: indexNum == 0
                                  ? AppColor.kWhite
                                  : AppColor.kBlack),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
