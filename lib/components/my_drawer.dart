import 'package:flutter/material.dart';
import '../page/setting_page.dart';
import '../services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key});

  void logout() {
    // get auth service instance
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              // Home List title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title:const Text("H O M E"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    // Navigate to home page
                    Navigator.pop(context);
                  },
                ),
              ),

              // setting list title
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    // Navigate to settings page
                    Navigator.pop(context);

                    // navigate to settings page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingPage()),
                    );
                  },
                ),
              ),
            ],
          ),

          // logout list title
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
