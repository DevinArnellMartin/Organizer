import 'package:flutter/material.dart';
import 'help.dart';
import 'cards.dart';
import 'models.dart';

class FolderScrn extends StatefulWidget {
  const FolderScrn({super.key});

  @override
  _FolderScrnState createState() => _FolderScrnState();
}

class _FolderScrnState extends State<FolderScrn> {
  List<Map<String, dynamic>> _folders = [];
  final DatabaseHelper helper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    fetch(); 
  }
  Future<void> fetch() async {
    final List<Map<String, dynamic>> folders = await helper.getAllFolders();
    setState(() {
      _folders = folders;
    });
  }
  Future<void> del(int folderId) async {
    await helper.deleteFolderWithCards(folderId); 
    fetch(); 
  }
  Future<void> monstrarDel(int folderId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Folder'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Delete this and all the cards?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await del(folderId); 
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Organizer - Folders'),
      ),
      body: ListView.builder(
        itemCount: _folders.length,
        itemBuilder: (context, idx) {
          final folder = _folders[idx];
          return ListTile(
            title: Text(folder['folder_name']),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => monstrarDel(folder['id']), 
            ),
            onTap: () {
              
            },
          );
        },
      ),
    );
  }
}
