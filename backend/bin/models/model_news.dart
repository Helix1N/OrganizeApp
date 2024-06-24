class ModelNews {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime dtPublication;
  final DateTime? dtUpdate;

  ModelNews(
    this.id,
    this.title,
    this.description,
    this.image,
    this.dtPublication,
    this.dtUpdate,
  );

  factory ModelNews.fromJson(Map json) {
    return ModelNews(
        json['id'],
        json['title'],
        json['description'],
        json['image'],
        DateTime.parse(json['dtPublication']),
        DateTime.parse(json['dtUpdate']));
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelNews &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.dtPublication == dtPublication &&
        other.dtUpdate == dtUpdate;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      image.hashCode ^
      dtPublication.hashCode ^
      dtUpdate.hashCode;

  @override
  String toString() {
    return 'ModelNews(id: $id, title: $title, description: $description, dtPublication: $dtPublication, dtUpdate: $dtUpdate)';
  }
}
