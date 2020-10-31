import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDateAndTimeScreen extends StatefulWidget {
  @override
  _SelectDateAndTimeScreenState createState() =>
      _SelectDateAndTimeScreenState();
}

class _SelectDateAndTimeScreenState extends State<SelectDateAndTimeScreen> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.w400),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, _dateTime);
                },
                child: Text("Done",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w400)),
              )
            ],
          ),
          SizedBox(
            height: 220,
            child: CupertinoDatePicker(
              initialDateTime: _dateTime,
              onDateTimeChanged: (dataTime) {
                print(dataTime);
                _dateTime = dataTime;
              },
            ),
          )
        ],
      ),
    );
  }
}
