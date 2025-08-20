
class NewCategory {
  final String title;
  final String description;
  final String urlToImage;
  final String author;
  final String publishedAt;

  NewCategory({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.author,
    required this.publishedAt,
  });

  factory NewCategory.fromJson(Map<String, dynamic> json) {
    return NewCategory(
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description",
      urlToImage: json['urlToImage'] ?? "",
      author: json['author'] ?? "Unknown Author",
      publishedAt: json['publishedAt'] ?? "Unknown Date",
    );
  }
}
