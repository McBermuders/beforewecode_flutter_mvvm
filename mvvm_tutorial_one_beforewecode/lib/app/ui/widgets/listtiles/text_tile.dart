//concrete implementation
//flutter
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/regular_text_card.dart';

class TextTile extends StatelessWidget {
  final RegularTextCard textCard;
  final double widthFactor;

  const TextTile(
      {required this.textCard, required this.widthFactor, required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ListTile(
      title: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Text(
          textCard.title,
          style: textTheme.caption?.copyWith(
            color: Colors.black,
            fontWeight: textCard.bold ? FontWeight.w900 : FontWeight.w300,
            letterSpacing: 1.0,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
