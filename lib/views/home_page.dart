import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friend_flow/conts/app_colors.dart';

import 'background/home_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeBackground(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Friends Flow",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/icons/notif.svg"),
                )
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Feed",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          margin: const EdgeInsets.only(left: 10),
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 12,
                                    color: AppColor.kPink,
                                    offset: Offset(0, 2))
                              ],
                              shape: BoxShape.circle,
                              gradient: AppColor.kGradient),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: SvgPicture.asset(
                              "assets/icons/only_plus.svg",
                              color: AppColor.kBlack,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ...List.generate(
                            10,
                            (index) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(),
                                ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                            height: 288,
                            width: 328,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: AppColor.kGray,
                                      offset: Offset(0, 5),
                                      blurRadius: 20,
                                      spreadRadius: 0)
                                ],
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/images/building-2.jpg",
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                ListTile(
                                  subtitle: Text(
                                    "2 hrs ago",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: AppColor.captionColor),
                                  ),
                                  title: Text(
                                    "Dennis Reynolds",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColor.kWhite),
                                  ),
                                  leading: const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/profile_image.jpg",
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: AppColor.kWhite,
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            )),
                      ),
                      itemCount: 10,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
