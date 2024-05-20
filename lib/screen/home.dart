import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qlmoney/data/list_price.dart';

import '../data/money.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 340,
                child: _head(user.email!),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Money>>(
              future: _firebaseService.getMoneyData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else {
                  List<Money>? moneyList = snapshot.data;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return _categoryItem(context, moneyList[index]);
                      },
                      childCount: moneyList!.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryItem(BuildContext context, Money money) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          'assets/image/${money.icon}.png',
          height: 40,
          width: 60,
        ),
      ),
      title: Text(
        money.name ?? '',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        money.time ?? '',
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 15,
          color: Color.fromARGB(255, 41, 78, 243),
        ),
      ),
      trailing: Text(
        ((money.type ?? 'Income') == 'Income' ? "-\$ " : "+\$ ") + (money.price ?? 0).toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: (money.type ?? 'Income') == 'Income' ? Colors.pink : Colors.green,
        ),
      ),

    );
  }

  Widget _head(String emailUser) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 86, 175, 248),
                    Color.fromARGB(255, 189, 251, 245),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 340,
                    top: 35,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Color.fromRGBO(250, 250, 250, 0.1),
                        child: const Icon(
                          Icons.notification_add_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 35,
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          emailUser,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color.fromARGB(255, 241, 39, 241),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 140,
          left: 37,
          child: Container(
            height: 170,
            width: 320,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 71, 189, 252),
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 4,
                )
              ],
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 31, 152, 251),
                  Color.fromARGB(255, 147, 246, 236),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color.fromARGB(255, 126, 126, 126),
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ 1000',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 90, 142, 198),
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 90, 142, 198),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Expenses',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$ 300',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Color.fromRGBO(206, 252, 252, 1),
                        ),
                      ),
                      Text(
                        '\$ 400',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Color.fromRGBO(206, 252, 252, 1),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}