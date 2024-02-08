import 'package:flutter/material.dart';
import 'package:friend_flow/conts/app_colors.dart';
import 'package:friend_flow/models/message_model.dart';
import 'package:friend_flow/models/user_model.dart';
import 'package:friend_flow/providers/chat_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../widgtes/custom_button.dart';
import '../widgtes/profile_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final UserModel user;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: size.height * .24,
                width: size.width * .9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    color: AppColor.secondaryColor),
                child: StreamBuilder(
                    stream:
                        Provider.of<ChatProvider>(context).startListenToUser(),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        UserModel? user = snap.data;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProfileWidget(
                              user: user,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user!.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  user.isOnline
                                      ? "Online"
                                      : timeago.format(
                                          DateTime.parse(user.lastSeen)),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: Provider.of<ChatProvider>(context, listen: false)
                      .getAllMessages(context),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snap.hasError) {
                      Logger().e(snap.error);
                      return const Center(
                        child: Text("no message"),
                      );
                    }
                    if (snap.hasData) {
                      List<MessageModel> messages = snap.data!;
                      Logger().d(messages);
                      return Consumer<ChatProvider>(
                          builder: (context, value, child) {
                        return ListView.builder(
                          reverse: true,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: widget.user.uid != messages[index].uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 14, top: 10, bottom: 11),
                                child: Container(
                                  // height: 70,
                                  width: 198,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight:
                                              const Radius.circular(20),
                                          bottomLeft: const Radius.circular(20),
                                          topLeft: widget.user.uid ==
                                                  messages[index].uid
                                              ? const Radius.circular(0)
                                              : const Radius.circular(20),
                                          topRight: widget.user.uid ==
                                                  messages[index].uid
                                              ? const Radius.circular(20)
                                              : const Radius.circular(0)),
                                      color: AppColor.bubbleColor),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        messages[index].message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: AppColor.subText),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: messages.length,
                        );
                      });
                    }
                    return Container();
                  }),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0, top: 14),
                child: Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                      color: AppColor.kWhite,
                      borderRadius: BorderRadius.circular(39),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 25,
                            color: AppColor.kBlack.withOpacity(0.1),
                            offset: const Offset(0, 4))
                      ]),
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextField(
                          controller:
                              Provider.of<ChatProvider>(context, listen: false)
                                  .msgController,
                          maxLines: 5,
                          minLines: 1,
                          decoration: const InputDecoration(
                              hintText: "Write a message",
                              border: InputBorder.none),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomButton(
                          ontap: () {
                            Provider.of<ChatProvider>(context, listen: false)
                                .startSenderMessage(context);
                          },
                          icon: "send",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
