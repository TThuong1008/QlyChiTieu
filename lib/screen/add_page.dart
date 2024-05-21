import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qlmoney/widgets/add_expense_form.dart';
import 'package:qlmoney/widgets/add_income_form.dart';

import 'bottom_navigation_bar.dart';



class AddThuChiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sliver Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConvertAddThuChi(),
    );
  }
}

class ConvertAddThuChi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigationPage()),
                );
              },
              icon: const Icon(Ionicons.chevron_back_outline),
            ),
            leadingWidth: 80,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Thu'),
              Tab(text: 'Chi'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddIncomeForm(),
            AddExpenseForm(),
          ],
        ),
      ),
    );
  }
}



