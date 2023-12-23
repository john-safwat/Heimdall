import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/UseCase/AddContactUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetContactsUseCase.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatView.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/Widgets/BottomSheetWidget.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/Widgets/ChatContactWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/NoChatErroWidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends BaseState<ChatView, ChatViewModel>
    implements ChatNavigator {
  @override
  void initState() {
    super.initState();
    viewModel!.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel!.showAddContactBottomSheet(),
            child: const Icon(
              BoxIcons.bx_chat,
              size: 32,
            ),
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
                        prefixIcon: const Icon(
                          EvaIcons.search,
                          size: 30,
                        ),
                        hintText: viewModel!.local!.findContact,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Consumer<ChatViewModel>(
                  builder: (context, value, child) {
                    if (value.errorMessage != null) {
                      return const Center(
                        child: Text("Error"),
                      );
                    } else if (value.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (value.contacts.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: NoChatErrorWidget(
                          image: viewModel!.getNoChatAnimation(),
                          errorMessage:
                              viewModel!.local!.youHaveNoContactsToChatWith,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) => ChatContactWidget(
                          contact: value.contacts[index],
                          uid: value.appConfigProvider!.user!.uid,
                          navigationFunction: value.goToContactChatScreen,
                        ),
                        itemCount: value.contacts.length,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ChatViewModel? initViewModel() {
    return ChatViewModel(
        addContactUseCase: injectAddContactUseCase(),
        getContactsUseCase: injectGetContactsUseCase());
  }

  @override
  goToContactChatScreen() {
    Navigator.pushNamed(context, ContactChatView.routeName);
  }

  @override
  showAddContactModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetWidget(
              controller: viewModel!.contactController,
              hintTitle: viewModel!.local!.enterEmail,
              buttonTitle: viewModel!.local!.addContact,
              addContactFunction: viewModel!.addContact,
            ));
  }
}
