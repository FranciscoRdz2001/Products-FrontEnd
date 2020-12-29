import 'package:flutter/material.dart';
import 'package:productsfrontend/src/styles/text_style.dart';

class CustomButton extends StatelessWidget {
  final _textStyles = new TextStyles();
  double heightSize;
  double widhtSize;
  Color color;
  String text;
  IconData icon;
  Function function;
  CustomButton({this.heightSize, this.widhtSize, this.color, this.text, this.icon, this.function});
  @override
  Widget build(BuildContext context) => GestureDetector(
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        height: heightSize * 0.1,
        width: widhtSize * 0.3,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$text", style: _textStyles.buttonText.copyWith(color: color), textAlign: TextAlign.center,),
            SizedBox(height: 2.5,),
            Icon(icon, color: color,)
          ],
        ),
      ),
    ),
    onTap: () => function == null ? {} : function(),
  );
}
