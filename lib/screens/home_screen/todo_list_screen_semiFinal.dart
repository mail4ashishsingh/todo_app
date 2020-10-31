import 'package:flutter/material.dart';
import 'package:todo_app/screens/models/index.dart';

import 'new_todo.dart';

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
        appBar: AppBar(
          title: Text(
            'Todo List',
            key: Key('main-app-title'),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => goToNewItemView(),
        ),
        body: renderBody());
  }

  Widget renderBody() {
    if (items.length > 0) {
      return buildListView();
    } else {
      return emptyList();
    }
  }

  Widget emptyList() {
    return Center(
        child: FadeTransition(
            opacity: emptyListController, child: Text('No items')));
  }

  Widget buildListView() {
    return AnimatedList(
      key: animatedListKey,
      initialItemCount: items.length,
      itemBuilder: (BuildContext context, int index, animation) {
        print("items[index] = ${items[index].title}");
        print("items[index] = ${items[index].completed}");
        return SizeTransition(
          sizeFactor: animation,
          child: items[index].completed
              ? buildListTile(items[index], index)
              : buildItem(items[index], index),
        );
      },
    );
  }

  Widget buildItem(Todo item, int index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(color: Colors.green),
      secondaryBackground: Container(color: Colors.red),
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
    );
  }

  Widget buildListTile(item, index) {
    return ListTile(
      onTap: () => changeItemCompleteness(item, index),
      onLongPress: () => goToEditItemView(item),
      title: Text(
        item.title,
        key: Key('item-$index'),
        style: TextStyle(
            color: item.completed ? Colors.grey : Colors.black,
            decoration: item.completed ? TextDecoration.lineThrough : null),
      ),
      trailing: Icon(
        item.completed ? Icons.check_box : Icons.check_box_outline_blank,
        key: Key('completed-icon-$index'),
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
