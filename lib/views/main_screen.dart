import 'package:flutter/material.dart';
import 'package:les_store_app/views/nav_screens/account_screen.dart';
import 'package:les_store_app/views/nav_screens/cart_screen.dart';
import 'package:les_store_app/views/nav_screens/favorite_screen.dart';
import 'package:les_store_app/views/nav_screens/home_screen.dart';
import 'package:les_store_app/views/nav_screens/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  final List _pages = [
    HomeScreen(),
    FavoriteScreen(),
    StoreScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', width: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/love.png', width: 30),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/mart.png', width: 30),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/cart.png', width: 30),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/user.png', width: 30),
            label: 'Account',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
