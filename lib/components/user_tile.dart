import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final Function() onTap;

  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
