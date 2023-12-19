import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/ContactChat/ContactChatView.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({super.key});
  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor , width: 2),
            borderRadius: BorderRadius.circular(1000)
          ),
          child: const ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: Image(image: AssetImage('assets/images/appIcon.png')),
          ),
        ),
        const SizedBox(width: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Name",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "Last Message",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        IconButton(onPressed: (){
          goToContactChatScreen();
        }, icon: Icon(Icons.arrow_circle_right)),
        const Expanded(child: SizedBox()),
        Text(
          "8:45",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
  goToContactChatScreen() {
    Navigator.pushNamed(context, ContactChatView.routeName);
  }
}
