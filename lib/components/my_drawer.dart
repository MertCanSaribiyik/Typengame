import 'package:flutter/material.dart';
import 'package:typengame/services/auth/auth_service.dart';
import 'package:typengame/components/drawer_list_tile.dart';
import 'package:typengame/pages/home_page.dart';
import 'package:typengame/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _logout() async {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: DrawerHeader(
              child: Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 60,
              ),
            ),
          ),
          DrawerListTile(
            icon: Icons.home,
            text: "HOME",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          DrawerListTile(
            icon: Icons.settings,
            text: "SETTINGS",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          DrawerListTile(
            icon: Icons.logout,
            text: "LOGOUT",
            onTap: _logout,
          )
        ],
      ),
    );
  }
}
