import 'package:coep/pages/pano_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../services/itinerary_service.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({
    super.key,
    required this.itinerary,
    this.date_of,
    this.price,
  });
  final String? itinerary;
  final int? date_of;
  final String? price;

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  bool expanded = false;
  bool expanded2 = false;
  var rating = 0.0;
  Map<dynamic, dynamic> result = {};
  bool loading = true;

  void createItenary(String place) async {
    var map = await SocialService().createItinerary(place, widget.date_of!);
    print(map.toString());
    setState(() {
      result = map;
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    createItenary(widget.itinerary!);
    // print(result.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.inkDrop(color: Colors.amber, size: 50),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Creating itinerary")
                ],
              ),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    result["Attraction"][0]["img"],
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  // top: MediaQuery.of(context).size.height * 0.25,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        result["location"].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text("India")
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "₹${widget.price ?? 52900}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.amber),
                                      ),
                                      Text("Expected Price")
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Chip(
                                        label: Text(
                                            '${widget.date_of! - 1}N/${widget.date_of}D')),
                                    SizedBox(width: 8.0),
                                    Chip(label: Text('Travel included')),
                                    SizedBox(width: 8.0),
                                    Chip(label: Text('Break Fast')),
                                    SizedBox(width: 8.0),
                                    Chip(label: Text('Sight seeing')),
                                    // SizedBox(width: 8.0),
                                    // Chip(label: Text('Chip 5')),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  // child: PeopleWalkingOnLine(
                                  //   percentage1: 10,
                                  //   percentage2: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GoogleMap(
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(18.9682, 72.8313),
                                        zoom: 12,
                                      ),
                                      markers: {
                                        Marker(
                                          markerId: MarkerId('marker_id'),
                                          position: LatLng(18.9682, 72.8313),
                                          infoWindow: InfoWindow(
                                            title: 'Stylo Salon',
                                            snippet: 'Salon',
                                          ),
                                        ),
                                      },
                                    ),
                                  )
                                  // child: FlutterMap(
                                  //   options: MapOptions(
                                  //     center: latLng.LatLng(19.2952, 72.8544),
                                  //     zoom: 13.0,
                                  //   ),
                                  //   layers: [
                                  //     TileLayerOptions(
                                  //       urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  //       subdomains: ['a', 'b', 'c'],
                                  //     ),
                                  //   ],
                                  // ),
                                  // ),
                                  ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Overview",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Text(
                                  "Planning for a family trip in this holiday? Want to spend some quality time with your beloved ones on this vacation? Thinking about creating some dazzling memories with your family? Here we are with our ${result["location"].toString()} itinerary ${widget.date_of} day trip. Join us on this trip and explore the extravagance the ${result["location"].toString()}."),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Cities",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Chip(
                                        label: Text(
                                            '${result["location"].toString()} (${widget.date_of! - 1}N/${widget.date_of}D)')),
                                    SizedBox(width: 8.0),
                                    // Chip(label: Text('Ubud (1D)')),
                                    // SizedBox(width: 8.0),
                                    // Chip(label: Text(' Nusa Dua (1D)')),
                                    // SizedBox(width: 8.0),
                                    // Chip(label: Text(' Lembongan (2D)')),
                                    // SizedBox(width: 8.0),
                                    // Chip(label: Text('Chip 5')),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Itinerary",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 5,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(139, 137, 137, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.flight,
                                          color:
                                              Color.fromRGBO(139, 137, 137, 1),
                                        ),
                                        Text("Take Plane")
                                      ]),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              SizedBox(
                                // height: 200,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: result["Attraction"].length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    print(result["Attraction"].length);
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 5,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Colors.amber,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Icon(
                                                    //   Icons.flight,
                                                    //   color: Color.fromRGBO(139, 137, 137, 1),
                                                    // ),
                                                    Text(
                                                      result["Attraction"]
                                                          [index]["name"],
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    Text("Day ${index + 1}"),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      height: 80,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.872,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                result["Attraction"]
                                                                        [index]
                                                                    ["img"],
                                                              ))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      result["Attraction"]
                                                                              [
                                                                              index]
                                                                          [
                                                                          "name"],
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                    Text(
                                                                      "Day ${index + 1}",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Spacer(),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      expanded2 =
                                                                          !expanded2;
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    if (expanded2)
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .push(
                                                                  MaterialPageRoute(
                                                            builder: (context) =>
                                                                PanoramaPage(
                                                                    asset: result["Attraction"]
                                                                            [
                                                                            index]
                                                                        [
                                                                        "img"]),
                                                          ));
                                                        },
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                                "On your arrival the international airport of ${result["location"].toString()},\none of our tour coordinator will receive you at the\ninternational flight arrival terminal. You will\nbe escorted to ${result["location"].toString()} on a private cab.."),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 100,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.41,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.blue,
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: DecorationImage(
                                                                          fit: BoxFit.cover,
                                                                          image: AssetImage(
                                                                            "assets/places/place2.jpg",
                                                                          ))),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  height: 100,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.41,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.blue,
                                                                      borderRadius: BorderRadius.circular(15),
                                                                      image: DecorationImage(
                                                                          fit: BoxFit.cover,
                                                                          image: AssetImage(
                                                                            "assets/places/place3.jpg",
                                                                          ))),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       width: 5,
                              //       height: 20,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         color: Color.fromRGBO(139, 137, 137, 1),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 5,
                              //     ),
                              //     Row(children: [
                              //       Icon(
                              //         Icons.directions_car,
                              //         color: Color.fromRGBO(139, 137, 137, 1),
                              //       ),
                              //       Text("Travel By Car")
                              //     ]),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // IntrinsicHeight(
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: 5,
                              //         decoration: ShapeDecoration(
                              //           shape: RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.circular(5)),
                              //           color: Colors.amber,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: 10,
                              //       ),
                              //       Expanded(
                              //         child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               // Icon(
                              //               //   Icons.flight,
                              //               //   color: Color.fromRGBO(139, 137, 137, 1),
                              //               // ),
                              //               Text("Batubulan Village"),
                              //               Text("Day 2"),
                              //               SizedBox(
                              //                 height: 5,
                              //               ),
                              //               Container(
                              //                 height: 80,
                              //                 width:
                              //                     MediaQuery.of(context).size.width *
                              //                         0.872,
                              //                 decoration: BoxDecoration(
                              //                     color: Colors.blue,
                              //                     borderRadius:
                              //                         BorderRadius.circular(15),
                              //                     image: DecorationImage(
                              //                         fit: BoxFit.cover,
                              //                         image: AssetImage(
                              //                           "assets/places/place1.jpg",
                              //                         ))),
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.all(8.0),
                              //                   child: Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.start,
                              //                     children: [
                              //                       Row(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment.start,
                              //                         children: [
                              //                           Column(
                              //                             crossAxisAlignment:
                              //                                 CrossAxisAlignment
                              //                                     .start,
                              //                             children: [
                              //                               Text(
                              //                                 "Mount Batur",
                              //                                 style: TextStyle(
                              //                                     color:
                              //                                         Colors.white),
                              //                               ),
                              //                               Text(
                              //                                 "Day 2",
                              //                                 style: TextStyle(
                              //                                     color:
                              //                                         Colors.white),
                              //                               ),
                              //                             ],
                              //                           ),
                              //                           Spacer(),
                              //                           InkWell(
                              //                             onTap: () {
                              //                               setState(() {
                              //                                 expanded = !expanded;
                              //                               });
                              //                             },
                              //                             child: Icon(
                              //                               Icons.arrow_drop_down,
                              //                               color: Colors.white,
                              //                             ),
                              //                           )
                              //                         ],
                              //                       )
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //               if (expanded)
                              //                 Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Text(
                              //                         "On your arrival the international airport of Bali,\none of our tour coordinator will receive you at the\ninternational flight arrival terminal. You will\nbe escorted to Bali Denpasar on a private cab.."),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Row(
                              //                       children: [
                              //                         Container(
                              //                           height: 100,
                              //                           width: MediaQuery.of(context)
                              //                                   .size
                              //                                   .width *
                              //                               0.43,
                              //                           decoration: BoxDecoration(
                              //                               color: Colors.blue,
                              //                               borderRadius:
                              //                                   BorderRadius.circular(
                              //                                       15),
                              //                               image: DecorationImage(
                              //                                   fit: BoxFit.cover,
                              //                                   image: AssetImage(
                              //                                     "assets/places/place2.jpg",
                              //                                   ))),
                              //                         ),
                              //                         SizedBox(
                              //                           width: 5,
                              //                         ),
                              //                         Container(
                              //                           height: 100,
                              //                           width: MediaQuery.of(context)
                              //                                   .size
                              //                                   .width *
                              //                               0.43,
                              //                           decoration: BoxDecoration(
                              //                               color: Colors.blue,
                              //                               borderRadius:
                              //                                   BorderRadius.circular(
                              //                                       15),
                              //                               image: DecorationImage(
                              //                                   fit: BoxFit.cover,
                              //                                   image: AssetImage(
                              //                                     "assets/places/place3.jpg",
                              //                                   ))),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 )
                              //             ]),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Hotels",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),

                              SizedBox(
                                // height: 200,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: result["lodge"].length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 5,
                                              decoration: ShapeDecoration(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                color: Colors.amber,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Icon(
                                                    //   Icons.flight,
                                                    //   color: Color.fromRGBO(139, 137, 137, 1),
                                                    // ),
                                                    Text(result["lodge"][index]
                                                        ["name"]),

                                                    Text(
                                                        "Day ${result["lodge"][index]["Day"]}"),

                                                    // SizedBox(
                                                    //   height: 5,
                                                    // ),
                                                    Container(
                                                      height: 100,
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              result["lodge"]
                                                                      [index]
                                                                  ["img"],
                                                              fit: BoxFit.cover,
                                                              width: 80,
                                                              height: 80,
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(result["lodge"]
                                                                        [index]
                                                                    ["name"]),
                                                                SmoothStarRating(
                                                                  rating: double.parse(
                                                                      result["lodge"]
                                                                              [
                                                                              index]
                                                                          [
                                                                          "rating"]),
                                                                  size: 20,
                                                                  starCount: 5,
                                                                  borderColor:
                                                                      Colors
                                                                          .black,
                                                                  color: Colors
                                                                      .black,
                                                                  onRatingChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      rating =
                                                                          value;
                                                                    });
                                                                  },
                                                                ),
                                                                // Text(
                                                                //   "Desa Jungut Batu, 80771 Nusa \nLembongan,Indonesia",
                                                                //   style: TextStyle(
                                                                //       color: Color.fromRGBO(
                                                                //           133,
                                                                //           133,
                                                                //           133,
                                                                //           1)),
                                                                // )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (expanded)
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "On your arrival the international airport of ${result["location"].toString()},\none of our tour coordinator will receive you at the\ninternational flight arrival terminal. You will\nbe escorted to ${result["location"].toString()} on a private cab.."),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                height: 100,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.43,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.blue,
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: AssetImage(
                                                                          "assets/places/place2.jpg",
                                                                        ))),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                height: 100,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.43,
                                                                decoration: BoxDecoration(
                                                                    color: Colors.blue,
                                                                    borderRadius: BorderRadius.circular(15),
                                                                    image: DecorationImage(
                                                                        fit: BoxFit.cover,
                                                                        image: AssetImage(
                                                                          "assets/places/place3.jpg",
                                                                        ))),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // IntrinsicHeight(
                              //   child:
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              // IntrinsicHeight(
                              //   child: Row(
                              //     children: [
                              //       Container(
                              //         width: 5,
                              //         decoration: ShapeDecoration(
                              //           shape: RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.circular(5)),
                              //           color: Colors.amber,
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         width: 10,
                              //       ),
                              //       Expanded(
                              //         child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               // Icon(
                              //               //   Icons.flight,
                              //               //   color: Color.fromRGBO(139, 137, 137, 1),
                              //               // ),
                              //               Text("Ubud"),
                              //               Text("Day 4"),
                              //               // SizedBox(
                              //               //   height: 5,
                              //               // ),
                              //               Container(
                              //                 height: 100,
                              //                 child: Row(
                              //                   children: [
                              //                     ClipRRect(
                              //                       borderRadius:
                              //                           BorderRadius.circular(10),
                              //                       child: Image.asset(
                              //                         'assets/places/place4.jpg',
                              //                         fit: BoxFit.cover,
                              //                         width: 80,
                              //                         height: 80,
                              //                       ),
                              //                     ),
                              //                     SizedBox(width: 10),
                              //                     Padding(
                              //                       padding: const EdgeInsets.only(
                              //                           top: 10),
                              //                       child: Column(
                              //                         crossAxisAlignment:
                              //                             CrossAxisAlignment.start,
                              //                         children: [
                              //                           Text(
                              //                               'Sammada Hotel & Beach Club'),
                              //                           SmoothStarRating(
                              //                             rating: rating,
                              //                             size: 20,
                              //                             starCount: 5,
                              //                             borderColor: Colors.black,
                              //                             color: Colors.black,
                              //                             onRatingChanged: (value) {
                              //                               setState(() {
                              //                                 rating = value;
                              //                               });
                              //                             },
                              //                           ),
                              //                           // SizedBox(
                              //                           //   height: 10,
                              //                           // ),
                              //                           Text(
                              //                             "Desa Jungut Batu, 80771 Nusa \nLembongan,Indonesia",
                              //                             style: TextStyle(
                              //                                 color: Color.fromRGBO(
                              //                                     133, 133, 133, 1)),
                              //                           )
                              //                         ],
                              //                       ),
                              //                     ),
                              //                   ],
                              //                 ),
                              //               ),
                              //               if (expanded)
                              //                 Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: [
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Text(
                              //                         "On your arrival the international airport of Bali,\none of our tour coordinator will receive you at the\ninternational flight arrival terminal. You will\nbe escorted to Bali Denpasar on a private cab.."),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     Row(
                              //                       children: [
                              //                         Container(
                              //                           height: 100,
                              //                           width: MediaQuery.of(context)
                              //                                   .size
                              //                                   .width *
                              //                               0.43,
                              //                           decoration: BoxDecoration(
                              //                               color: Colors.blue,
                              //                               borderRadius:
                              //                                   BorderRadius.circular(
                              //                                       15),
                              //                               image: DecorationImage(
                              //                                   fit: BoxFit.cover,
                              //                                   image: AssetImage(
                              //                                     "assets/places/place2.jpg",
                              //                                   ))),
                              //                         ),
                              //                         SizedBox(
                              //                           width: 5,
                              //                         ),
                              //                         Container(
                              //                           height: 100,
                              //                           width: MediaQuery.of(context)
                              //                                   .size
                              //                                   .width *
                              //                               0.43,
                              //                           decoration: BoxDecoration(
                              //                               color: Colors.blue,
                              //                               borderRadius:
                              //                                   BorderRadius.circular(
                              //                                       15),
                              //                               image: DecorationImage(
                              //                                   fit: BoxFit.cover,
                              //                                   image: AssetImage(
                              //                                     "assets/places/place3.jpg",
                              //                                   ))),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 )
                              //             ]),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(132, 255, 112, 1),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Inclusions",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Accommodation")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Breakfast")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("All Airport Transfers")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Accommodation")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Accommodation")
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    height: MediaQuery.of(context).size.height *
                                        0.20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                255, 112, 112, 0.5)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Exclusions",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Lunch")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Dinner")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Airfare")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Visa")
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("•"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("Travel Insurance")
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
