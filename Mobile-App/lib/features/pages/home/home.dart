import 'package:flutter/material.dart';
import 'package:proj_passion_shoot/config/theme/app_theme.dart';
import 'package:proj_passion_shoot/features/widget/about/about.dart';
import 'package:proj_passion_shoot/features/widget/method/method.dart';
import 'package:proj_passion_shoot/features/widget/recap/recap.dart';
import 'package:proj_passion_shoot/features/widget/schedule/schedule.dart';
import 'package:proj_passion_shoot/features/widget/transaction/transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final screens = const [
    TransactionContent(),
    MethodContent(),
    RecapContent(),
    ScheduleContent(),
    AboutContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Content
      body: screens[_currentIndex],
      // End Content
      // bottom navbar
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: secondaryColor,
          iconTheme: MaterialStatePropertyAll(
            IconThemeData(color: textColor),
          ),
          labelTextStyle: MaterialStatePropertyAll(
            primaryTextStyle.copyWith(fontSize: 12),
          ),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.menu_book),
              label: 'Transaksi',
            ),
            NavigationDestination(
              icon: Icon(Icons.credit_card),
              label: 'Sumber',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart),
              label: 'Rekapitulasi',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today),
              label: 'Jadwal',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_pin_rounded),
              label: 'Tentang',
            ),
          ],
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
        ),
      ),
    );
  }
}
