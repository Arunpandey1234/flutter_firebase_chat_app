import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_drawer.dart';
import '../services/auth/chat/chat_service.dart';
import '../services/auth/auth_service.dart';
import 'chat_page.dart';
import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('Home Page'),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.grey,
      elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading users"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentUser = FirebaseAuth.instance.currentUser;
        final users = snapshot.data as List<Map<String, dynamic>>;

        // Sort to show current user at the top
        users.sort((a, b) {
          if (a['uid'] == currentUser?.uid) return -1;
          if (b['uid'] == currentUser?.uid) return 1;
          return 0;
        });

        return ListView(
          children: users
              .where((userData) => userData['uid'] != currentUser?.uid)
              .map<Widget>((userData) {
            return UserTile(
              text: userData['email'],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverEmail: userData["email"],
                      receiverID: userData["uid"],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
