import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_architecture_impl/data/datasources/user_datasources/user_base_datasource.dart';
import 'package:clean_architecture_impl/domain/entities/file_entity.dart';

class UserLocalDataSource implements UserBaseDataSource {
  static const _viewedFilesKey = 'viewed_files';
  static const _downloadedFilesKey = 'downloaded_files';

  @override
  Future<void> markFileAsViewed(FileEntity file) async {
    final prefs = await SharedPreferences.getInstance();
    final viewedFiles = prefs.getStringList(_viewedFilesKey) ?? [];
    if (!viewedFiles.contains(file.id.toString())) {
      viewedFiles.add(file.id.toString());
      await prefs.setStringList(_viewedFilesKey, viewedFiles);
    }
  }

  @override
  Future<bool> isFileViewed(FileEntity file) async {
    final prefs = await SharedPreferences.getInstance();
    final viewedFiles = prefs.getStringList(_viewedFilesKey) ?? [];
    return viewedFiles.contains(file.id.toString());
  }

  @override
  Future<void> markFileAsDownloaded(FileEntity file) async {
    final prefs = await SharedPreferences.getInstance();
    final downloadedFiles = prefs.getStringList(_downloadedFilesKey) ?? [];
    if (!downloadedFiles.contains(file.id.toString())) {
      downloadedFiles.add(file.id.toString());
      await prefs.setStringList(_downloadedFilesKey, downloadedFiles);
    }
  }

  @override
  Future<bool> isFileDownloaded(FileEntity file) async {
    final prefs = await SharedPreferences.getInstance();
    final downloadedFiles = prefs.getStringList(_downloadedFilesKey) ?? [];
    return downloadedFiles.contains(file.id.toString());
  }
}
