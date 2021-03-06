import 'package:flutter/material.dart';
import 'package:todo_app/utility/index.dart';

class Page01Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Clear sorts items by ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -1.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "priority.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "Important items are highlighted at the top...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      // letterSpacing: -1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Container(
                child: Image.asset(Assets.IMAGE_01),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
