import 'package:flutter/material.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            color: Theme.of(context).colorScheme.background,
            padding: EdgeInsets.zero,
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          drawerListtile("H O M E", () => Navigator.pop(context), Icons.home),
          drawerListtile("S E T T I N G S", () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            );
          }, Icons.settings),
        ],
      ),
    );
  }

  Widget drawerListtile(
    String text,
    Function()? onTap,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(
        title: Text(text),
        leading: Icon(icon),
        onTap: onTap,
      ),
    );
  }
}
