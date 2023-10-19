import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:panorama/panorama.dart';

import '../widget/pano_view_widget.dart';

class PanoramaPage extends StatefulWidget {
  const PanoramaPage({super.key, this.asset});
  final String? asset;

  @override
  State<PanoramaPage> createState() => _PanoramaPageState();
}

class _PanoramaPageState extends State<PanoramaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PanoramaView(children: [
      Image.asset("assets/pano_nature.jpg"),
      // Image.asset("assets/pano_nature.jpg"),
      // Image.asset("assets/pano_nature.jpg")
    ]));
  }
}
