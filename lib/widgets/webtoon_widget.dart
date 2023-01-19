import 'package:flutter/material.dart';
import 'package:toonflix/widgets/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id /*, proxyUrl*/;
  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
    //required this.proxyUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
              //proxyUrl: proxyUrl,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.5),
                    )
                  ]),
              width: 250,
              child: Image.network(/*proxyUrl + */ thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontFamily: 'NGR'),
          ),
        ],
      ),
    );
  }
}
