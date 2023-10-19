// import 'dart:convert';
// import 'dart:html';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// class NewScreen extends StatefulWidget {
//   const NewScreen({super.key});

//   @override
//   State<NewScreen> createState() => _NewScreenState();
// }

// class _NewScreenState extends State<NewScreen> {
//   Future<void> selectAndUploadAudioFile() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ["wav"],
//       withReadStream: true,
//       withData: true,
//     );

//     if (result != null && result.files.isNotEmpty) {
//       String? filePath = result.files.first.path;
//       print(filePath);
//       Dio dio = Dio();
//       dio.options.baseUrl = (r'https://a4d2-103-110-234-115.ngrok-free.app');

//       // dio.options.headers = {"Content-Type": "text/plain"};

//       String fileName = filePath!.split('/').last;

//       FormData data = FormData.fromMap({
//         "file": await MultipartFile.fromFile(
//           filePath,
//           filename: fileName,
//         ),
//       });

//       try {
//         var response = await dio.post("/pedict",
//             data: data,
//             queryParameters: {"userid": "64ff6346bd43796bec1f48b0"});
//         // print(response.data);
//         if (response.statusCode == 200) {
//           print(response.data);
//           // final statusCode = responseBody?['baseResponse']?['statusCode'];

//           // final message = responseBody?['baseResponse']?['message'];
//           // if (statusCode != null && statusCode == '200') {
//           //   final String userName = responseBody?['user']?['firstName'] ?? '';
//           //   final String userId = responseBody?['user']?['userId'] ?? '';
//           //   if (userName.isNotEmpty && userId.isNotEmpty) {
//           //     // var userBox = Hive.box("user");

//           //     userBox.put("userobj", responseBody?['user']);

//           // FreqUsedWidgets.showSnackBar(context, "Updated Successfully");
//         }
//       } catch (e) {}
//     }

//     //selectedAudioFile = result.files.first;
//     // setState(() {
//     //   // Trigger a rebuild to show the selected file information
//     //   callResponseFuture = sendAudioFileToBackendWithRetry(filePath!);
//     // });

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         body: Column(children: [
//           ElevatedButton(
//             onPressed: () {

//             },
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.upload_file),
//                   SizedBox(width: 10),
//                   Text(
//                     "Upload From Device",
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ]),
//           )
//         ]),
//       );
//     }
//   }
// }

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  Future<void> selectAndUploadAudioFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["wav"],
      withReadStream: true,
      withData: true,
    );

    if (result != null && result.files.isNotEmpty) {
      String? filePath = result.files.first.path;
      print(filePath);
      Dio dio = Dio();
      dio.options.baseUrl = ('https://a4d2-103-110-234-115.ngrok-free.app');

      // dio.options.headers = {"Content-Type": "text/plain"};

      String fileName = filePath!.split('/').last;

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });
      print(data);

      try {
        var response = await dio.post("/pedict",
            data: data,
            queryParameters: {"userid": "64ff6346bd43796bec1f48b0"});
        print(response.data);
        // print(response.data);
        if (response.statusCode == 200) {
          print(response.data);

          // final statusCode = responseBody?['baseResponse']?['statusCode'];

          // final message = responseBody?['baseResponse']?['message'];
          // if (statusCode != null && statusCode == '200') {
          //   final String userName = responseBody?['user']?['firstName'] ?? '';
          //   final String userId = responseBody?['user']?['userId'] ?? '';
          //   if (userName.isNotEmpty && userId.isNotEmpty) {
          //     // var userBox = Hive.box("user");

          //     userBox.put("userobj", responseBody?['user']);

          // FreqUsedWidgets.showSnackBar(context, "Updated Successfully");
        }
      } catch (e) {
        print("e" + "${e}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          ElevatedButton(
            onPressed: selectAndUploadAudioFile,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.upload_file),
                  SizedBox(width: 10),
                  Text(
                    "Upload From Device",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          )
        ]),
      ),
    );
  }
}
