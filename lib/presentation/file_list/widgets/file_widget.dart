import 'package:flutter/material.dart';
import 'package:clean_architecture_impl/domain/entities/file_entity.dart';

class FileWidget extends StatelessWidget {
  const FileWidget(
      {super.key,
      required this.fileEntity,
      required this.onTap,
      required this.onDownload});

  final FileEntity fileEntity;

  final VoidCallback onTap;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text('id: ${fileEntity.id}'),
                const SizedBox(width: 8),
                Text(fileEntity.name),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: fileEntity.isDownloaded ? null : onDownload,
              icon: Icon(Icons.download,
                  color: fileEntity.isDownloaded ? Colors.blue : Colors.grey))
        ],
      ),
    ));
  }
}
