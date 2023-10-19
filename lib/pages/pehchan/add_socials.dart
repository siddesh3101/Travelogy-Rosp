import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coep/pages/pehchan/models/social_category.dart';
import 'package:coep/pages/pehchan/primary_button.dart';
import 'package:coep/pages/pehchan/social_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../services/itinerary_service.dart';
import 'bloc/social_bloc.dart';
import 'models/social_media.dart';
import 'package:http/http.dart' as http;

class AddSocials extends StatefulWidget {
  static const String routeName = '/addsocials';
  const AddSocials({super.key});

  @override
  State<AddSocials> createState() => _AddSocialsState();
}

class _AddSocialsState extends State<AddSocials> {
  final List<QrCategory> initialSocialList = [QrCategory.instagram];
  final scrollController = ScrollController();
  File? image;

  final qrTitleController = TextEditingController();
  final qrDescController = TextEditingController();
  final List<QrCategory> addOnSocialList = [
    QrCategory.twitter,
    QrCategory.snapchat,
    QrCategory.instagram,
    QrCategory.facebook
  ];

  //

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account added successfully'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/icons/create/animation.json', repeat: false),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                context.read<CreateQrBloc>().qrModel.userDetails = [];
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SocialHomeScreen.routeName,
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Verify your social accounts',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() => this.image = File(image.path));
                        }
                      },
                      child: Stack(
                        children: [
                          // if (image == null)
                          //   Container(
                          //     height: 50,
                          //     width: 50,
                          //     decoration: const BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       color: Color(0xFFDFDDEA),
                          //     ),
                          //     child: Center(
                          //       child: Icon(
                          //         Icons.person_outline_rounded,
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   )
                          // else
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://instagram.fbom36-1.fna.fbcdn.net/v/t51.2885-19/369232318_312700261292658_3328888599565003888_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fbom36-1.fna.fbcdn.net&_nc_cat=106&_nc_ohc=O-99L82JgLYAX9s8Zlp&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfB5M4Gjp6ofzWrqVWjf1aDyVzFKR6EFxUH1X9cTvMeCqg&oe=651E155E&_nc_sid=8b3546'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Icon(Icons.camera_alt, size: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            TextField(
                              controller: qrTitleController,
                              onChanged: (value) {
                                (context.read<CreateQrBloc>().qrModel).name =
                                    value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Siddesh Shetty',
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.purple,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: qrDescController,
                              onChanged: (value) {
                                (context.read<CreateQrBloc>().qrModel)
                                    .description = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Add Description',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                errorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ...List.generate(
                  initialSocialList.length,
                  (index) {
                    return SocialPlatformItemWidget(
                      platform: initialSocialList[index],
                      index: index,
                      onRemove: () {
                        (context.read<CreateQrBloc>().qrModel)
                            .userDetails
                            .removeAt(index);
                        setState(() => initialSocialList.removeAt(index));
                      },
                      onChanged: (value) {},
                    );
                  },
                ),
                const Divider(color: Colors.grey),
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(255, 233, 233, 233)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        'Add New Account',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 16),
                      SocialTileWidget(
                        items1: addOnSocialList,
                        scrollController: scrollController,
                        addToList: (index) {
                          if (initialSocialList.length < 10) {
                            final item = addOnSocialList[index];
                            setState(() {
                              initialSocialList.add(item);
                            });
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                PrimaryButton(
                  text: 'Verify accounts',
                  onPressed: () async {
                    await SocialService().hehe(context);
                    _dialogBuilder(context);
                    // print(context.read<CreateQrBloc>().qrModel.userDetails);

                    // log(map.toString());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialTileWidget extends StatefulWidget {
  const SocialTileWidget({
    required this.scrollController,
    required this.items1,
    required this.addToList,
    super.key,
  });
  final ScrollController scrollController;

  final Function(int) addToList;
  final List<QrCategory> items1;

  @override
  State<SocialTileWidget> createState() => _SocialTileWidgetState();
}

class _SocialTileWidgetState extends State<SocialTileWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return CreateQRMenuItem(
          item: widget.items1[index],
          onTap: () => widget.addToList(index),
        );
      },
    );
  }
}

class CreateQRMenuItem extends StatelessWidget {
  const CreateQRMenuItem(
      {required this.item, required this.onTap, super.key, this.icon});

  final QrCategory item;
  final VoidCallback onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 238, 238, 238),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: icon ??
                  Image.asset(
                    'assets/icons/create/${item.imagePath}',
                    width: 30,
                    height: 30,
                  ),
            ),
          ),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class SocialPlatformItemWidget extends StatefulWidget {
  const SocialPlatformItemWidget({
    required this.index,
    required this.platform,
    required this.onRemove,
    super.key,
    this.onChanged,
  });
  final QrCategory platform;
  final VoidCallback onRemove;
  final int index;
  final Function(String)? onChanged;

  @override
  State<SocialPlatformItemWidget> createState() =>
      _SocialPlatformItemWidgetState();
}

class _SocialPlatformItemWidgetState extends State<SocialPlatformItemWidget> {
  final userNameController = TextEditingController();

  @override
  void initState() {
    (context.read<CreateQrBloc>().qrModel)
        .userDetails
        .add(SocialMediaData(widget.platform, userNameController.text));
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Image.asset(
        'assets/icons/create/${widget.platform.imagePath}',
        width: 40,
      ),
      title: TextField(
        controller: userNameController,
        onChanged: (value) {
          final qrData = context.read<CreateQrBloc>().qrModel;
          qrData.userDetails[widget.index].socialMediaType = widget.platform;
          qrData.userDetails[widget.index].text = value;
        },
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: widget.platform.hint,
        ),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      trailing: IconButton(
        onPressed: widget.onRemove,
        icon: const Icon(
          Icons.remove_circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
