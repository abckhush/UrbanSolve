import 'package:flutter/material.dart';
import 'package:error404/views/livedetection.dart';
import 'package:error404/views/report.dart';
import 'package:error404/views/viewpot.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:error404/views/faq.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 234, 229),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 237, 234, 229),
        elevation: 0, // Optional: Removes the shadow from the app bar.
        title: Row(
          children: [
            Icon(
              Icons.home,
              color: Color.fromARGB(255, 2, 102, 112),
            ),
            SizedBox(width: 10),
            Text(
              'UrbanSolve',
              style: GoogleFonts.passionOne(
                color: Color.fromARGB(255, 2, 102, 112),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.question_answer),
            color: Color.fromARGB(255, 236, 110, 43),
            onPressed: () {
              // Assuming FAQPage is defined in the 'faq.dart' file
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FAQPage()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewPotholeView()));
              },
              child: Container(
                height: 240, // Square shape
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blueGrey, // Placeholder color for the map window
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Center(
                  child: Image.asset('./assets/EYuK.gif'),
                  // child: Icon(
                  //   Icons.map, // Placeholder icon for the map window
                  //   size: 64,
                  //   color: Colors.white,
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReportPotholeView()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 159, 237, 215),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.report,
                      color: Color.fromARGB(255, 2, 102, 112),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Report A PotHole',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 102, 112),
                        fontSize: 12
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ObjectDetectionScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 159, 237, 215),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.gps_fixed,
                      color: Color.fromARGB(255, 2, 102, 112),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Live-Detection',
                      style: TextStyle(
                        color: Color.fromARGB(255, 2, 102, 112),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
