// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String _searchQuery = '';
//   List<dynamic> result = [{}];
//   bool loading = true;

//   // List<Map<dynamic, dynamic>> _list = [
//   //   {'name': 'John', 'age': 25},
//   //   {'name': 'Jane', 'age': 30},
//   //   {'name': 'Bob', 'age': 35},
//   //   {'name': 'Alice', 'age': 40},
//   //   {'name': 'Tom', 'age': 45},
//   // ];

//   List<dynamic> _searchList = [];

//   @override
//   void initState() {
//     super.initState();
//     getItinerary();

//     Future.delayed(Duration(seconds: 8), () {
//       setState(() {
//         _searchList.addAll(result);
//         loading = false;
//       });
//     });
//   }

//   void _handleSearch(String query) {
//     List<dynamic> results = [];
//     if (query.isNotEmpty) {
//       results = result
//           .where((item) =>
//               item['name'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     } else {
//       results.addAll(result);
//     }

//     setState(() {
//       _searchQuery = query;
//       _searchList.clear();
//       _searchList.addAll(results);
//     });
//   }

//   void getItinerary() async {
//     var data = await SocialService().getItinerary();
//     // print(data.toList());
//     setState(() {
//       result = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Travelogy",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: loading
//           ? Center(
//               child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 LoadingAnimationWidget.fourRotatingDots(
//                   size: 50,
//                   color: Colors.amber,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text("Curating Packages")
//               ],
//             ))
//           : Padding(
//               padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     onChanged: _handleSearch,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       hintText: 'Search for places',
//                       focusColor: Colors.black,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   if (_searchList.isNotEmpty)
//                     Text(
//                       "Trending Places",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                     ),
//                   if (_searchList.isNotEmpty)
//                     SizedBox(
//                       height: 10,
//                     ),
//                   if (_searchList.isNotEmpty)
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: _searchList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 10),
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => ItineraryScreen(
//                                       itinerary: _searchList[index]["name"]),
//                                 ));
//                               },
//                               child: Container(
//                                 // height: 200,
//                                 decoration: BoxDecoration(
//                                     color: Color.fromRGBO(239, 239, 239, 1),
//                                     borderRadius: BorderRadius.circular(15)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           child: Image.network(
//                                             _searchList[index]["img"],
//                                             fit: BoxFit.cover,
//                                             width: 120,
//                                             height: 120,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 10),
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 10),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               _searchList[index]["name"],
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16),
//                                             ),
//                                             Text(
//                                               'India',
//                                               style: TextStyle(
//                                                   color: Colors.black),
//                                             ),
//                                             SmoothStarRating(
//                                               rating: double.parse(
//                                                   _searchList[index]["rating"]),
//                                               size: 20,
//                                               starCount: 5,
//                                               borderColor: Colors.black,
//                                               color: Colors.black,
//                                               onRatingChanged: (value) {
//                                                 setState(() {
//                                                   // rating = value;
//                                                 });
//                                               },
//                                             ),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             Text(
//                                               '6N/7D',
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 16),
//                                             ),
//                                             Text(
//                                               "₹52,900",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 25,
//                                                   color: Colors.amber),
//                                             ),
//                                             Text(
//                                               'Expected Price',
//                                               style: TextStyle(
//                                                 color: Colors.black,
//                                                 height: 1,
//                                                 fontSize: 10,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 10, right: 10),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 10),
//                                               child:
//                                                   Icon(Icons.favorite_border),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   if (_searchList.isEmpty)
//                     Text(
//                       "Curated Itinerary",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                     ),
//                   if (_searchList.isEmpty)
//                     SizedBox(
//                       height: 10,
//                     ),
//                   if (_searchList.isEmpty)
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>
//                               ItineraryScreen(itinerary: _searchQuery),
//                         ));
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.34,
//                         height: MediaQuery.of(context).size.height * 0.20,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             // color: Colors.red,
//                             image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage("assets/places/place1.jpg"))),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   _searchQuery,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 22,
//                                       color: Colors.white),
//                                 ),
//                                 Text(
//                                   "India",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                       height: 1,
//                                       color: Colors.white.withOpacity(0.8)),
//                                 )
//                               ]),
//                         ),
//                       ),
//                     )
//                 ],
//               ),
//             ),
//     );
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../services/itinerary_service.dart';
import 'itinerary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.intt, this.finn, required this.date});
  final String? intt;
  final String? finn;
  final int date;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  List<dynamic> result = [{}];
  bool loading = true;
  final List<double> _prices = List.generate(
    20,
    (_) => Random().nextDouble() * (50000 - 30000) + 30000,
  );

  // List<Map<dynamic, dynamic>> _list = [
  //   {'name': 'John', 'age': 25},
  //   {'name': 'Jane', 'age': 30},
  //   {'name': 'Bob', 'age': 35},
  //   {'name': 'Alice', 'age': 40},
  //   {'name': 'Tom', 'age': 45},
  // ];

  List<dynamic> _searchList = [];

  @override
  void initState() {
    super.initState();
    print("entered");
    print(widget.date);
    getItinerary();

    Future.delayed(Duration(seconds: 8), () {
      setState(() {
        _searchList.addAll(result);
        loading = false;
      });
    });
  }

  void _handleSearch(String query) {
    List<dynamic> results = [];
    if (query.isNotEmpty) {
      results = result
          .where((item) =>
              item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      results.addAll(result);
    }

    setState(() {
      _searchQuery = query;
      _searchList.clear();
      _searchList.addAll(results);
    });
  }

  void getItinerary() async {
    var data = await SocialService().getItinerary();
    // print(data.toList());
    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FlyCast",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: loading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.fourRotatingDots(
                  size: 50,
                  color: Colors.amber,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Curating Packages")
              ],
            ))
          : Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: _handleSearch,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search for places',
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (_searchList.isNotEmpty)
                    Text(
                      "Trending Places",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  if (_searchList.isNotEmpty)
                    SizedBox(
                      height: 10,
                    ),
                  if (_searchList.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: _searchList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var price = _prices[Random().nextInt(_prices.length)]
                              .toStringAsFixed(0);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ItineraryScreen(
                                    itinerary: _searchList[index]["name"],
                                    date_of: widget.date,
                                    price: price,
                                  ),
                                ));
                              },
                              child: Container(
                                // height: 200,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(239, 239, 239, 1),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            _searchList[index]["img"],
                                            fit: BoxFit.cover,
                                            width: 120,
                                            height: 120,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _searchList[index]["name"],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              'India',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            SmoothStarRating(
                                              rating: double.parse(
                                                  _searchList[index]["rating"]),
                                              size: 20,
                                              starCount: 5,
                                              borderColor: Colors.black,
                                              color: Colors.black,
                                              onRatingChanged: (value) {
                                                setState(() {
                                                  // rating = value;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              '${widget.date - 1}N/${widget.date}D',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              "₹${price}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.amber),
                                            ),
                                            Text(
                                              'Expected Price',
                                              style: TextStyle(
                                                color: Colors.black,
                                                height: 1,
                                                fontSize: 10,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child:
                                                  Icon(Icons.favorite_border),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (_searchList.isEmpty)
                    Text(
                      "Curated Itinerary",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  if (_searchList.isEmpty)
                    SizedBox(
                      height: 10,
                    ),
                  if (_searchList.isEmpty)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItineraryScreen(
                            itinerary: _searchQuery,
                            date_of: widget.date,
                            price: null,
                          ),
                        ));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.34,
                        height: MediaQuery.of(context).size.height * 0.20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // color: Colors.red,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/places/place1.jpg"))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _searchQuery,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.white),
                                ),
                                Text(
                                  "India",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      height: 1,
                                      color: Colors.white.withOpacity(0.8)),
                                )
                              ]),
                        ),
                      ),
                    )
                ],
              ),
            ),
    );
  }
}
