import 'package:flutter/material.dart';

import '../../../../models/contacts.dart';

// ignore: must_be_immutable
class ListTileWidget extends StatelessWidget {
  ListTileWidget({super.key, required this.contacts, this.onTap});
  final Contacts contacts;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            dense: true,
            isThreeLine: false,
            contentPadding: EdgeInsets.zero,
            minVerticalPadding: 0,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contacts.profilePicture),
            ),
            title: Text(
              contacts.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              contacts.email,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}
