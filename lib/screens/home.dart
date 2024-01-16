import 'package:cipherx/provider/bottom-notifier.dart';
import 'package:cipherx/screens/add-transaction.dart';
import 'package:cipherx/screens/budget-screen.dart';
import 'package:cipherx/screens/home-screen.dart';
import 'package:cipherx/screens/profile-screen.dart';
import 'package:cipherx/screens/transaction-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final List<dynamic> _pages = [
    const HomeScreen(),
    const TransactionScreen(),
    Container(),
    const BudgetScreen(),
    const ProfileScreen()
  ];

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenindexprovider = Provider.of<BottomNavBarProvider>(context);
    int currentScreenIndex = screenindexprovider.currentIndex;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        focusElevation: 0,
        focusColor: Colors.white,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTransaction()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.purple,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 1.5,
          currentIndex: currentScreenIndex,
          onTap: (value) => screenindexprovider.updateIndex(value),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Budget',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
      body: _pages[currentScreenIndex],
    );
  }
}
