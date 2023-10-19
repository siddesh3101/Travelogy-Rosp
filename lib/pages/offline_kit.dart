import 'package:coep/pages/export_pdf.dart';
import 'package:coep/pages/offline_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'itinerary_screen.dart';

class OfflineKit extends StatefulWidget {
  const OfflineKit({super.key});

  @override
  State<OfflineKit> createState() => _OfflineKitState();
}

class _OfflineKitState extends State<OfflineKit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Kit"),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ExportPdf(),
                    ));
                  },
                  child: Text('Export Itinerary Kit'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // foreground color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16), // button padding
                    textStyle: TextStyle(
                      fontSize: 14, // text font size
                      fontWeight: FontWeight.bold, // text font weight
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Offline(),
                    ));
                  },
                  child: Text('Helpline Numbers'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // foreground color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16), // button padding
                    textStyle: TextStyle(
                      fontSize: 14, // text font size
                      fontWeight: FontWeight.bold, // text font weight
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
