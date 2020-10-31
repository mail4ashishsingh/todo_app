import 'package:flutter/material.dart';
import 'package:todo_app/utility/index.dart';

class Page05Screen extends StatelessWidget {
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
                    text: "Tap on a list ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "to see its content.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                RichText(
                  text: TextSpan(
                    text: "Tap on a list title",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "to edit it...",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ],
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
                child: Image.asset(Assets.IMAGE_02),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
