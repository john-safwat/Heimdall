import 'package:flutter/material.dart';

class ImagePickLocationModalBottomSheetWidget extends StatelessWidget {
  String title;

  String cameraTitle;
  String galleryTitle;
  Function openCamera;
  Function openGallery;

  ImagePickLocationModalBottomSheetWidget(
      {required this.title,
      required this.cameraTitle,
      required this.galleryTitle,
      required this.openCamera,
      required this.openGallery,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: (){ openCamera();},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(cameraTitle),
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: (){openGallery();},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(galleryTitle),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
