import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

enum SampleItem { itemOne, itemTwo }

class ContactChatView extends StatefulWidget {
  const ContactChatView({super.key});
  static const String routeName = "ContactChatScreen";

  @override
  State<ContactChatView> createState() => _ContactChatScreenState();
}
class _ContactChatScreenState extends State<ContactChatView> {
  SampleItem? selectedMenu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.call),
            iconSize: 22,
            onPressed: () {},
          ), //IconButton
          PopupMenuButton<SampleItem>(
            color: Theme.of(context).scaffoldBackgroundColor,
            initialValue: selectedMenu,
            // Callback that sets the selected popup menu item.
            onSelected: (SampleItem item) {
              setState(() {
                selectedMenu = item;
              });
            },
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context).primaryColor,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    prefixIcon: InkWell(
                      child: Icon(
                        Icons.image,
                        size: 30,
                      ),
                    ),
                    hintText: "Send Message",
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.mic_rounded,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
