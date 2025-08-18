import 'dart:convert';

NewsModel newsModelFromJson(String str) =>
    NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(
      json["articles"].map((x) => Article.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  final Source source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  Article({
    required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"]),
    author: json["author"] as String?, // ✅ String, not enum
    title: json["title"] as String?,
    description: json["description"] as String?,
    url: json["url"] as String?,
    urlToImage: json["urlToImage"] as String?,
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };
}

class Source {
  final String? id;
  final String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"] as String?,
    name: json["name"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
