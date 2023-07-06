import 'package:flutter/material.dart';
import 'package:flutter_application_for_api_integration/Model/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late HttpsReqresInApiUsersPage2 data;
  bool circular = true;
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    // getting response on request
    var res = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    // to convert json stream into normal map type of data
    setState(() {
      data = HttpsReqresInApiUsersPage2.fromJson(jsonDecode(res.body));
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Model in API'),
          ),
          body: Center(
            child: circular
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: 6,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(data.data[index].avatar)),
                        title: Text(data.data[index].firstName),
                        subtitle: Text(data.data[index].lastName),
                        trailing: Text(data.data[index].email),
                      );
                    }),
          ),
        ));
  }
}
