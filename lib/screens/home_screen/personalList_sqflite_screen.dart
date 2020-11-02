import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/index.dart';
import 'package:todo_app/utility/database_helper.dart';
import 'index.dart';

class PersonalListSQFLiteScreen extends StatefulWidget {
  static const String routeName = "/personalList_screen";

  @override
  _PersonalListSQFLiteScreenState createState() =>
      _PersonalListSQFLiteScreenState();
}

class _PersonalListSQFLiteScreenState extends State<PersonalListSQFLiteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titleTextController = new TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  ScrollController _controller;
  String message;
  bool showContainer;

  @override
  void initState() {
    message = "";
    showContainer = false;

    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();

    titleTextController.dispose();
    super.dispose();
  }

  _scrollListener() {
    // print(
    //     "_controller.offset => ${_controller.offset} = ${_controller.position.maxScrollExtent}");
    // print(
    //     "_controller.position.outOfRange => ${_controller.position.outOfRange}");

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the bottom";
        if (titleTextController.text.isEmpty) showContainer = false;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
        showContainer = true;
      });
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        // noteList.sort(
        //     (a, b) => a.priority.toString().compareTo(b.priority.toString()));

        if (noteList.length == 0) showContainer = true;
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        // print("titleTextController.text => ${titleTextController.text}");
        if (titleTextController.text.isEmpty && noteList.length > 0) {
          showContainer = false;
          setState(() {
            // titleTextController.clear();
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Personal List"),
          elevation: 0.0,
          leading: Offstage(),
        ),
        // drawer: Drawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (showContainer)
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    height: 80.0,
                    decoration: BoxDecoration(
                        gradient: new LinearGradient(
                      colors: [
                        Colors.deepOrangeAccent,
                        Colors.grey[200],
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topRight,
                      stops: [0.3, 1],
                    )),
                    child: Center(
                      child: TextField(
                          autofocus: true,
                          autocorrect: false,
                          textInputAction: TextInputAction.done,
                          controller: titleTextController,
                          decoration: new InputDecoration(
                            hintText: "Enter Something",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                              fontSize: 20,
                            ),
                            helperText: "Add Reminder",
                            helperStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          onSubmitted: (value) {
                            if (value != "") {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SelectDateAndTimeScreen();
                                  }).then((dateTime) {
                                if (dateTime != null) {
                                  final DateTime now = dateTime;
                                  final DateFormat formatter =
                                      DateFormat('dd-MM-yyyy At hh:mm a');
                                  final String tempDate = formatter.format(now);

                                  Note note = new Note(
                                      value.toString(), tempDate.toString(), 1);

                                  _save(note);
                                  titleTextController.clear();
                                }
                              });
                            }
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800)),
                    ),
                  )
                : Offstage(),
            (noteList.length > 0)
                ? Expanded(
                    child: Container(
                      color: Colors.black,
                      child: ReorderableListView(
                        onReorder: (int index, int targetPosition) {
                          noteList[index].priority = 2;
                          _update(noteList[index]);
                        },
                        scrollDirection: Axis.vertical,
                        scrollController: _controller,
                        children: List.generate(
                          noteList.length,
                          (index) {
                            Note todo = noteList[index];
                            Key key = UniqueKey();
                            return todo.priority == 1
                                ? buildItem(todo, index, key)
                                : buildCompletedListTile(todo, index, key);
                          },
                        ),
                      ),
                    ),
                  )
                : emptyList(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 32.0,
          ),
          backgroundColor: Colors.red,
          // onPressed: () => goToNewItemView(),
          onPressed: () {
            showContainer = true;
            setState(() {});
          },
        ),
      ),
    );
  }

  void _save(Note note) async {
    // note.date = DateFormat.yMMMd().format(DateTime.now());
    int result = await databaseHelper.insertNote(note);

    if (result != 0) {
      // Success
      updateListView();
      // _showAlertDialog("Status", "Note Saved Successfully");
      _showSnackBar("Note Saved Successfully");
    } else {
      // Failure
      // _showAlertDialog("Status", "Problem Saving Note");
      _showSnackBar("Problem Saving Note");
    }
  }

  void _delete(Note note) async {
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }
    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      updateListView();
      _showSnackBar('Note Deleted Successfully');
    } else {
      _showSnackBar('Error occur while Deleting Note');
    }
  }

  void _update(Note note) async {
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was updated');
      return;
    }
    // Case 2: User is trying to update the old note that already has a valid ID.
    int result = await databaseHelper.updateNote(note);
    if (result != 0) {
      updateListView();
      _showSnackBar('Note Updated Successfully');
    } else {
      _showSnackBar('Error occur while Updating Note');
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  Widget emptyList() {
    return Expanded(
      child: Center(
        child: Text(
          'No items in list',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget buildItem(Note item, int index, key) {
    return Dismissible(
      key: key,
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      child: buildListTile(item, index),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          _delete(item);
        } else if (direction == DismissDirection.startToEnd) {
          item.priority = 2;
          _update(item);
        }
      },
    );
  }

  Widget buildCompletedListTile(Note item, int index, Key key) {
    return Container(
      key: key,
      padding: EdgeInsets.all(8.0),
      child: ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              item.title,
              key: key,
              style: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          subtitle: Text(
            item.date.toString(),
            key: Key('item-$index'),
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }

  Widget buildListTile(Note item, int index) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: new BoxDecoration(
        color: Colors.red,
        gradient: new LinearGradient(
          colors: [
            Colors.deepOrangeAccent,
            Colors.grey[200],
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topRight,
          stops: [0.3, 1],
        ),
      ),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            item.title.toString(),
            key: Key('item-$index'),
            style: TextStyle(
              color: Colors.black,
              decoration: null,
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        subtitle: Text(
          item.date.toString(),
          key: Key('item-$index'),
          style: TextStyle(
            color: Colors.black,
            decoration: null,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.black,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: 32.0,
          ),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.black,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 32.0,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
