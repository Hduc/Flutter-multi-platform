import 'package:flutter/material.dart';
import 'package:severingthing/ui/pages/widgets/app_bar.dart';
import 'package:severingthing/ui/responsive_layout.dart';

class WidgetTree extends StatefulWidget {
  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int currentIndex = 1;

  List<Widget> _icons = [
    Icon(Icons.add, size: 30),
    Icon(Icons.list, size: 30),
    Icon(Icons.compare_arrows, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyHeightLimit(context) ||
                ResponsiveLayout.isTinyLimit(context))
            ? Container()
            : AppBarWidget(),
      ),
    );
  }
}
