class FileEntity {
  int id;
  String name;
  bool isDownloaded;
  bool isViewed;

  FileEntity({
    required this.id,
    required this.name,
    this.isDownloaded = false,
    this.isViewed = false,
  });
}
