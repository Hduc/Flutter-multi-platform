import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:severingthing/bloc/bloc.dart';
import 'package:severingthing/data/model/item.dart';
import 'package:severingthing/data/model/restaurant_model.dart';
import 'package:severingthing/data/reponsitory/product_reponsitory.dart';

class MasterDetailBloc extends Bloc<MasterDetailEvent, MasterDetailState> {
  List<Item> _items = [];
  Item _selected;
  RestaurantRepository restaurantRepository;

  @override
  MasterDetailState get initialState => LoadingItemsSate();

  @override
  Stream<MasterDetailState> mapEventToState(MasterDetailEvent event) async* {
    if (_items.isEmpty) {
      RestaurantModel restaurantModel =
          await restaurantRepository.getRestaurantData();

      print("Bloc Success");
    }
    if (event is AddItemEvent) {
      _items.add(event.element);
    } else if (event is SelectItemEvent) {
      _selected = event.selected;
    }
    yield* _loadItems();
  }

  Stream<MasterDetailState> _loadItems() async* {
    if (_items.isEmpty) {
      yield NoItemsState();
    } else {
      final newState = LoadedItemsState([..._items], Item.formItem(_selected));
      yield newState;
    }
  }
}
