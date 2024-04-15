import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Presentation/Models/Button/Button.dart';

class BottomSheetOptions extends StatelessWidget {
  LockCard card;
  List<Button> buttons;

  BottomSheetOptions({required this.card, required this.buttons, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75),
            itemBuilder: (context, index) => InkWell(
              onTap: (){buttons[index].onClickListener(card);},
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: buttons[index].id != 7?Theme.of(context).primaryColor : buttons[index].color,
                      ),
                      child: SvgPicture.asset(
                        buttons[index].icon,
                        color: buttons[index].id != 7 ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  SizedBox(
                    height: 20,
                    child: Text(buttons[index].title ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),),
                  )
                ],
              ),
            ),
            itemCount: buttons.length,
          ),
        ],
      ),
    );
  }
}
