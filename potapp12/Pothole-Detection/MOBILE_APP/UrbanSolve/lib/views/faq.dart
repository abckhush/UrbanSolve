import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqData = [
    {
    'question': 'How long does it take to repair a pothole?',
    'answer':
        'The time it takes to repair a pothole varies depending on the size, depth, and location. Works are prioritised accordingly. While aim is to repair potholes within 14 working days of visiting the site, it may vary depending on the availability of resources and weather conditions.'
  },
  {
    'question': 'What materials are used for pothole repairs?',
    'answer':
        'Pothole repairs typically involve asphalt or a proprietary patching compound designed for quick setting and durability in various weather conditions.'
  },
  {
    'question': 'Can I report a pothole anonymously?',
    'answer':
        'Yes, most local authorities allow for anonymous reporting of issues such as potholes, though providing contact details can help them get additional information if needed.'
  },
  {
    'question': 'Is there a best time of year to report a pothole?',
    'answer':
        'Potholes can be reported at any time of the year. However, repairs may be scheduled more quickly during drier seasons due to the availability of resources and favorable weather conditions.'
  },
  {
    'question': 'What if a pothole caused damage to my vehicle?',
    'answer':
        "If a pothole caused damage to your vehicle, you might be able to claim compensation. It's recommended to document the incident with photos and contact your local authority for claim procedures."
  },
  {
    'question': 'How can I help prevent potholes?',
    'answer':
        'While potholes are primarily the responsibility of local authorities to prevent and repair, you can help by reporting any potholes or road damage you encounter to the appropriate department in your area.'
  },
  {
    'question': 'Are there any long-term solutions for pothole repairs?',
    'answer':
        'Long-term solutions involve improving the quality of road materials and construction methods, as well as regular maintenance and timely repairs to prevent small damages from becoming larger potholes.'
  },
  {
  'question': 'How do I identify a pothole that needs reporting?',
  'answer':
      'A pothole needing reporting is typically one that poses a danger to vehicles, cyclists, or pedestrians. It is usually several inches deep and wide enough that a tire could become stuck.'
},
{
  'question': 'Will smaller road imperfections also be repaired?',
  'answer':
      'Smaller imperfections may be repaired if they are on a critical part of the road or pose a safety risk. However, they are generally lower priority than larger potholes.'
},
{
  'question': 'What is the process for a pothole repair?',
  'answer':
      'The process typically involves cleaning the pothole, filling it with new material, and compacting the new material to make the surface even with the surrounding road.'
},
{
  'question': 'How can I follow up on a pothole repair request?',
  'answer':
      "You can follow up on a pothole repair request by contacting the local authority's road maintenance department with your report reference number to get an update on the repair status."
}
  
  ];
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 234, 229), // Match background color with HomePage
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 237, 234, 229), // Match AppBar color with HomePage
        title: Row(
          children: [
            Icon(
              Icons.question_answer_rounded,
              color: Color.fromARGB(255, 2, 102, 112),
            ),
            SizedBox(width: 10),
            Text(
              'FAQs',
              style: GoogleFonts.passionOne(
                color: Color.fromARGB(255, 2, 102, 112),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        elevation: 0, // Remove shadow from AppBar
        iconTheme: IconThemeData(color: Color.fromARGB(255, 2, 102, 112)), // Match icon color with HomePage
      ),
      body: ListView.builder(
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white.withOpacity(0.9), // Card with some transparency
            elevation: 2.0,
            margin: EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(
                faqData[index]['question']!,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 102, 112)), // Match text color with HomePage
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faqData[index]['answer']!,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(fontSize: 16, color: Color.fromARGB(255, 2, 102, 112)), // Match text color with HomePage
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
