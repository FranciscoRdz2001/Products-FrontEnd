import 'package:flutter/material.dart';
import 'package:productsfrontend/src/styles/text_style.dart';

class CustomHeader extends StatelessWidget {
  final textStyle = new TextStyles();
  double widhtSize;
  String title;

  CustomHeader({this.widhtSize, this.title});

  @override
  Widget build(BuildContext context) => Container(
        width: widhtSize,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            "$title",
            style: textStyle.titleApp,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
