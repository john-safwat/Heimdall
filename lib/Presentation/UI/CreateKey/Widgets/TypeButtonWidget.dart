import 'package:flutter/material.dart';

class TypeButtonWidget extends StatefulWidget {
  bool selected;

  String title;
  Function onPress;
  int id;

  TypeButtonWidget(
      {required this.id,
      required this.title,
      required this.onPress,
      required this.selected,
      super.key});

  @override
  State<TypeButtonWidget> createState() => _TypeButtonWidgetState();
}

class _TypeButtonWidgetState extends State<TypeButtonWidget> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () => widget.onPress(widget.id),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
          decoration: BoxDecoration(
              color: widget.selected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              border:
                  Border.all(width: 2, color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: widget.selected
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
