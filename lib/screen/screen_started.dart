import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qlmoney/screen/dangky.dart';
import 'package:qlmoney/screen/dangnhap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required Null Function() onTap})
      : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Expense Manager", "image": "assets/image/start1.jpg"},
    {
      "text":
          "We help people connect with stores \naround United States of America",
      "image": "assets/image/start2.jpg"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/image/start3.jpg"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Welcome to App",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lobster(
                      fontSize: 28,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.only(right: 5),
                              height: 6,
                              width: currentPage == index ? 20 : 6,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? Colors.blueAccent
                                    : const Color(0xFFD8D8D8),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 3),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    onTap:
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()),
                                      );
                                    };
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            width: 350,
                                            height: 500,
                                            child: SignInScreen(onTap: () {}),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 30),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      10), // Add some space between the buttons
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Container(
                                            width: 350,
                                            height: 600,
                                            padding: const EdgeInsets.all(20),
                                            child: SignUpScreen(),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String? text, image;
  final Color color;

  const SplashContent({
    Key? key,
    this.text,
    this.image,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            text!,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const Spacer(flex: 2),
        Image.asset(
          image!,
          height: 320, // Increase the height
          width: 290, // Increase the width
        ),
      ],
    );
  }
}
