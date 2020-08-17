import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jadwalsholat/header_content.dart';
import 'package:jadwalsholat/model/response_jadwal.dart';
import 'package:jadwalsholat/list_jadwal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jadwal Sholat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  TextEditingController _locationControler = TextEditingController();

  //request data api
  Future<ResponseJadwal> getJadwal({String location}) async {
    //url api
    String url =
        'https://api.pray.zone/v2/times/today.json?city=$location&school=9';

    final response = await http.get(url);
    final jsonResponse = json.decode(response.body);

    return ResponseJadwal.fromJsonMap(jsonResponse);
  }

  @override
  void initState() {
    if (_locationControler.text.isEmpty || _locationControler.text == null) {
      _locationControler.text = "bogor";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final body = Expanded(
        child: FutureBuilder(
            future: getJadwal(
                location: _locationControler.text.toLowerCase().toString()),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return ListJadwal(snapShot.data);
              } else if (snapShot.hasError) {
                print(snapShot.error);
                return Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'data tidak tersedia',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()));
            }));

    final header = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width - 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  offset: Offset(0.0, 2.0),
                  color: Colors.black26,
                ),
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/f6/4a/36/f64a368af3e8fd29a1b6285f3915c7d4.jpg"))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Tooltip(
                message: 'Ubah Lokasi',
              ),
              IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    _showDialogLocation(context);
                  }),
            ],
          ),
        ),
        FutureBuilder(
            future: getJadwal(
                location: _locationControler.text.toLowerCase().toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HeaderContent(snapshot.data);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                    child: Text('Data tidak tersedia',
                        style: TextStyle(color: Colors.white)
                    ),
                );
              }
              return Center(child: CircularProgressIndicator());
            })
      ],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[header, body],
      ),
    );
  }

  _showDialogLocation(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ubah lokasi'),
            content: TextField(
              controller: _locationControler,
              decoration: InputDecoration(hintText: 'Masukan lokasi'),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, () {
                      setState(() {
                        getJadwal(location: _locationControler.text.toLowerCase().toString());
                      });
                    });
                  },
                  child: Text("CANCEL")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, () {
                      setState(() {
                        getJadwal(
                            location: _locationControler.text
                                .toLowerCase()
                                .toString());
                      });
                    });
                  },
                  child: Text("OK")),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
          );
        });
  }
}
