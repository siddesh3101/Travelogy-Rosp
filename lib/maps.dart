import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

class AnimatedCircle extends StatefulWidget {
  @override
  _AnimatedCircleState createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with TickerProviderStateMixin {
  final Set<Marker> _markers = {};
  final Set<Circle> _circles = {};
  LatLng? _center;

  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    // set the initial center of the map
    _center = LatLng(37.42796133580664, -122.085749655962);

    // create an animation controller that runs for 5 seconds
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    // create an animation that increases the radius of the circle from 20 to 200 meters and back to 20 meters
    _animation = Tween(begin: 20.0, end: 500.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller!.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller!.forward();
        }
      });

    // start the animation
    _controller!.forward();

    // create a listener that updates the circle's radius as the animation progresses
    _animation!.addListener(() {
      setState(() {
        _circles.clear();
        _circles.add(
          Circle(
            circleId: CircleId('radius'),
            center: _center!,
            radius: _animation!.value,
            fillColor: Colors.blue.withOpacity(0.1),
            strokeColor: Colors.blue,
            strokeWidth: 2,
          ),
        );
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      // create a marker at the center of the map
      _markers.add(
        Marker(
          markerId: MarkerId('center'),
          position: _center!,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );

      // create the initial circle with a radius of 20 meters around the center of the map
      _circles.add(
        Circle(
          circleId: CircleId('radius'),
          center: _center!,
          radius: 20,
          fillColor: Colors.blue.withOpacity(0.1),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ),
      );
    });
  }

  void _onTap(LatLng latLng) {
    // do something when the map is tapped
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Circle'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onTap,
        markers: _markers,
        circles: _circles,
        initialCameraPosition: CameraPosition(
          target: _center!,
          zoom: 15,
        ),
      ),
    );
  }
}
