import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/service/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
  final String proxyUrl =
      "http://lovec.ipdisk.co.kr:8000/url_proxy.php?proxy_url=";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'GamjaFlower',
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(context, snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ScrollConfiguration makeList(
      BuildContext context, AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
        },
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          var webtoon = snapshot.data![index];
          return Webtoon(
            title: webtoon.title,
            thumb: webtoon.thumb,
            id: webtoon.id,
            proxyUrl: proxyUrl,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 40,
        ),
      ),
    );
  }
}
