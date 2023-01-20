import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(const MyWidget());
}

class ApiService {
  static Future<String> getDomain(String masterurl) async {
    final url = Uri.parse(masterurl);
    final respones = await http.readBytes(url, headers: {
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.76",
      "Access-Control-Allow-Origin": "*"
    });
    if (respones.isNotEmpty) {
      final reg = RegExp(
          '<\\s*a(\\shref=("[http|https].*?")+.*?>|>).*?<\\s*/\\s*a\\s*>');
      var str = utf8.decode(respones);
      var match = reg.firstMatch(str);
      JsonEncoder encoder = const JsonEncoder();
      return reg.hasMatch(str)
          ? encoder.convert({'url': match!.group(2).toString()})
          : encoder.convert({'url': 'NotFound'});
    }
    throw Error();
  }

  static Future<String> getData(String masterurl, String subUrl) async {
    final location = '$masterurl$subUrl'.replaceAll("\"", "");
    final url = Uri.parse(location);
    final respones = await http.get(url, headers: {
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36 Edg/108.0.1462.76",
      "Access-Control-Allow-Origin": "*"
    });
    if (respones.statusCode == 200) {
      print(respones.body);
    }
    throw Error();
  }
}

class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  //static const String masterurl = "https://blacktoon.net/";
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  //late String masterurl;
  late Future<String> domain;

  @override
  void initState() {
    super.initState();
    domain = ApiService.getDomain("https://blacktoon.net/");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'getDomin',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            FutureBuilder(
              future: domain,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> jdata = jsonDecode(snapshot.data!);
                  ApiService.getData(jdata['url'], "/data/webtoon_0.js");
                  ApiService.getData(jdata['url'], "/data/webtoon_0.js");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'NGR',
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
