import 'dart:math';
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

  final DataTableSource _data = MyData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              PaginatedDataTable(
                  columnSpacing: 40,
                  rowsPerPage: 10,
                  header: Center(child: Text("MY TABLE")),
                  columns: [
                    DataColumn(label: Text('Id')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('price')),
                    DataColumn(label: Text('BarCode'))
                  ],
                  source: _data)
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "barcode": Random().nextInt(1000),
          });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['id'].toString())),
      DataCell(Text(_data[index]['title'])),
      DataCell(Text(_data[index]['price'].toString())),
      DataCell(Text(_data[index]['barcode'].toString()))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}


 // home: Scaffold(
      //   //   resizeToAvoidBottomInset: true,
      //   appBar: AppBar(
      //     title: Text('Model in API'),
      //     actions: [
      //       circular ? CircularProgressIndicator() : Text(data.support.url)
      //     ],
      //   ),
      //   body: SingleChildScrollView(
      //     child: Center(
      //       child: circular
      //           ? CircularProgressIndicator()
      //           : ListView.builder(
      //               itemCount: data.data.length,
      //               shrinkWrap: true,
      //               itemBuilder: (BuildContext context, index) {
      //                 return Container(
      //                   height: 100,
      //                   margin: EdgeInsets.all(3),
      //                   decoration: const BoxDecoration(
      //                     //borderRadius:  BorderRadius.all(10),
      //                     boxShadow: [
      //                       BoxShadow(
      //                         color: Colors.black,
      //                         offset: Offset(
      //                           5.0,
      //                           5.0,
      //                         ), //Offset
      //                         blurRadius: 10.0,
      //                         spreadRadius: 2.0,
      //                       ), //BoxShadow
      //                       BoxShadow(
      //                         color: Colors.white,
      //                         offset: Offset(0.0, 0.0),
      //                         blurRadius: 0.0,
      //                         spreadRadius: 0.0,
      //                       ), //BoxShadow
      //                     ],
      //                   ),
      //                   width: MediaQuery.sizeOf(context).width,
      //                   child: Container(
      //                     width: 100,
      //                     child: ListTile(
      //                       leading: CircleAvatar(
      //                           backgroundImage:
      //                               NetworkImage(data.data[index].avatar)),
      //                       title: Container(
      //                           width: 30,
      //                           child: Text(
      //                             data.data[index].firstName,
      //                             maxLines: 1,
      //                           )),
      //                       subtitle: Container(
      //                           width: 30,
      //                           child: Text(
      //                             data.data[index].lastName,
      //                             maxLines: 1,
      //                           )),
      //                       trailing: Container(
      //                         height: 200,
      //                         child: Column(
      //                           children: [
      //                             Container(
      //                                 // width: 120,
      //                                 child: Text(
      //                               data.data[index].email,
      //                               overflow: TextOverflow.ellipsis,
      //                               softWrap: false,
      //                               maxLines: 1,
      //                             )),
      //                             Container(
      //                               height: 19,
      //                               // width: 120,
      //                               child: Text(
      //                                 data.support.url,
      //                                 overflow: TextOverflow.ellipsis,
      //                                 softWrap: false,
      //                                 maxLines: 1,
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               }),
      //     ),
      //   ),
      // )