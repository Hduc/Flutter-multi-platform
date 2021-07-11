import 'dart:async';
import 'package:myapp/base/base_bloc.dart';
import 'package:myapp/base/base_event.dart';
import 'package:myapp/model/todo.dart';
import 'package:myapp/todo/event/add_todo_event.dart';
import 'package:myapp/todo/event/delete_todo_event.dart';

class TodoBloc extends BaseBloc {
  StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();

  _addTodo(Todo todo){

  }
  _deleteTodo(Todo todo){

  }
  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
    } else if (event is DeleteTodoEvent) {}
  }

  @override
  void dispose() {
    super.dispose();
    _todoListStreamController.close();
  }
}
