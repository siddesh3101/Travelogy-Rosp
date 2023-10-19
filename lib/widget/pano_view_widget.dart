import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

class PanoramaView extends StatefulWidget {
  final List<Image> children;
  final bool shouldAnimate;
  const PanoramaView(
      {Key? key, required this.children, this.shouldAnimate = true})
      : super(key: key);

  @override
  State<PanoramaView> createState() => _PanoramaViewState();
}

class _PanoramaViewState extends State<PanoramaView> {
  int _panoId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Panorama(
          animSpeed: widget.shouldAnimate ? 1.0 : 0.0,
          sensorControl: SensorControl.Orientation,
          child: widget.children[_panoId],
        ),
        widget.children.length > 1
            ? Positioned(
                bottom: 30,
                right: 20,
                child: FloatingActionButton(
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  onPressed: () {
                    setState(() {
                      _panoId = (_panoId + 1) % widget.children.length;
                    });
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              )
            : Container(),
        widget.children.length > 1
            ? Positioned(
                bottom: 30,
                left: 20,
                child: FloatingActionButton(
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  onPressed: () {
                    setState(() {
                      _panoId = (_panoId - 1 + widget.children.length) %
                          widget.children.length;
                    });
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              )
            : Container(),
        widget.children.length > 1
            ? Positioned(
                bottom: 50,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text('${_panoId + 1}/${widget.children.length}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              )
            : Container()
      ],
    ));
  }
}
