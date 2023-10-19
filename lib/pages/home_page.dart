// import 'package:coep/pages/home_screen.dart';
// import 'package:coep/pages/offline_kit.dart';
// import 'package:flutter/material.dart';

// import 'export_pdf.dart';

// class MyHomePage extends StatefulWidget {

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;
//   static List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     OfflineKit(),
//     Text('Settings'),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(
//       //     'Bottom Navigation Bar Example',
//       //   ),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.black,
//       // ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.download_for_offline),
//             label: 'Offline Kit',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:coep/pages/ai_trip_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'offline_kit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.date,
  });
  final List<DateTime?> date;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var difference;
  static List<Widget> _widgetOptions = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      difference = widget.date[1]!.difference(widget.date[0]!).inDays;
      print(difference);
      _widgetOptions.addAll(<Widget>[
        // AiTripScreen(),
        HomeScreen(date: difference),
        AiTripScreen(),
        OfflineKit(),
        Text('Settings'),
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Bottom Navigation Bar Example',
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.black,
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.numbers),
              label: 'Ai Trip',
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_for_offline),
              label: 'Offline Kit',
              backgroundColor: Colors.amber),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.amber),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
