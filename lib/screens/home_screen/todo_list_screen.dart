import 'package:flutter/material.dart';
import 'package:todo_app/models/index.dart';
import 'widgets/new_todo.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen>
    with TickerProviderStateMixin {
  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();
  AnimationController emptyListController;
  List<Todo> items = new List<Todo>();

  @override
  void initState() {
    emptyListController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    emptyListController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Todo List',
            // key: Key('main-app-title'),
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => goToNewItemView(),
        ),
        body: renderBody());
  }

  Widget renderBody() {
    // for (int i = 0; i < items.length; i++) {
    //   if (items[i].completed) {}
    // }

    if (items.length > 0) {
      return buildListView();
    } else {
      return emptyList();
    }
  }

  Widget emptyList() {
    return Center(
      child: FadeTransition(
        opacity: emptyListController,
        child: Text(
          'No items',
          style: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return AnimatedList(
      key: animatedListKey,
      initialItemCount: items.length,
      itemBuilder: (BuildContext context, int index, animation) {
        // print("items[index] = ${items[index].title}");
        // print("items[index] = ${items[index].completed}");

        items.sort(
            (a, b) => a.completed.toString().compareTo(b.completed.toString()));

        return SizeTransition(
          sizeFactor: animation,
          child: items[index].completed
              ? buildCompletedListTile(items[index], index)
              : buildItem(items[index], index),
        );
      },
    );
  }

  Widget buildItem(Todo item, int index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      // onDismissed: (direction) => removeItemFromList(item, index),
      // direction: DismissDirection.endToStart,
      child: buildListTile(item, index),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          print(direction);
          removeItemFromList(item, index);
        } else if (direction == DismissDirection.startToEnd) {
          print(direction);
          changeItemCompleteness(item, index);
        }
      },
      // dragStartBehavior: DragStartBehavior.,
      // crossAxisEndOffset: 1.0,
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.lightGreen,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.redAccent,
      child: Align(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 32.0,
          ),
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget buildListTile(item, index) {
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

        // gradient: SweepGradient(
        //   colors: [
        //     Colors.pink,
        //     Colors.red,
        //     Colors.green,
        //     Colors.purple,
        //     Colors.teal
        //   ],
        //   stops: [0.8, 0.96, 0.74, 0.22, 0.85],
        //   startAngle: 0.5,
        //   endAngle: 1,
        // ),
      ),
      child: ListTile(
        // onTap: () => changeItemCompleteness(item, index),
        // onLongPress: () => goToEditItemView(item),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            item.title,
            key: Key('item-$index'),
            style: TextStyle(
              color: item.completed ? Colors.grey : Colors.black,
              decoration: item.completed ? TextDecoration.lineThrough : null,
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        // subtitle: Text(item.subTitle,
        //     key: Key('item-$index'),
        //     style: TextStyle(
        //       color: item.completed ? Colors.grey : Colors.black,
        //       decoration: item.completed ? TextDecoration.lineThrough : null,
        //       fontSize: 18.0,
        //       fontWeight: FontWeight.w400,
        //     )),
        // trailing: Icon(
        //   item.completed ? Icons.check_box : Icons.check_box_outline_blank,
        //   key: Key('completed-icon-$index'),
        // ),
      ),
    );
  }

  Widget buildCompletedListTile(item, index) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        // onTap: () => changeItemCompleteness(item, index),
        // onLongPress: () => goToEditItemView(item),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            item.title,
            key: Key('item-$index'),
            style: TextStyle(
              color: item.completed ? Colors.grey : Colors.black,
              decoration: item.completed ? TextDecoration.lineThrough : null,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // subtitle: Text(item.subTitle,
        //     key: Key('item-$index'),
        //     style: TextStyle(
        //       color: item.completed ? Colors.grey : Colors.black,
        //       decoration: item.completed ? TextDecoration.lineThrough : null,
        //       fontSize: 18.0,
        //       fontWeight: FontWeight.w400,
        //     )),
        // trailing: Icon(
        //   item.completed ? Icons.check_box : Icons.check_box_outline_blank,
        //   key: Key('completed-icon-$index'),
        // ),
      ),
    );
  }

  void changeItemCompleteness(Todo item, int index) {
    setState(() {
      item.completed = !item.completed;
    });
  }

  void goToNewItemView() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
          builder: (context) {
            return NewTodoView();
          },
          fullscreenDialog: true),
    )
        .then((title) {
      if (title != null) {
        addItem(Todo(title: title));
      }
    });
  }

  void addItem(Todo item) {
    // Insert an item into the top of our list, on index zero
    items.insert(0, item);
    if (animatedListKey.currentState != null)
      animatedListKey.currentState.insertItem(0);
  }

  void goToEditItemView(Todo item) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
          builder: (context) {
            return NewTodoView(item: item);
          },
          fullscreenDialog: false),
    )
        .then((title) {
      if (title != null) {
        editItem(item, title);
      }
    });
  }

  void editItem(Todo item, String title) {
    item.title = title;
  }

  void removeItemFromList(Todo item, int index) {
    animatedListKey.currentState.removeItem(index, (context, animation) {
      return SizedBox(
        width: 0,
        height: 0,
      );
    });
    deleteItem(item);
  }

  void deleteItem(Todo item) {
    items.remove(item);
    if (items.isEmpty) {
      emptyListController.reset();
      setState(() {});
      emptyListController.forward();
    }
  }
}
