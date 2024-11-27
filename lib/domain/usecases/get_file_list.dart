import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/repositories/file_repository.dart';

class GetFiles {
  final FileRepository repository;

  GetFiles(this.repository);

  Future<List<FileEntity>> call() {
    return repository.getFiles();
  }
}
