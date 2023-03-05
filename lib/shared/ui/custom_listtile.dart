// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: const Icon(IconlyBroken.arrow_right_2),
      tileColor:
          Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://api.dicebear.com/5.x/fun-emoji/png?seed=$title'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
