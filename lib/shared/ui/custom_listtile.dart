// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.leadingIcon,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final String leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: const Icon(IconlyBold.arrow_right),
      // tileColor:
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage(leadingIcon),
      ),
    );
  }
}
