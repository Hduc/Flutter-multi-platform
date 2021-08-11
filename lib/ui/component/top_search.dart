import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopSearch extends StatefulWidget {
  @override
  State<TopSearch> createState() => _TopSearch();
}

class _TopSearch extends State<TopSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Top Search"),
    ));
  }
}
