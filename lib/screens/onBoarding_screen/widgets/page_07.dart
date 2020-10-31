import 'package:flutter/material.dart';
import 'package:todo_app/router_name.dart';

class Page07Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Sign up to the newsletter, and unlock a theme for your lists.",
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
            height: 24.0,
          ),
          Icon(
            Icons.email_outlined,
            size: 128,
            color: Colors.black87,
          ),
          SizedBox(
            height: 24.0,
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.13,
            width: MediaQuery.of(context).size.width * 0.88,
            padding: EdgeInsets.only(left: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black87,
                width: 2.0,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Email Address",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    // letterSpacing: -1.0,
                  )),
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, PERSONAL_LIST_SCREEN);
                },
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
                    child: Text("Skip",
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
                    child: Text("Join",
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
