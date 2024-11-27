import 'package:clean_architecture_impl/data/models/file_model.dart';

abstract class FileBaseDataSource {
  Future<List<FileModel>> fetchFiles();
}
