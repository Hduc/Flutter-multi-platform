import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:severingthing/ui/home_page.dart';

import 'bloc/master_detail_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (context) => MasterDetailBloc(),
      child:MaterialApp(home:HomePage()),
    );
  }
}