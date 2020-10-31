import 'package:flutter/material.dart';

class Page06Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.cloud,
            size: 128,
            color: Colors.red,
          ),
          SizedBox(
            height: 24.0,
          ),
          RichText(
            text: TextSpan(
              text: "Use ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.w300,
                letterSpacing: -1.0,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "iCloud",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1.0,
                  ),
                ),
                TextSpan(
                  text: "?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -1.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Storing your lists in iCloud allows you to keep your data in sync across your iPhone, iPad and Mac.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                letterSpacing: -1.0,
              ),
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {},
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.13,
                  width: MediaQuery.of(context).size.width * 0.38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black87,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text("Not Now",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          // letterSpacing: -1.0,
                        )),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.13,
                  width: MediaQuery.of(context).size.width * 0.38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black87,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text("Use iCloud",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          // letterSpacing: -1.0,
                        )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
