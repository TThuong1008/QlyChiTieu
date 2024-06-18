// import 'package:flutter/material.dart';
// import 'package:qlmoney/screen/add_page.dart';
// import 'package:qlmoney/screen/home.dart';
// import 'package:qlmoney/screen/remind_page.dart';
// import 'package:qlmoney/screen/thongke_page.dart';

// import 'account_page.dart';

// class BottomNavigationPage extends StatefulWidget {
//   const BottomNavigationPage({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigationPage> createState() => _BottomNavigationPageState();
// }

// class _BottomNavigationPageState extends State<BottomNavigationPage> {
//   int myCurrentIndex = 0;

//   List pages =  [
//     HomePage(),
//     ThongKePage(),
//     AddThuChiPage(),
//     RemindPage(),
//     AccountPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[myCurrentIndex],
//       floatingActionButton: Container(
//         width: 56,
//         height: 56,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.orange,
//         ),
//         child: IconButton(
//           onPressed: () {
//             setState(() {
//               myCurrentIndex = 2;
//             });
//           },
//           icon: Icon(Icons.add),
//           color: Colors.white,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         color: Color.fromARGB(255, 104, 204, 247),
//         shape: CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             IconButton(
//               icon: Icon(Icons.home_outlined),
//               onPressed: () {
//                 setState(() {
//                   myCurrentIndex = 0;
//                 });
//               },
//               color: myCurrentIndex == 0 ? Colors.red : Colors.black,
//             ),
//             IconButton(
//               icon: Icon(Icons.bar_chart_sharp),
//               onPressed: () {
//                 setState(() {
//                   myCurrentIndex = 1;
//                 });
//               },
//               color: myCurrentIndex == 1 ? Colors.red : Colors.black,
//             ),
//             IconButton(
//               icon: Icon(Icons.calendar_month),
//               onPressed: () {
//                 setState(() {
//                   myCurrentIndex = 3;
//                 });
//               },
//               color: myCurrentIndex == 3 ? Colors.red : Colors.black,
//             ),
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 setState(() {
//                   myCurrentIndex = 4;
//                 });
//               },
//               color: myCurrentIndex == 4 ? Colors.red : Colors.black,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qlmoney/screen/account_page.dart';
import 'package:qlmoney/screen/add_page.dart';
import 'package:qlmoney/screen/home.dart';
import 'package:qlmoney/screen/remind_page.dart';
import 'package:qlmoney/screen/thongke_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int myCurrentIndex = 0;

  List pages = [
    HomePage(),
    ThongKePage(),
    AddThuChiPage(),
    RemindPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[myCurrentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey[800],
            activeColor: Colors.white,
            tabBackgroundColor: Colors.blueAccent,
            gap: 8,
            onTabChange: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                textStyle: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                iconColor:
                    myCurrentIndex == 0 ? Colors.white : Colors.grey[800],
                backgroundColor:
                    myCurrentIndex == 0 ? Colors.greenAccent : Colors.white,
              ),
              GButton(
                icon: Icons.bar_chart_sharp,
                text: 'Statistics',
                textStyle: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                iconColor:
                    myCurrentIndex == 1 ? Colors.white : Colors.grey[800],
                backgroundColor:
                    myCurrentIndex == 1 ? Colors.blueAccent : Colors.white,
              ),
              GButton(
                icon: Icons.add,
                text: 'Add',
                textStyle: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                iconColor:
                    myCurrentIndex == 2 ? Colors.white : Colors.grey[800],
                backgroundColor:
                    myCurrentIndex == 2 ? Colors.amberAccent : Colors.white,
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Remind',
                textStyle: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                iconColor:
                    myCurrentIndex == 3 ? Colors.white : Colors.grey[800],
                backgroundColor:
                    myCurrentIndex == 3 ? Colors.pinkAccent : Colors.white,
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
                textStyle: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                iconColor:
                    myCurrentIndex == 4 ? Colors.white : Colors.grey[800],
                backgroundColor:
                    myCurrentIndex == 4 ? Colors.purpleAccent : Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
