import 'package:coep/pages/markdown_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AiTripScreen extends StatefulWidget {
  const AiTripScreen({super.key});

  @override
  State<AiTripScreen> createState() => _AiTripScreenState();
}

class _AiTripScreenState extends State<AiTripScreen> {
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  TextEditingController text3 = TextEditingController();
  TextEditingController text4 = TextEditingController();
  TextEditingController text5 = TextEditingController();
  TextEditingController text6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Ai Trip Planner"),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Plan Your Next Trip With Us",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),

                // Text("Enter Location you want to visit"),

                Text(
                  "Destination Country",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: text1,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Location',
                    // hintText: 'Enter Location',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Duration in days",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: text6,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Duration',
                    // hintText: 'Enter Location',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Budget",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: text2,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Budget',
                    // hintText: 'Enter Location',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Activities",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: text3,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Activities',
                    // hintText: 'Enter Location',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Interests",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: text4,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Interests',
                    // hintText: 'Enter Location',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Language",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: text5,
                  // obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Language',
                    // hintText: 'Enter Location',
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    child: Text('Start Planning'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.normal),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MarkerScreen(data_to_be_sent: {
                          "destination": text1.text,
                          "budget": text2.text,
                          "duration": text6.text,
                          "interests": text4.text,
                          "language": text5.text
                        }),
                      ));
                    },
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
