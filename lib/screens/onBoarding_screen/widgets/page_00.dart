import 'package:flutter/material.dart';

class Page00Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: "Welcome to ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "Clear",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          RichText(
            text: TextSpan(
              text: "Tap or swipe ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                // letterSpacing: -1.5,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "to begin.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    // letterSpacing: -1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
