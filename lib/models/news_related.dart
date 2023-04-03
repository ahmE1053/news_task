class NewsStoryModel {
  final String source, time, title, category, imageUrl, sourceImage;
  final bool verifiedSource;
  const NewsStoryModel({
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
      sourceImage: json['sourceImage'],
      source: json['source'],
      time: json['time'],
      title: json['title'],
      category: json['category'],
      verifiedSource: json['verifiedSource'],
      imageUrl: json['imageUrl'],
    );
  }
}
