import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qlmoney/widgets/edit_item.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  String gender = "man";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 80,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                fixedSize: Size(55, 50),
                elevation: 3,
              ),
              icon: const Icon(Ionicons.checkmark),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.blue.shade300,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            EditItem(
              title: "Photo",
              widget: Column(
                children: [
                  Image.asset(
                    "assets/image/avatar.png",
                    height: 100,
                    width: 100,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.lightBlueAccent,
                    ),
                    child: const Text("Upload Image"),
                  ),
                ],
              ),
            ),
            const EditItem(
              widget: TextField(),
              title: "Name",
            ),
            const SizedBox(
              height: 40,
            ),
            EditItem(
              title: "Gender",
              widget: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        gender = "man";
                      });
                    },
                    style: IconButton.styleFrom(
                        backgroundColor: gender == "man"
                            ? Colors.green
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50)),
                    icon: Icon(
                      Ionicons.male,
                      color: gender == "man" ? Colors.white : Colors.black,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        gender = "woman";
                      });
                    },
                    style: IconButton.styleFrom(
                        backgroundColor: gender == "woman"
                            ? Colors.green
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50)),
                    icon: Icon(
                      Ionicons.female,
                      color: gender == "woman" ? Colors.white : Colors.black,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const EditItem(
              title: "Age",
              widget: TextField(),
            ),
            const SizedBox(
              height: 40,
            ),
            const EditItem(
              title: "Email",
              widget: TextField(),
            ),
          ],
        ),
      ),
    );
  }
}
