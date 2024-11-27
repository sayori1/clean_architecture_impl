import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/repositories/file_repository.dart';

class GetViewedFiles {
  final FileRepository repository;

  GetViewedFiles(this.repository);

  Future<List<FileEntity>> call() {
    return repository.getViewedFiles();
  }
}
