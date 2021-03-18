import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:music_app/model/single_user_response.dart';
import 'package:music_app/model/user.dart';

import 'http_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  HttpService httpService;

  SingleUserResponse singleUserResponse;
  User user;
  bool _isLoading = false;
  Future getUser() async {
    Response response;
    try {
      _isLoading = true;
      response = await httpService.getRequest("/api/users/2");
      if (response.statusCode == 200) {
        setState(() {
          singleUserResponse = SingleUserResponse.fromJson(response.data);
          user = singleUserResponse.user;
          print("${user.avator}");
          print("${_isLoading}");
          _isLoading = false;
        });
      } else {
        print("There is some problem");
      }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    httpService = HttpService();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MusicApp'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            :user !=null ? Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Image.network('${user.avator}'),
              SizedBox(
                height: 16,
              ),
              Text("Hello,${user.firstName}"),
            ],
          ),
        ):Center(child: Text("No user object"),),
      ),
    );
  }
}
