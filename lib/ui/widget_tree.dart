import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:severingthing/ui/common/color.dart';
import 'package:severingthing/ui/pages/components/left_navigation.dart';
import 'package:severingthing/ui/pages/components/panel_center.dart';
import 'package:severingthing/ui/pages/components/panel_left.dart';
import 'package:severingthing/ui/pages/components/panel_right.dart';
import 'package:severingthing/ui/pages/widgets/app_bar.dart';
import 'package:severingthing/ui/responsive_layout.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);
  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int currentIndex = 1;

  List<Widget> _icons = [
    Icon(Icons.home, size: 30),
    Icon(Icons.chat, size: 30),
    Icon(Icons.toggle_on, size: 30),
    Icon(Icons.show_chart, size: 30),
    Icon(Icons.settings, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyHeightLimit(context) ||
                ResponsiveLayout.isTinyLimit(context))
            ? Container()
            : AppBarWidget(),
      ),
      body: ResponsiveLayout(
        tiny: Container(),
        phone: currentIndex == 0
            ? PanelLeftPage()
            : currentIndex == 1
                ? PanelCenterPage()
                : PanelRightPage(),
        tablet: Row(
          children: [
            Expanded(child: PanelLeftPage()),
            Expanded(
              child: PanelCenterPage(),
            )
          ],
        ),
        largeTablet: Row(
          children: [
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
            Expanded(
              child: PanelRightPage(),
            )
          ],
        ),
        computer: Row(
          children: [
            Expanded(child: DrawerPage()),
            Expanded(child: PanelLeftPage()),
            Expanded(
              child: PanelCenterPage(),
            ),
            Expanded(
              child: PanelRightPage(),
            )
          ],
        ),
      ),
      drawer: DrawerPage(),
      bottomNavigationBar: ResponsiveLayout.isPhone(context)
          ? CurvedNavigationBar(
              index: currentIndex,
              backgroundColor: CustomColors.purpleDark,
              items: _icons,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            )
          : const SizedBox(),
    );
  }
}
