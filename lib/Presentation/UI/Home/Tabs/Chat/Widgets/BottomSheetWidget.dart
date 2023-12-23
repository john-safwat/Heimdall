import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class BottomSheetWidget extends StatelessWidget {

  TextEditingController controller ;
  String hintTitle;
  String buttonTitle;
  Function addContactFunction;
  BottomSheetWidget({required this.controller ,required this.hintTitle , required this.buttonTitle ,required this.addContactFunction ,super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: const EdgeInsets.all(20),
        margin: MediaQuery.of(context).viewInsets,
        height: 200,
        child:Column(
          children: [
            TextFormField(
              controller: controller,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              cursorHeight: 20,
              decoration: InputDecoration(
                prefixIcon:const Icon(
                  EvaIcons.email,
                  size: 30,
                ),
                hintText:hintTitle,
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed:() => addContactFunction(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(buttonTitle),
                    ],
                  ),
                )
            )
          ],
        )
    );
  }
}
