import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpService {
  Dio _dio;
  final baseUrl =
      'https://reqres.in/';
  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    initializeIntecepters();
  }
  Future<Response> getRequest(String endpoint) async {
    Response response;
    try {
      response = await _dio.get(endpoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeIntecepters() {
    _dio.interceptors.add(InterceptorsWrapper(onError: (error) {
      print(error.message);
    }, onRequest: (request) {
      print("${request.method} ${request.path}");
    }, onResponse: (response) {
      print(response.data);
    }));
  }
}
