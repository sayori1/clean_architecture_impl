import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/repositories/file_repository.dart';

class DownloadFile {
  final FileRepository repository;

  DownloadFile(this.repository);

  Future<void> call(FileEntity entity) async {
    if (!entity.isDownloaded) {
      await repository.downloadFile(entity);
    }
  }
}
