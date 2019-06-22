import 'package:flutter/material.dart';

class GradientText extends StatefulWidget {
  final String txt;
  final double fontSize;
  GradientText({this.txt, this.fontSize});
  @override
  State<StatefulWidget> createState() {
    return _GradientText();
  }
}

class _GradientText extends State<GradientText> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xffDA44bb),
      Color(0xff8921aa),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.txt,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w800,
        foreground: Paint()..shader = linearGradient,
      ),
    );
  }
}


class ColorText extends StatefulWidget {
  final String txt;
  final double fontSize;
  final Color color;
  ColorText({this.txt, this.fontSize, this.color});
  @override
  State<StatefulWidget> createState() {
    return _ColorText();
  }
}

class _ColorText extends State<ColorText> {
 
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.txt,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w800,
        color: widget.color,
      ),
    );
  }
}
