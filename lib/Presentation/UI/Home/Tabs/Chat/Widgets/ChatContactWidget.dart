import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  String name;
  String message;
  String imageURL;
  String time;
  Function navigationFunction;

  UserWidget(
      {required this.name,
      required this.message,
      required this.imageURL,
      required this.time,
      required this.navigationFunction,
      super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() =>  navigationFunction(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(1000)),
              child: CachedNetworkImage(
                imageUrl: imageURL,
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
            const SizedBox(width: 15,),
            Text(
              time,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
