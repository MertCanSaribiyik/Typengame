import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const DrawerListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            fontSize: 18.0,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
