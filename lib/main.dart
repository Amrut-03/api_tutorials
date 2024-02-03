import 'dart:convert';

import 'package:api_tutorial/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<UserModel> user_list = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        user_list.add(UserModel.fromJson(i));
      }
      return user_list;
    } else {
      return user_list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          builder: ((context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return ListView.builder(
                  itemCount: user_list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(user_list[index].name.toString()),
                      trailing:
                          Text(user_list[index].address!.geo!.lat.toString()),
                    );
                  });
            } else {
              return Text("Loading..");
            }
          }),
          future: getUserApi(),
        ),
      ),
    );
  }
}
