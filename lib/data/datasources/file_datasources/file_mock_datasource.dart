import 'package:clean_architecture_impl/data/datasources/file_datasources/file_base_datasource.dart';
import 'package:clean_architecture_impl/data/models/file_model.dart';

class FileMockDataSource extends FileBaseDataSource {
  @override
  Future<List<FileModel>> fetchFiles() async {
    return [
      FileModel(id: 0, name: "First file"),
      FileModel(id: 1, name: "Second file"),
      FileModel(id: 2, name: "Third file"),
      FileModel(id: 3, name: "Fourth file"),
    ];
  }
}
