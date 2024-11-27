import 'package:get_it/get_it.dart';
import 'package:clean_architecture_impl/data/datasources/file_datasources/file_base_datasource.dart';
import 'package:clean_architecture_impl/data/datasources/file_datasources/file_mock_datasource.dart';
import 'package:clean_architecture_impl/data/datasources/user_datasources/user_base_datasource.dart';
import 'package:clean_architecture_impl/data/datasources/user_datasources/user_local_datasource.dart';
import 'package:clean_architecture_impl/data/repositories/file_repository_impl.dart';
import 'package:clean_architecture_impl/domain/repositories/file_repository.dart';
import 'package:clean_architecture_impl/domain/usecases/download_file.dart';
import 'package:clean_architecture_impl/domain/usecases/get_downloaded_files.dart';
import 'package:clean_architecture_impl/domain/usecases/get_file_list.dart';
import 'package:clean_architecture_impl/domain/usecases/get_viewed_files.dart';
import 'package:clean_architecture_impl/domain/usecases/view_file.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<FileBaseDataSource>(() => FileMockDataSource());
  getIt.registerLazySingleton<UserBaseDataSource>(() => UserLocalDataSource());

  getIt.registerLazySingleton<FileRepository>(
    () => FileRepositoryImpl(
        fileDataSource: getIt<FileBaseDataSource>(),
        userDataSource: getIt<UserBaseDataSource>()),
  );

  getIt.registerLazySingleton(() => GetFiles(getIt<FileRepository>()));
  getIt.registerLazySingleton(() => DownloadFile(getIt<FileRepository>()));
  getIt.registerLazySingleton(() => ViewFile(getIt<FileRepository>()));
  getIt
      .registerLazySingleton(() => GetDownloadedFiles(getIt<FileRepository>()));
  getIt.registerLazySingleton(() => GetViewedFiles(getIt<FileRepository>()));
}
