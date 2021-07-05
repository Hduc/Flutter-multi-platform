import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo List"),
        ),
        body: TodoListContainer(),
      ),
    );
  }
}

class TodoListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildHeader(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    var txtTodoController = TextEditingController();
    return Row(
      children: <Widget>[
        Expanded(
            child: TextFormField(
          controller: txtTodoController,
          decoration:
              InputDecoration(labelText: "Add Todo", hintText: "Add todo"),
        )),
        SizedBox(
          width: 20,
        ),
        RaisedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.add),
          label: Text('Add'),
        )
      ],
    );
  }
}
