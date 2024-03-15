import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  Function onImagePress ;
  String image;
  String tag;
  ImageWidget({required this.onImagePress,required this.image ,required this.tag, super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          overlayColor:
          MaterialStateProperty.all(Colors.transparent),
          onTap: () => onImagePress(
              image, tag),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            imageBuilder: (context, imageProvider) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: tag,
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
                child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.image,
                size: 45,
                color:
                Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ));
  }
}
