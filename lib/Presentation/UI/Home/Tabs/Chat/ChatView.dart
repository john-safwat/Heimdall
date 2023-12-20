import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/Widgets/BottomSheetWidget.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/Widgets/ChatContactWidget.dart';
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
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => viewModel!.showAddContactBottomSheet(),
          child:const Icon(BoxIcons.bx_chat , size: 32,),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(viewModel!.local!.messages,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: viewModel!.searchController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: Theme.of(context).primaryColor,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      prefixIcon:const Icon(
                        EvaIcons.search,
                        size: 30,
                      ),
                      hintText:viewModel!.local!.findContact,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return UserWidget(
                    name: "Sadie Adler",
                    message: "Hello There Iam waiting for You ",
                    imageURL:
                        "https://imgv3.fotor.com/images/slider-image/A-clear-image-of-a-woman-wearing-red-sharpened-by-Fotors-image-sharpener.jpg",
                    time: "09:32 PM",
                    navigationFunction: viewModel!.goToContactChatScreen,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  ChatViewModel? initViewModel() {
    return ChatViewModel();
  }

  @override
  goToContactChatScreen() {
    Navigator.pushNamed(context, ContactChatView.routeName);
  }

  @override
  showAddContactModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) =>BottomSheetWidget(
        controller: viewModel!.contactController,
        hintTitle: viewModel!.local!.enterEmail,
        buttonTitle: viewModel!.local!.addContact,
        addContactFunction: viewModel!.addContact,
      ));
  }
}
