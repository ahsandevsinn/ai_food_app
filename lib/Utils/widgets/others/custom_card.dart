import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:flutter/material.dart';

class Customcard extends StatefulWidget {
  final childWidget;
  const Customcard({super.key, required this.childWidget});

  @override
  State<Customcard> createState() => _CustomcardState();
}

class _CustomcardState extends State<Customcard> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.90,
      child: Container(
        // width: 320,
        height: 450,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.78), // Adjust the opacity as needed
              BlendMode.lighten,
            ),
          ),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: const [
            BoxShadow(
              color: Color(0x7FB38ADE),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: widget.childWidget,
        ),
      ),
    );
  }
}
