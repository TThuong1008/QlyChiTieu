import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qlmoney/screen/bottom_navigation_bar.dart';
import 'package:qlmoney/screen/edit_account_page.dart';
import 'package:qlmoney/widgets/forward_button.dart';
import 'package:qlmoney/widgets/setting_item.dart';
import 'package:qlmoney/widgets/setting_switch.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isDrakMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.blue.shade300,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/image/avatar.png",
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(width: 20),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Truong Thi Thuong",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "22IT296",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ForwardButton(
                            ontap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EditAccountPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SettingItem(
                      title: "Language",
                      icon: Ionicons.earth,
                      bgColor: Colors.orange.shade100,
                      iconColor: Colors.orange,
                      value: "English",
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SettingItem(
                      title: "Notification",
                      icon: Ionicons.notifications,
                      bgColor: Colors.blue.shade100,
                      iconColor: Colors.blue,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SettingSwitch(
                      title: "Dark Mode",
                      icon: Ionicons.moon,
                      bgColor: Colors.purple.shade100,
                      iconColor: Colors.purple,
                      value: isDrakMode,
                      onTap: (value) {
                        setState(() {
                          isDrakMode = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SettingItem(
                      title: "Help",
                      icon: Ionicons.help_circle_outline,
                      bgColor: Colors.green.shade100,
                      iconColor: Colors.black,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SettingItem(
                      title: "LogOut",
                      icon: Ionicons.log_out,
                      bgColor: Colors.red.shade100,
                      iconColor: Colors.red,
                      onTap: () {
                        signUserOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: IconButton(
          //       onPressed: () {
          //         // Handle logout action here
          //       },
          //       style: IconButton.styleFrom(
          //         backgroundColor: Colors.lightBlueAccent,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(15)),
          //         fixedSize: Size(55, 50),
          //         elevation: 3,
          //       ),
          //       icon: const Icon(Ionicons.log_out_outline),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // method signout
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}
