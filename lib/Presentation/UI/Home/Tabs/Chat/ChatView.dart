import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatViewModel.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView , ChatViewModel> implements ChatNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(color: Colors.green,);
  }

  @override
  ChatViewModel? initViewModel() {
    return ChatViewModel();
  }
}
