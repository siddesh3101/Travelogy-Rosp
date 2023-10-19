import 'package:coep/pages/pehchan/add_socials.dart';
import 'package:coep/pages/pehchan/find_user_screen.dart';
import 'package:coep/pages/pehchan/social_analytics.dart';
import 'package:coep/pages/pehchan/social_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../services/itinerary_service.dart';

class SocialHomeScreen extends StatefulWidget {
  static const String routeName = '/socialHome';
  const SocialHomeScreen({super.key});

  @override
  State<SocialHomeScreen> createState() => _SocialHomeScreenState();
}

class _SocialHomeScreenState extends State<SocialHomeScreen> {
  int _selectedIndex = 0;
  List<dynamic> result = [];
  List<dynamic> result1 = [
    {
      'image':
          'https://instagram.fbom36-1.fna.fbcdn.net/v/t51.2885-19/376247677_1321152008774844_2436055797422466539_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom36-1.fna.fbcdn.net&_nc_cat=100&_nc_ohc=ZLvI8U5TttsAX8WdfyN&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBt2gHkA4Za_O2pYpqZ3SrvJSLADO6s8jmmQAjJuHdHGg&oe=651CC8CD&_nc_sid=8b3546',
      'name': 'Tushar Singh'
    },
    {
      'image':
          'https://instagram.fbom36-1.fna.fbcdn.net/v/t51.2885-19/156388717_844645686390596_6579890033447165752_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom36-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=feCKw3FUPpwAX8eDHZu&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfBNeu49cFOKrhaSjaELxwSeFFP3rgDX5S0hGD3m9IoU7g&oe=651E41A0&_nc_sid=8b3546',
      'name': 'Sneha Yadav'
    }
  ];
  bool loading = true;
  void createItenary() async {
    dynamic map = await SocialService().huhu();
    print(map.toString());
    setState(() {
      result = map['socials'];
      loading = false;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    SocialDashboard(),
    SocialAnalytics()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _dialogBuilder(
      BuildContext context, int index, List list, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Suspicious Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LottieBuilder.asset('assets/icons/create/anim3.json'),
              Text(
                '${name} doesnt match the unique key of ${name} present in your following list.',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Flag Spam'),
              onPressed: () {
                Navigator.pop(context);
                Fluttertoast.showToast(
                    msg: "User flagged as spam",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                list.removeAt(index);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    createItenary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: 'Analytics',
                backgroundColor: Colors.black),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            AddSocials.routeName,
          );
        },
        child: Icon(Icons.add),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
