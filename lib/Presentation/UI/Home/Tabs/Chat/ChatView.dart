import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/Widgets/Widgets.dart';
import 'package:icons_plus/icons_plus.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView, ChatViewModel>
    implements ChatNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(viewModel!.local!.messages,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            )),
        bottom:PreferredSize(
          preferredSize: const Size(double.infinity , 80),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Theme.of(context).primaryColor,
              cursorHeight: 20,
              decoration:const InputDecoration(
                prefixIcon: Icon(
                  EvaIcons.search,
                  size: 30,
                ),
                hintText: "Find Contact",
              ),
            ),
          ),
        )
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return UserWidget();
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ],
      ),
    );
  }
  @override
  ChatViewModel? initViewModel() {
    return ChatViewModel();
  }

}
