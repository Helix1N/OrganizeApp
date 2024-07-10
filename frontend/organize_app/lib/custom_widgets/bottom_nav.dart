import 'package:flutter/material.dart';

import '../data/data_user.dart';
import '../pages/home.dart';
import '../pages/new_task.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndexNavbar;
  final BuildContext context;
  const BottomNav(
      {super.key, required this.selectedIndexNavbar, required this.context});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.checklist,
            size: 30,
          ),
          label: 'Check',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: 'add',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 30,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndexNavbar,
      selectedItemColor: Colors.blue.withOpacity(0.7),
      onTap: (int index) {
        switch (index) {
          case 0:
            _homeNavigator();
            break;
          case 1:
            break;
          case 2:
            _newTaskNavigator();
            break;
          default:
        }
      },
    );
  }

  void _homeNavigator() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void _newTaskNavigator() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTaskPage(),
      ),
    );
  }
}
