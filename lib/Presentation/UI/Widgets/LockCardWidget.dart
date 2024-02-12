import 'package:flutter/material.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

class LockCardWidget extends StatelessWidget {

  LockCard card;
  Function onCardClick;
  LockCardWidget({required this.card, required this.onCardClick , super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onCardClick(card),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            // background of the card
            Container(
              width: MediaQuery.sizeOf(context).width ,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Color(card.color),
                  borderRadius: BorderRadius.circular(20)),
            ),
            // the gradient with the lock name and image
            Positioned.fill(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Colors.transparent
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  child: Column(
                    children: [
                      // the lock name
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                card.name,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ),
                            ),
                            const Expanded(child: SizedBox())
                          ],
                        ),
                      ),
                      // the lock avatar
                      Expanded(
                        child: Image.asset(
                          card.image,
                          width: double.infinity,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
