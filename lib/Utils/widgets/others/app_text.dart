import 'package:flutter/material.dart';

// class AppText extends StatelessWidget {
//   final String text;
//   final double size;
//   final FontWeight bold;
//   final Color? color;
//   final bool justifyText;
//   final bool alignText;
//   final bool underline;
//   final bool ellipsis;
//   final Function()? onTap;
//
//   const AppText(
//     this.text, {
//     Key? key,
//     this.size = 18,
//     this.bold = FontWeight.normal ,
//     this.color = Colors.black,
//     this.justifyText = false,
//     this.alignText = false,
//     this.onTap,
//     this.underline = false,
//     this.ellipsis = false,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final textScaleFactor = MediaQuery.of(context).textScaleFactor;
//     return InkWell(
//       onTap: onTap != null ? onTap : null,
//       child: Text(
//         text,
//         textAlign: justifyText ? TextAlign.center :null,
//         style: TextStyle(
//           fontFamily: "Roboto Condensed",
//           fontWeight: bold,
//           overflow: ellipsis ? TextOverflow.ellipsis : null,
//           color: color,
//           fontSize:textScaleFactor* size,
//           decoration: underline ? TextDecoration.underline : null,
//         ),
//       ),
//     );
//   }
// }


class AppText {
  static Widget appText(String text,
      {TextAlign? textAlign,
        Color? textColor,
        double? fontSize,
        FontWeight? fontWeight,
        FontStyle? fontStyle,
        TextBaseline? textBaseline,
        TextOverflow? overflow,
        double? letterSpacing,
        bool underLine=false,
        bool fontFamily = false}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontFamily: fontFamily == false ? 'Roboto' : "Inter",
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          overflow: overflow,
          fontStyle: fontStyle,
          textBaseline: textBaseline,
          decoration: underLine == false
              ? TextDecoration.none
              : TextDecoration.underline),
    );
  }
}
