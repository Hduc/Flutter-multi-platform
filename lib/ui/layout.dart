import 'package:flutter/material.dart';
import 'package:severingthing/ui/component/buttom_menu.dart';
import 'package:severingthing/ui/pages/detail_page.dart';
import 'package:severingthing/ui/master_page.dart';

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 768) {
        return _TabletHomePage();
      } else {
        return _MobileHomePage();
      }
    });
  }
}

class _TabletHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(width: 300, child: MasterPage()),
        Expanded(child: DetailPage())
      ],
    );
  }
}

class _MobileHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtomMenu();
  }
}
