import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/LockDetails/Widgets/ImageWidget.dart';

class GalleryCardWidget extends StatelessWidget {
  List<String> images;
  Function onImageClick;

  GalleryCardWidget(
      {required this.images, required this.onImageClick, super.key});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 220,
          child: Row(
            children: [
              Expanded(
                  child: ImageWidget(
                onImageClick: onImageClick,
                image: images[0],
                tag: "0",
              )),
            ],
          ),
        ),
      );
    }
    else if (images.length == 2) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 220,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: ImageWidget(
                    onImageClick: onImageClick,
                    image: images[0],
                    tag: "0",
                  )),
              const SizedBox(width: 10),
              Expanded(
                  child: ImageWidget(
                onImageClick: onImageClick,
                image: images[1],
                tag: "1",
              )),
            ],
          ),
        ),
      );
    }
    else if (images.length == 3) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 220,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: ImageWidget(
                      onImageClick: onImageClick, image: images[0], tag: "0")),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              child: ImageWidget(
                                  onImageClick: onImageClick,
                                  image: images[1],
                                  tag: "1")),
                          const SizedBox(height: 10),
                          Expanded(
                              child: ImageWidget(
                                  onImageClick: onImageClick,
                                  image: images[2],
                                  tag: "2")),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    else if (images.length == 4) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 220,
          child: Row(
            children: [
              Expanded(
                  child: ImageWidget(
                onImageClick: onImageClick,
                image: images[0],
                tag: "0",
              )),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                        child: ImageWidget(
                      onImageClick: onImageClick,
                      image: images[1],
                      tag: "1",
                    )),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: ImageWidget(
                                  onImageClick: onImageClick,
                                  image: images[2],
                                  tag: "2")),
                          const SizedBox(width: 10),
                          Expanded(
                              child: ImageWidget(
                                  onImageClick: onImageClick,
                                  image: images[3],
                                  tag: "3")),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 220,
        child: Row(
          children: [
            Expanded(
                child: ImageWidget(
              onImageClick: onImageClick,
              image: images[0],
              tag: "0",
            )),
            const SizedBox(width: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            child: ImageWidget(
                                onImageClick: onImageClick,
                                image: images[1],
                                tag: "1")),
                        const SizedBox(height: 10),
                        Expanded(
                            child: ImageWidget(
                                onImageClick: onImageClick,
                                image: images[2],
                                tag: "2")),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                            child: ImageWidget(
                                onImageClick: onImageClick,
                                image: images[3],
                                tag: "3")),
                        const SizedBox(height: 10),
                        Expanded(
                            child: ImageWidget(
                                onImageClick: onImageClick,
                                image: images[4],
                                tag: "4")),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
