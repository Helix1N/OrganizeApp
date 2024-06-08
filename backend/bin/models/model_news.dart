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

  @override
  String toString() {
    return 'ModelNews(id: $id, title: $title, description: $description, dtPublication: $dtPublication, dtUpdate: $dtUpdate)';
  }
}
