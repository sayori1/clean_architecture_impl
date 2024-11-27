import 'package:clean_architecture_impl/data/models/file_model.dart';
import 'package:clean_architecture_impl/domain/entities/file_entity.dart';

extension FileModelMapper on FileModel {
  FileEntity toEntity() {
    return FileEntity(
      id: id,
      name: name,
    );
  }
}

extension FileEntityMapper on FileEntity {
  FileModel toModel(String url) {
    return FileModel(
      id: id,
      name: name,
    );
  }
}
