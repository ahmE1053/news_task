import 'package:isar/isar.dart';
part 'news_model.g.dart';

@collection
class NewsStoryModel {
  final Id id;

  final String source, time, title, category, imageUrl, sourceImage;
  final bool verifiedSource;

  const NewsStoryModel({
    required this.id,
    required this.source,
    required this.sourceImage,
    required this.time,
    required this.title,
    required this.category,
    required this.verifiedSource,
    required this.imageUrl,
  });

  static NewsStoryModel fromJson(Map<String, dynamic> json) {
    return NewsStoryModel(
      id: int.parse(json['time'].toString().replaceAll(RegExp(r"\D"), '')),
      sourceImage: json['sourceImage'],
      source: json['source'],
      time:
          '${DateTime.now().difference(DateTime.parse(json['time'])).inHours} hours ago',
      title: json['title'],
      category: json['category'],
      verifiedSource: json['verifiedSource'],
      imageUrl: json['imageUrl'],
    );
  }
}
