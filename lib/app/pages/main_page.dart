import 'package:flutter/material.dart';
import 'package:harmoniza_ativos/app/pages/monthly%20plans/bar_item_page.dart';
import 'package:harmoniza_ativos/app/pages/profile/my_page.dart';
import 'package:harmoniza_ativos/app/pages/search%20page/search_page.dart';

import 'homepage/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomePage(),
    const BarItemPage(),
    const SearchPage(),
    const MyPage(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color dourado = const Color.fromARGB(255, 182, 154, 94);
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              label: 'Lista',
              icon: Icon(
                Icons.post_add,
                color: dourado,
              )),
          BottomNavigationBarItem(
              label: 'Planos',
              icon: Icon(
                Icons.request_page,
                color: dourado,
              )),
          BottomNavigationBarItem(
              label: 'Procurar',
              icon: Icon(
                Icons.search,
                color: dourado,
              )),
          BottomNavigationBarItem(
              label: 'Profile?',
              icon: Icon(
                Icons.person,
                color: dourado,
              )),
        ],
      ),
    );
  }
}
