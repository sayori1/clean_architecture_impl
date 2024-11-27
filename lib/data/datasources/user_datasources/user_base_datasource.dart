import 'package:clean_architecture_impl/domain/entities/file_entity.dart';

abstract class UserBaseDataSource {
  Future<void> markFileAsViewed(FileEntity file);
  Future<bool> isFileViewed(FileEntity file);
  Future<void> markFileAsDownloaded(FileEntity file);
  Future<bool> isFileDownloaded(FileEntity file);
}
