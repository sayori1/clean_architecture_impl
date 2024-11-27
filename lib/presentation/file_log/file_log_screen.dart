import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:clean_architecture_impl/domain/entities/file_entity.dart';
import 'package:clean_architecture_impl/domain/usecases/get_downloaded_files.dart';
import 'package:clean_architecture_impl/domain/usecases/get_viewed_files.dart';

class FileLogScreen extends StatefulWidget {
  const FileLogScreen({super.key});

  @override
  State<FileLogScreen> createState() => _FileLogScreenState();
}

class _FileLogScreenState extends State<FileLogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final getDownloadedFiles = GetIt.instance<GetDownloadedFiles>();
  final getViewedFiles = GetIt.instance<GetViewedFiles>();

  late Future<List<FileEntity>> _downloadedFilesFuture;
  late Future<List<FileEntity>> _viewedFilesFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _downloadedFilesFuture = getDownloadedFiles();
    _viewedFilesFuture = getViewedFiles();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Logs'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.download), text: 'Downloaded Files'),
            Tab(icon: Icon(Icons.visibility), text: 'Viewed Files'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDownloadedFilesTab(),
          _buildViewedFilesTab(),
        ],
      ),
    );
  }

  Widget _buildDownloadedFilesTab() {
    return FutureBuilder<List<FileEntity>>(
      future: _downloadedFilesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No downloaded files.'));
        } else {
          final downloadedFiles = snapshot.data!;
          return ListView.builder(
            itemCount: downloadedFiles.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.file_download),
                title: Text(downloadedFiles[index].name),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildViewedFilesTab() {
    return FutureBuilder<List<FileEntity>>(
      future: _viewedFilesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No viewed files.'));
        } else {
          final viewedFiles = snapshot.data!;
          return ListView.builder(
            itemCount: viewedFiles.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.visibility),
                title: Text(viewedFiles[index].name),
              );
            },
          );
        }
      },
    );
  }
}
