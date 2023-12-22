import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatViewModel.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ContactChatView extends StatefulWidget {
  static const String routeName = "ContactChatScreen";
  const ContactChatView({super.key});
  @override
  State<ContactChatView> createState() => _ContactChatViewState();
}
//hello this a test
//SECOND TEST
class _ContactChatViewState
    extends BaseState<ContactChatView, ContactChatViewModel>
    implements ContactChatNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel!,
      child: Consumer<ContactChatViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.call),
                iconSize: 22,
                onPressed: () {},
              ), //IconButton
              PopupMenuButton<Widget>(
                color: Theme.of(context).scaffoldBackgroundColor,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Widget>>[
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
                      border:
                      Border.all(color: Theme.of(context).primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(1000)),
                  child: CachedNetworkImage(
                    imageUrl:  "https://imgv3.fotor.com/images/slider-image/A-clear-image-of-a-woman-wearing-red-sharpened-by-Fotors-image-sharpener.jpg",
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Image(image: imageProvider , fit: BoxFit.cover,) ,),
                    placeholder: (context, url) =>  const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error , color: Theme.of(context).primaryColor,),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Contact Name",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              const Expanded(
                child: SizedBox(
                  width: double.infinity,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () => value.showModalBottomSheet(),
                            child: Icon(
                              EvaIcons.paper_plane,
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
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const CircleBorder())),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          child: Icon(Icons.mic),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ContactChatViewModel? initViewModel() {
    return ContactChatViewModel();
  }
}
