import 'package:flutter/material.dart';
import 'package:typengame/components/my_drawer.dart';
import 'package:typengame/components/user_tile.dart';
import 'package:typengame/pages/chat_page.dart';
import 'package:typengame/services/auth/auth_service.dart';
import 'package:typengame/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //Error
        if (snapshot.hasError) {
          return Text("Error");
        }

        //Loading
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //Display all users except current user

    if (_authService.getCurrentUser()!.email != userData["email"]) {
      return UserTile(
        text: userData["email"],
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
              receiverId: userData["uid"],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
