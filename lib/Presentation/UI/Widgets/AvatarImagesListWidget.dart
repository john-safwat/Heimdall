import 'package:flutter/material.dart';

class AvatarImagesListWidget extends StatefulWidget {
  List<String> images;

  String selectedItem;
  Function onSelectedItemPress;

  AvatarImagesListWidget(
      {required this.selectedItem,
      required this.images,
      required this.onSelectedItemPress,
      super.key});

  @override
  State<AvatarImagesListWidget> createState() => _AvatarImagesListWidgetState();
}

class _AvatarImagesListWidgetState extends State<AvatarImagesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(200)
            ),
          ),
          const SizedBox(height: 25,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  widget.onSelectedItemPress(widget.images[index]);
                  setState(() {
                    widget.selectedItem = widget.images[index];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: index == widget.images.indexOf(widget.selectedItem) ? Theme.of(context).primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Theme.of(context).primaryColor)
                  ),
                  child: Image.asset(widget.images[index]),
                ),
              ),
              itemCount: widget.images.length,
            ),
          ),
        ],
      ),
    );
  }
}
