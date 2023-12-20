import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatNavigator.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatViewModel.dart';
import 'package:provider/provider.dart';
class ContactChatView extends StatefulWidget {
  static const String routeName = "ContactChatScreen";
  const ContactChatView({super.key});
  @override
  State<ContactChatView> createState() => _ContactChatViewState();
}
class _ContactChatViewState extends BaseState<ContactChatView,ContactChatViewModel>implements ContactChatNavigator  {

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
          PopupMenuButton<SampleItem>(
            color: Theme.of(context).scaffoldBackgroundColor,
            initialValue: viewModel!.selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (SampleItem item) => viewModel!.changeSelectedItem(item),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemOne,
                child: Text(
                  'Delete Contact',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemTwo,
                child: Text(
                  'Block Contact',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
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
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image(image: AssetImage('assets/images/appIcon.png')),
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
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Theme.of(context).primaryColor,
                      cursorHeight: 20,
                      decoration:  InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () => value.showModalBottomSheet(),
                          child: const Icon(
                            Icons.image,
                            size: 30,
                          ),
                        ),
                        hintText: viewModel!.local!.send_message,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: const SizedBox(
                      height: 45,
                      width: 24,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.mic),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
    ),
    ),
    ),
    );
  }
  @override
  ContactChatViewModel? initViewModel() {
    return ContactChatViewModel();
  }
  @override
  showImageModalBottomSheet() {}
}

