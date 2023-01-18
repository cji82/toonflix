class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'].toString().replaceAll("&amp;", "&"),
        thumb = json['thumb'],
        id = json['id'];
}
