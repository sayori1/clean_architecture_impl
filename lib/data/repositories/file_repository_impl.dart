import 'package:clean_architecture_impl/data/datasources/file_datasources/file_base_datasource.dart';
import 'package:clean_architecture_impl/data/datasources/user_datasources/user_base_datasource.dart';
import 'package:clean_architecture_impl/data/mappers/file_mapper.dart';
import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/repositories/file_repository.dart';
import 'package:clean_architecture_impl/data/models/file_model.dart';

class FileRepositoryImpl implements FileRepository {
  final FileBaseDataSource fileDataSource;
  final UserBaseDataSource userDataSource;

  FileRepositoryImpl(
      {required this.fileDataSource, required this.userDataSource});

  @override
  Future<List<FileEntity>> getFiles() async {
    final List<FileModel> models = await fileDataSource.fetchFiles();

    var fileEntities = models.map((e) => e.toEntity()).toList();

    for (int i = 0; i < fileEntities.length; i++) {
      fileEntities[i].isDownloaded =
          await userDataSource.isFileDownloaded(fileEntities[i]);
      fileEntities[i].isViewed =
          await userDataSource.isFileViewed(fileEntities[i]);
    }

    return fileEntities;
  }

  @override
  Future<void> markFileAsViewed(FileEntity file) {
    return userDataSource.markFileAsViewed(file);
  }

  @override
  Future<void> downloadFile(FileEntity file) async {
    await Future.delayed(const Duration(seconds: 1)); //эмуляция скачивания
    return userDataSource.markFileAsDownloaded(file);
  }

  @override
  Future<List<FileEntity>> getDownloadedFiles() async {
    var files = await getFiles();
    return files.where((file) => file.isDownloaded).toList();
  }

  @override
  Future<List<FileEntity>> getViewedFiles() async {
    var files = await getFiles();
    return files.where((file) => file.isViewed).toList();
  }
}
