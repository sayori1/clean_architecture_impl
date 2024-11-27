import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/repositories/file_repository.dart';

class ViewFile {
  final FileRepository repository;

  ViewFile(this.repository);

  Future<void> call(FileEntity file) async {
    return repository.markFileAsViewed(file);
  }
}
