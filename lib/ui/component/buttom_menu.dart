import 'package:flutter/material.dart';

class ButtomMenu extends StatefulWidget {
  @override
  _ButtomMenu createState() => _ButtomMenu();
}

class _ButtomMenu extends State<ButtomMenu> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        selectedLabelStyle: textTheme.caption,
        unselectedLabelStyle: textTheme.caption,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Favorites'),
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            title: Text('Music'),
            icon: Icon(Icons.music_note),
          ),
          BottomNavigationBarItem(
            title: Text('Places'),
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            title: Text('News'),
            icon: Icon(Icons.library_books),
          ),
        ],
      ),
    );
  }
}
