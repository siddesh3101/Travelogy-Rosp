import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class SocialAnalytics extends StatefulWidget {
  const SocialAnalytics({super.key});

  @override
  State<SocialAnalytics> createState() => _SocialAnalyticsState();
}

class _SocialAnalyticsState extends State<SocialAnalytics> {
  Map<String, double> dataMap = {
    "Post Likes": 18.47,
    "Comments": 17.70,
    "Browsing": 4.25,
    "Posting": 3.51,
    "Other": 2.83,
  };

  // Colors for each segment
  // of the pie chart
  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  // List of gradients for the
  // background of the pie chart
  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Text(
                'Trending Analytics',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://instagram.fbom36-1.fna.fbcdn.net/v/t51.2885-19/369232318_312700261292658_3328888599565003888_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom36-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=O-99L82JgLYAX9s8Zlp&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfB5M4Gjp6ofzWrqVWjf1aDyVzFKR6EFxUH1X9cTvMeCqg&oe=651E155E&_nc_sid=8b3546',
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '  Siddesh Shetty',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '  50 followers',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://instagram.fbom36-1.fna.fbcdn.net/v/t51.2885-19/35337406_222538778533922_8069940444751986688_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom36-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=DTCzr0stE6QAX_CIpZR&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfCQ_20KMZtKLrVn4gsxDwSkRM0CJHZKydFON9JxjQh4bg&oe=651D616F&_nc_sid=8b3546',
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Siddesh Patil  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '48 followers  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Activity',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.left,
              ),
              PieChart(
                // Pass in the data for
                // the pie chart
                dataMap: dataMap,
                // Set the colors for the
                // pie chart segments
                colorList: colorList,
                // Set the radius of the pie chart
                chartRadius: MediaQuery.of(context).size.width / 2,
                // Set the center text of the pie chart
                centerText: "Activity",
                // Set the width of the
                // ring around the pie chart
                ringStrokeWidth: 24,
                // Set the animation duration of the pie chart
                animationDuration: const Duration(seconds: 3),
                // Set the options for the chart values (e.g. show percentages, etc.)
                chartValuesOptions: const ChartValuesOptions(
                    showChartValues: true,
                    showChartValuesOutside: true,
                    showChartValuesInPercentage: true,
                    showChartValueBackground: false),
                // Set the options for the legend of the pie chart
                legendOptions: const LegendOptions(
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(fontSize: 15),
                    legendPosition: LegendPosition.bottom,
                    showLegendsInRow: true),
                // Set the list of gradients for
                // the background of the pie chart
                gradientList: gradientList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
