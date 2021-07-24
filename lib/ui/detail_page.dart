import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:severingthing/bloc/bloc.dart';
import 'package:severingthing/bloc/master_detail_bloc.dart';

class DetailPage extends StatefulWidget{
  @override
_DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage>{
  MasterDetailBloc _bloc;

  @override 
  void initState(){
    super.initState();
    _bloc = BlocProvider.of<MasterDetailBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: BlocBuilder(
        bloc:_bloc,
        builder:(context,state){
          if(state is LoadedItemsState){
            return Center(
              child: Text(state.selectedElement?.detail ?? "No item selected"),
            );
          }else {
            return Container();
          }
        }
      ),);
  }
}