import 'dart:developer';

import 'package:coep/services/ai_service.dart';
import 'package:coep/services/itinerary_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:printing/printing.dart';

class MarkerScreen extends StatefulWidget {
  const MarkerScreen({Key? key, required this.data_to_be_sent})
      : super(key: key);
  final Map<dynamic, dynamic> data_to_be_sent;

  @override
  State<MarkerScreen> createState() => _MarkerScreenState();
}

class _MarkerScreenState extends State<MarkerScreen> {
  @override
  Widget build(BuildContext context) {
    log(widget.data_to_be_sent.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Ai Trip Planner"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<Map<dynamic, dynamic>>(
                  future: AiItenirerayService()
                      .getItenirary(widget.data_to_be_sent),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            LoadingAnimationWidget.discreteCircle(
                              size: 50,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Creating Planner, Sit Back And Relax!")
                          ],
                        ));

                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return MarkdownBody(
                            data: snapshot.data!["choices"][0]["message"]
                                    ["content"]
                                .toString(),
                          );
                        }
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
