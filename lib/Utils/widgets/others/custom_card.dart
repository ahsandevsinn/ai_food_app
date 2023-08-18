import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:flutter/material.dart';
class Customcard extends StatefulWidget {
  final List<Widget> children;
  const Customcard({super.key, required this.children});
  @override
  State<Customcard> createState() => _CustomcardState();
}
class _CustomcardState extends State<Customcard> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.70,
      child: Container(
        // width: 320,
        height: 425,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_image.png'),
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9), // Adjust the opacity as needed
              BlendMode.lighten,
            ),
          ),
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: [
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.children),
        ),
      ),
    );
    // Card(
    //   // shadowColor: AppTheme.appColor,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   elevation: 5.0,
    //   child: Container(
    //     height: 500,
    //     decoration: BoxDecoration(
    //       image: DecorationImage(
    //         image: AssetImage('assets/images/splash_image.png'),
    //         fit: BoxFit.contain,
    //         colorFilter: ColorFilter.mode(
    //           Colors.white.withOpacity(0.9), // Adjust the opacity as needed
    //           BlendMode.lighten,
    //         ),
    //       ),
    //     ),
    //     child: Padding(
    //       padding: EdgeInsets.all(20.0),
    //       child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: widget.children),
    //     ),
    //   ),
    // );
  }
}