import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/user_controller.dart';
import '../conts/app_colors.dart';
import '../models/user_model.dart';
import '../providers/chat_provider.dart';
import '../widgtes/profile_widget.dart';
import 'chat_screen.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: UserController().getAllUers(context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<UserModel> userList = [];
            for (var user in snapshot.data!.docs) {
              UserModel u =
                  UserModel.fromMap(user.data() as Map<String, dynamic>);
              userList.add(u);
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: userList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<ChatProvider>(context, listen: false)
                        .setUser(userList[index]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            user: userList[index],
                          ),
                        ));
                  },
                  child: Container(
                    height: 103,
                    width: 327,
                    decoration: BoxDecoration(
                        color: AppColor.kWhite,
                        borderRadius: BorderRadius.circular(33),
                        border: Border.all(color: AppColor.strokeColor)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Center(
                          child: ProfileWidget(
                            user: userList[index],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userList[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Hey, how’s it goin?",
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
