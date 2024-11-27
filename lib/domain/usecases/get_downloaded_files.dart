import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/repositories/file_repository.dart';

class GetDownloadedFiles {
  final FileRepository repository;

  GetDownloadedFiles(this.repository);

  Future<List<FileEntity>> call() {
    return repository.getDownloadedFiles();
  }
}
