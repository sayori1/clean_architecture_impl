import 'package:clean_architecture_impl/domain/entities/file_entity.dart';

abstract class FileRepository {
  Future<List<FileEntity>> getFiles();
  Future<List<FileEntity>> getViewedFiles();
  Future<List<FileEntity>> getDownloadedFiles();

  Future<void> markFileAsViewed(FileEntity file);
  Future<void> downloadFile(FileEntity file);
}
