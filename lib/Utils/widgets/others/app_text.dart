import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight bold;
  final Color? color;
  final bool justifyText;
  final bool alignText;
  final bool underline;
  final bool ellipsis;
  final Function()? onTap;

  const AppText(
    this.text, {
    Key? key,
    this.size = 18,
    this.bold = FontWeight.normal ,
    this.color = Colors.black,
    this.justifyText = false,
    this.alignText = false,
    this.onTap,
    this.underline = false,
    this.ellipsis = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: onTap != null ? onTap : null,
      child: Text(
        text,
        textAlign: justifyText ? TextAlign.center :null,
        style: TextStyle(
          fontFamily: "Roboto Condensed",
          fontWeight: bold,
          overflow: ellipsis ? TextOverflow.ellipsis : null,
          color: color,
          fontSize:textScaleFactor* size,
          decoration: underline ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}
