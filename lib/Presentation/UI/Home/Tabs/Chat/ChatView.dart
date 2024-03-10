import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/UseCase/AddContactUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetContactsUseCase.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatView.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/ChatViewModel.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Chat/Widgets/ChatContactWidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
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
    viewModel.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.showAddContactBottomSheet(),
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
                    Text(viewModel.local!.messages,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Theme.of(context).primaryColor,
                      cursorHeight: 20,
                      onChanged: (value) {
                        viewModel.search(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          EvaIcons.search,
                          size: 30,
                        ),
                        hintText: viewModel.local!.findContact,
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
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Row(),
                              Lottie.asset("assets/animations/error.json" , width: viewModel.mediaQuery!.width *0.5),
                              const SizedBox(height: 40),
                              Text(value.errorMessage! , style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,)
                            ],
                          )
                      );
                    } else if (value.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (value.contacts.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(viewModel.getNoChatAnimation()),
                            const SizedBox(height: 20),
                            Text(value.local!.youHaveNoContactsToChatWith , style: Theme.of(context).textTheme.titleMedium,textAlign: TextAlign.center,)
                          ],
                        )
                      );
                    } else {
                      return ListView.builder(
                        itemBuilder: (context, index) => ChatContactWidget(
                          contact: value.contacts[index],
                          uid: value.appConfigProvider!.user!.uid,
                          navigationFunction: value.goToContactChatScreen,
                          tag: viewModel.constants.userImageTag,
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
  ChatViewModel initViewModel() {
    return ChatViewModel(
        addContactUseCase: injectAddContactUseCase(),
        getContactsUseCase: injectGetContactsUseCase());
  }

  @override
  goToContactChatScreen(Contact contact) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactChatView(contact: contact)));
  }

}
