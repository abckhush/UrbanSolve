import 'package:flutter/material.dart';
import 'package:error404/home.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:error404/controller/contentmodel.dart';
// import 'package:unbording/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(0, 255, 255, 255),
                        ),
                        child: Image.asset(
                          contents[i].image,
                          height: 300,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        contents[i].title,
                        style: GoogleFonts.quicksand(
                          fontSize: 40,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      const SizedBox(height: 90),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontStyle: FontStyle.italic
                        )
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            height: 50,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: ElevatedButton(
               style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 2, 102, 112)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                ),
              child: Text(
                  currentIndex == contents.length - 1 ? "Continue" : "Next",
                  style: GoogleFonts.lato(
                    fontStyle: FontStyle.italic
                  ),),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                  );
                }
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 5,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color.fromARGB(255, 2, 102, 112),
      ),
    );
  }
}
