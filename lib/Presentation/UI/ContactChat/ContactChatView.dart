import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Contact/Contact.dart';
import 'package:heimdall/Domain/UseCase/GetMessagesUseCase.dart';
import 'package:heimdall/Domain/UseCase/SendMessageUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateContactUseCase.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatViewModel.dart';
import 'package:heimdall/Presentation/UI/ContactChat/Widgets/MessagesWidget.dart';
import 'package:provider/provider.dart';

class ContactChatView extends StatefulWidget {
  static const String routeName = "ContactChatScreen";
  Contact? contact;

  ContactChatView({this.contact, super.key});

  @override
  State<ContactChatView> createState() => _ContactChatViewState();
}

class _ContactChatViewState
    extends BaseState<ContactChatView, ContactChatViewModel>
    implements ContactChatNavigator {
  var messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.contact = widget.contact!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<ContactChatViewModel>(
        builder: (context, value, child) => SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leadingWidth: 30,
              actions: <Widget>[
                PopupMenuButton<Widget>(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Widget>>[
                    PopupMenuItem<Widget>(
                      onTap: () => value.removeContact(),
                      child: Row(
                        children: [
                          Text(
                            value.local!.deleteContact,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<Widget>(
                      onTap: () => value.blockContact(),
                      child: Row(
                        children: [
                          Text(
                            value.local!.blockContact,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ], //<
              title: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(1000)),
                    child: CachedNetworkImage(
                      imageUrl: viewModel.appConfigProvider!.user!.uid ==
                              viewModel.contact.firstUserUID
                          ? viewModel.contact.secondUserImage
                          : viewModel.contact.firstUserImage,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Hero(
                        tag: viewModel.constants.userImageTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      viewModel.appConfigProvider!.user!.uid ==
                              viewModel.contact.firstUserUID
                          ? viewModel.contact.secondUserName
                          : viewModel.contact.firstUserName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                  stream: viewModel.loadChat(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return ErrorWidget(viewModel
                          .handleErrorMessage(snapshot.error! as Exception));
                    } else {
                      viewModel.messages = snapshot.data!.docs
                          .map((e) => e.data().toDomain())
                          .toList();
                      viewModel.sortMessagesByNewTime();
                      return ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) =>
                            MessageWidget(message: viewModel.messages[index]),
                        itemCount: viewModel.messages.length,
                      );
                    }
                  },
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: viewModel.controller,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () => viewModel.sendMessage(),
                              child: Icon(
                                EvaIcons.paperPlane,
                                size: 25,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            prefixIcon: InkWell(
                              onTap: () => value.showModalBottomSheet(),
                              child: const Icon(
                                Icons.image,
                                size: 25,
                              ),
                            ),
                            hintText: value.local!.sendMessage,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ContactChatViewModel initViewModel() {
    return ContactChatViewModel(
        sendMessageUseCase: injectSendMessageUseCase(),
        getMessagesUseCase: injectGetMessagesUseCase(),
        updateContactUseCase: injectUpdateContactUseCase()
    );
  }
}
