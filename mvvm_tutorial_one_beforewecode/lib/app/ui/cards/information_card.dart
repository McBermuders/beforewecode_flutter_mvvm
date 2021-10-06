class Information {
  final int id;
  final String title;
  final String description;
  final String imageURL;
  final List<Information>? children;

  Information(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageURL,
      required this.children});

  factory Information.fromJson(Map<String, dynamic> json) {
    final child = json['children'] as List?;
    List<Information>? imagesList;
    if (child != null && child.isNotEmpty) {
      imagesList = child.map((i) => Information.fromJson(i)).toList();
    }
    return Information(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      imageURL: json['imageURL'] as String? ?? "",
      children: imagesList,
    );
  }
}
