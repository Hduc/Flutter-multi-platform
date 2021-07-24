import 'package:equatable/equatable.dart';
import 'package:severingthing/model/item.dart';

abstract class MasterDetailEvent extends Equatable {
  const MasterDetailEvent();
}

class LoadItemsEvent extends MasterDetailEvent {
  @override
  List<Object> get props => []; // call api load data
}

class AddItemEvent extends MasterDetailEvent {
  final Item element;

  AddItemEvent(this.element);

  @override
  List<Object> get props => [element];
}

class SelectItemEvent extends MasterDetailEvent{
  final Item selected;

  SelectItemEvent(this.selected);

  @override 
  List<Object> get props => [selected];
}
