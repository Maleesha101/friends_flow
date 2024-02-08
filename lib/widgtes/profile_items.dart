import 'package:flutter/material.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({
    super.key,
    required this.headtext,
    required this.subtext,
  });
  final String headtext;
  final String subtext;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          headtext,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          subtext,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
