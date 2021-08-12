import 'package:equatable/equatable.dart';
import 'package:severingthing/data/model/item.dart';

abstract class MasterDetailState extends Equatable {
  const MasterDetailState();
}

class LoadingItemsSate extends MasterDetailState {
  @override
  List<Object> get props => [];
}

class NoItemsState extends MasterDetailState {
  @override
  List<Object> get props => [];
}

class LoadedItemsState extends MasterDetailState {
  final List<Item> elements;
  final Item selectedElement;

  LoadedItemsState(this.elements, this.selectedElement);
  @override
  List<Object> get props => [selectedElement, ...elements];
}
