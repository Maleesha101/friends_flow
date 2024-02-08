import 'package:flutter/material.dart';

import 'profile_items.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProfileItems(
          headtext: 'Post',
          subtext: '35',
        ),
        ProfileItems(
          headtext: 'Followers',
          subtext: '1,550',
        ),
        ProfileItems(
          headtext: 'Following',
          subtext: '100',
        ),
      ],
    );
  }
}
