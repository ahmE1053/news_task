import '../../models/news_model.dart';

List<NewsStoryModel> jsonParser(dynamic json) {
  return (List<Map<String, dynamic>>.from(json).map((value) {
    final json = {
      'sourceImage': 'assets/cnn.png',
      'source': value['source']['name'],
      'time': value['publishedAt'],
      'title': value['title'],
      'category': 'News',
      'verifiedSource': true,
      'imageUrl': value['urlToImage'] ?? '',
    };
    return NewsStoryModel.fromJson(json);
  })).toList();
}
