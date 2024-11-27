import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/usecases/view_file.dart';

class FileViewScreen extends StatefulWidget {
  const FileViewScreen({super.key, required this.entity});

  final FileEntity entity;

  @override
  State<FileViewScreen> createState() => _FileViewScreenState();
}

class _FileViewScreenState extends State<FileViewScreen> {
  final ViewFile viewFile = GetIt.instance<ViewFile>();

  @override
  void initState() {
    super.initState();
    viewFile(widget.entity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entity.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'Viewing file: ${widget.entity.name}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
