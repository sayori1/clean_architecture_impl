import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/usecases/download_file.dart';
import 'package:clean_architecture_impl/domain/usecases/get_file_list.dart';
import 'package:clean_architecture_impl/presentation/file_list/widgets/file_widget.dart';
import 'package:clean_architecture_impl/presentation/file_view/file_view_screen.dart';

class FileListScreen extends StatefulWidget {
  const FileListScreen({super.key});

  @override
  State<FileListScreen> createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  final getFiles = GetIt.instance<GetFiles>();
  final downloadFile = GetIt.instance<DownloadFile>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Files')),
      body: FutureBuilder<List<FileEntity>>(
        future: getFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final files = snapshot.data!;
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return FileWidget(
                  fileEntity: file,
                  onDownload: () async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('File "${file.name}" started downloading'),
                      ),
                    );

                    await downloadFile(file);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'File "${file.name}" downloaded successfully!'),
                        ),
                      );
                    }

                    setState(() {});
                  },
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => FileViewScreen(entity: file)));
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No files found.'));
          }
        },
      ),
    );
  }
}
