import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';

class ImageWidget extends StatelessWidget {
  String image ;
  Function onImageClick;
  bool isSelected;
  ImageWidget({required this.image,required this.onImageClick ,required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () => onImageClick(image),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        width: 80,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
              border: Border.all(width: isSelected?2:0 , color:isSelected? Theme.of(context).primaryColor:Colors.transparent),
              borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
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
