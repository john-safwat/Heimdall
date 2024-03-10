import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  String image ;
  String tag;
  Function onImageClick;
  ImageWidget({required this.image,required this.tag,required this.onImageClick , super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => onImageClick(image),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        imageBuilder: (context, imageProvider) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Hero(
            tag: tag,
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Icon(
            Icons.image,
            size: 45,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
