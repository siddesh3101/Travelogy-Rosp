import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/pehchan/bloc/social_bloc.dart';
import '../pages/pehchan/models/social_media.dart';

class SocialService {
  late final _apiLink;
  late final Dio _dio;

  SocialService() {
    _apiLink = "https://E4.adityasurve1.repl.co";
    _dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "application/json",
        },
        baseUrl: _apiLink,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 200) < 500;
        },
      ),
    );
    // _timeNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
  }

  Future<Map<dynamic, dynamic>> createItinerary(String place, int date) async {
    var data2 = {
      "location": place,
      "limit": date
      // transfer - 4, pending - 0, completed - 1
    };
    print(data2);

    try {
      Response response = await _dio.post(
        '/itenary',
        data: data2,
      );
      print(response.data);

      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Map<dynamic, dynamic>> huhu() async {
    var data2 = {
      'id': '6518004ca59da31963547d35',

      // transfer - 4, pending - 0, completed - 1
    };
    print(data2);

    try {
      Response response = await _dio.get('/social', queryParameters: data2);
      print(response);
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> hehe(BuildContext context) async {
    var data2 = {
      'data': context
          .read<CreateQrBloc>()
          .qrModel
          .userDetails
          .map((SocialMediaData e) => e.toJson())
          .toList(),
      // transfer - 4, pending - 0, completed - 1
    };
    print(data2);

    try {
      Response response = await _dio.post(
        '/social',
        data: data2,
      );
      print(response.data);

      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> delete(String id) async {
    var data2 = {
      'id': id,

      // transfer - 4, pending - 0, completed - 1
    };
    print(data2);

    try {
      Response response = await _dio.delete(
        '/social',
        queryParameters: data2,
      );
      print(response.data);

      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<dynamic> findUser(String q) async {
    var data2 = {
      'q': q,
    };
    print(data2);

    try {
      Response response = await _dio.get(
        '/find',
        queryParameters: data2,
      );
      print(response.data);

      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<List<dynamic>> getItinerary() async {
    try {
      Response response = await _dio.get(
        '/trending',
      );

      return response.data;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
