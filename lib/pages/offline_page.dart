import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Offline extends StatelessWidget {
  const Offline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Help Desk',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        // bottom: TabBar(
        //   controller: _tabController,
        //   tabs: examples.map<Tab>((e) => Tab(text: e.name)).toList(),
        //   isScrollable: true,
        // ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Text(
              'Emergency Numbers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            buildHelplineCard('Emergency', '300'),
            buildHelplineCard('Police', '100'),
            buildHelplineCard('Fire', '102'),
            buildHelplineCard('Ambulance', '108'),
            SizedBox(height: 20),
            Text(
              'Local Guides Near You',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildCircularImage('assets/male1.jpg', 'Rakesh'),
                buildCircularImage('assets/male2.jpg', 'Rahul'),
                buildCircularImage('assets/female1.jpg', 'Usha'),
                // buildCircularImage('assets/places/place1.jpg', 'John'),
                // buildCircularImage('assets/places/place1.jpg', 'John'),
                // buildCircularImage('assets/places/place1.jpg', 'John'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHelplineCard(String title, String number) {
    return Card(
      child: InkWell(
        onTap: () => _launchCaller(number),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text(number, style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircularImage(String imagePath, String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(name),
        ],
      ),
    );
  }

  void _launchCaller(String number) async {
    String url = 'tel:$number';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
