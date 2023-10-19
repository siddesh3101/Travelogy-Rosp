import 'package:coep/pages/pehchan/social_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../services/itinerary_service.dart';
import 'add_socials.dart';
import 'find_user_screen.dart';

class SocialDashboard extends StatefulWidget {
  const SocialDashboard({super.key});

  @override
  State<SocialDashboard> createState() => _SocialDashboardState();
}

class _SocialDashboardState extends State<SocialDashboard> {
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          readOnly: true,
                          autofocus: false,
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              FindUserScreen.routeName,
                            ).then((value) {
                              createItenary();
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Add new socials',
                            focusColor: Colors.black,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '  My Socials',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, height: 0.5),
            textAlign: TextAlign.left,
          ),
          // chipList(),
          loading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      LoadingAnimationWidget.discreteCircle(
                        size: 50,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Fetching profiles")
                    ],
                  ),
                )
              : SizedBox(
                  // height: 200,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      createItenary();
                      setState(() {});
                    },
                    child: result.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                      'assets/icons/create/anim2.json',
                                      width: 100,
                                      height: 100),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'No accounts linked',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: result.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.green),
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Color.fromARGB(255, 240, 240, 240)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            if (result[index]["website"] ==
                                                'instagram')
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Image.asset(
                                                  'assets/icons/create/instagram.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            if (result[index]["website"] ==
                                                'twitter')
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Image.asset(
                                                  'assets/icons/create/twitter.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            if (result[index]["website"] ==
                                                'snapchat')
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Image.asset(
                                                  'assets/icons/create/snapchat.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              result[index]["username"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            Image.asset(
                                              'assets/icons/create/verified.png',
                                              fit: BoxFit.cover,
                                              width: 30,
                                              height: 30,
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                await SocialService().delete(
                                                    result[index]['_id']);
                                                setState(() {
                                                  result.removeAt(index);
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          Text(
            '  Incoming Friend Request',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, height: 0.5),
            textAlign: TextAlign.left,
          ),

          if (result1.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset('assets/icons/create/anim2.json',
                        width: 100, height: 100),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'No requests pending',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          if (result1.isNotEmpty)
            ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              itemCount: result1.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 240, 240, 240)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => _dialogBuilder(context, index, result1,
                                result1[index]['name']),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    result1[index]['image'],
                                    fit: BoxFit.fill,
                                    width: 70,
                                    height: 70,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  result1[index]['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Image.asset(
                                  'assets/icons/create/flag.png',
                                  fit: BoxFit.cover,
                                  width: 30,
                                  height: 30,
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    // await SocialService()
                                    //     .delete(result[index]
                                    //         ['_id']);
                                    // setState(() {
                                    //   result.removeAt(index);
                                    // });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color.fromARGB(
                                              255, 255, 166, 159)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          'Suspicious',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
