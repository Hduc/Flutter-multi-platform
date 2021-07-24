import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:severingthing/bloc/bloc.dart';
import 'package:severingthing/model/item.dart';
import 'package:severingthing/ui/detail_page.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPage createState() => _MasterPage();
}

class _MasterPage extends State<MasterPage> {
  int elementCount = 0;
  MasterDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.add(LoadItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master"),
        actions: <Widget>[
          IconButton(onPressed: _addItem, icon: Icon(Icons.add))
        ],
      ),
      backgroundColor: Color(0xffefefef),
      body: BlocBuilder(
        bloc: _bloc, 
        builder: (context, state) {
          if(state is LoadingItemsSate){
            return Center(child: CircularProgressIndicator());
          }
          else if(state is NoItemsState){
            return Center(child: Text("No Items"));
          }
          else if(state is LoadedItemsState){
            return ListView.builder(
              itemCount:state.elements.length,
              itemBuilder: (context,index){
                final item = state.elements[index];
                return ListTile(
                  title: Text(item.name),
                  selected: item == state.selectedElement,
                  onTap: () => _selectItem(context, item),
                );
              });
          }
          throw Exception("unexpected state $state");
        }),
    );
  }

  _addItem() {
    elementCount++;
    final newItem = Item(
        "name $elementCount", "this is the detail form element $elementCount");
    _bloc.add(AddItemEvent(newItem));
  }

  _selectItem(BuildContext context, Item item) {
    _bloc.add(SelectItemEvent(item));
    if (MediaQuery.of(context).size.shortestSide < 768) {
      final route = MaterialPageRoute(builder: (context) => DetailPage());
      Navigator.push(context, route);
    }
  }
}
