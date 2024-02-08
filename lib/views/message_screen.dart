import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friend_flow/conts/app_colors.dart';
import 'package:friend_flow/models/conversation_model.dart';
import 'package:friend_flow/providers/chat_provider.dart';
import 'package:friend_flow/views/background/message_background.dart';
import 'package:friend_flow/views/chat_screen.dart';
import 'package:provider/provider.dart';

import '../widgtes/profile_widget.dart';

class MessegeScreen extends StatefulWidget {
  const MessegeScreen({super.key});

  @override
  State<MessegeScreen> createState() => _MessegeScreenState();
}

class _MessegeScreenState extends State<MessegeScreen> {
  @override
  Widget build(BuildContext context) {
    return MessageBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(
              "assets/icons/button_back.svg",
              height: 19,
              width: 19,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: SvgPicture.asset(
                "assets/icons/menu.svg",
                height: 19,
                width: 19,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Message",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  height: 48,
                  width: 288,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.kWhite,
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.kBlack.withOpacity(0.1),
                            blurRadius: 25,
                            offset: const Offset(0, 4))
                      ]),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset("assets/images/search.png"),
                        ),
                      ),
                      Text(
                        'Search for contacts',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColor.kGray),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: StreamBuilder(
                      stream: Provider.of<ChatProvider>(context, listen: false)
                          .fetchonversations(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          List<ConversationModel> conversations =
                              snapshot.data!;
                          return ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              itemCount: conversations.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Provider.of<ChatProvider>(context,
                                            listen: false)
                                        .setUser(conversations[index].user);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                            user: conversations[index].user,
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    height: 103,
                                    width: 327,
                                    decoration: BoxDecoration(
                                        color: AppColor.kWhite,
                                        borderRadius: BorderRadius.circular(33),
                                        border: Border.all(
                                            color: AppColor.strokeColor)),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Center(
                                          child: ProfileWidget(
                                            user: conversations[index].user,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              conversations[index].user.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            Text(
                                              conversations[index].lastMesssage,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                        return Container();
                      })),
            ],
          ),
        ),
      ),
    ));
  }
}
