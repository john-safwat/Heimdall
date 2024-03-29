import 'package:flutter/material.dart';
import 'package:heimdall/Presentation/UI/LockDetails/Widgets/ImageWidget.dart';

class GalleryCardWidget extends StatelessWidget {
  List<String> images;
  Function onImageClick;
  Function onMoreImagesPress;
  GalleryCardWidget(
      {required this.images, required this.onImageClick ,required this.onMoreImagesPress, super.key});

  @override
  Widget build(BuildContext context) {
    if (images.length == 1) {
      return SizedBox(
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
      );
    }
    else if (images.length == 2) {
      return SizedBox(
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
      );
    }
    else if (images.length == 3) {
      return SizedBox(
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
      );
    }
    else if (images.length == 4) {
      return SizedBox(
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
      );
    }
    return SizedBox(
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
                          child: Stack(
                            children: [
                              ImageWidget(
                                  onImageClick: onImageClick,
                                  image: images[4],
                                  tag: "4"),
                              Positioned.fill(
                                  child: InkWell(
                                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                                    onTap: () => onMoreImagesPress(),
                                    child: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: FittedBox(
                                        child: Text(
                                          "+${images.length-4}",
                                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                                        ),
                                      ),
                                    ),
                                  )
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
