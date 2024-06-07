import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:typengame/components/chat_bubble.dart';
import 'package:typengame/components/my_textfield.dart';
import 'package:typengame/services/auth/auth_service.dart';
import 'package:typengame/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(
      () {
        if (myFocusNode.hasFocus) {
          Future.delayed(
            const Duration(milliseconds: 300),
            () => scrollDown(),
          );
        }
      },
    );

    Future.delayed(
      const Duration(milliseconds: 300),
      () => scrollDown(),
    );
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: _buildMessageList()),
            _buildUserInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverId, senderId),
      builder: (context, snapshot) {
        //Errors
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //Loading
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderId"] == _authService.getCurrentUser()!.uid;

    //If the current user, the message is right aligned, if the receiving user, the message is left aligned

    return ChatBubble(
      message: data["message"],
      isCurrentUser: isCurrentUser,
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: MyTextfield(
              controller: _messageController,
              labelText: "Type a message",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          IconButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green),
            ),
            onPressed: _sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
