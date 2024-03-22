import 'package:flutter/material.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

class LockCardWidget extends StatelessWidget {
  LockCard card;
  Function onCardClick;

  LockCardWidget({required this.card, required this.onCardClick, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => onCardClick(card),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 500,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Color(card.color),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20)),
        child:Column(
          children: [
            // the lock name
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      card.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color:
                          Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ),
            ),
            // the lock avatar
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  card.image,
                ),
              ),
            )
          ],
        ) ,
      ),
    );
  }
}
