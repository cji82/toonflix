import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
    required this.webtoonid,
  }) : super(key: key);
  final String webtoonid;
  final WebtoonEpisodeModel episode;
  onButtonTap() async {
    final url = Uri.parse(
        "https://m.comic.naver.com/webtoon/detail?titleId=$webtoonid&no=${episode.id}");
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: const ShapeDecoration(
            color: Colors.white,
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.green,
                width: 2,
              ),
            ),
            shadows: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(10.0, 10.0),
                blurRadius: 10.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: 'NGEB',
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
