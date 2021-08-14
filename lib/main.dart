import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:severingthing/res/theme.dart';
import 'package:severingthing/ui/layout.dart';
import 'bloc/master_detail/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MasterDetailBloc(),
      child: MaterialApp(theme: AppTheme.buildShrineTheme(), home: Layout()),
    );
  }
}
