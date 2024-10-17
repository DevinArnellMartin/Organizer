import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'models.dart'; 

class CardScreen extends StatefulWidget {
  final int folderId;
  const CardScreen({required this.folderId});

  @override
  CardScrnState createState() => CardScrnState();
}

class CardScrnState extends State<CardScreen> {
  List<Map<String, dynamic>> _cards = [];
  late Database _db;

  @override
  void initState() {
    super.initState();
    initDB();
   fetch();
  }

  Future<void> initDB() async {
    
    _db = await openDatabase('card_organizer.db');
  }

  Future<void>fetch() async { 
    final List<Map<String, dynamic>> cards = await _db.query(
      'Cards',
      where: 'folder_id = ?',
      whereArgs: [widget.folderId],
    );
    setState(() {
      _cards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return GridTile(
            child: Column(
              children: [
                Image.network(card['imgUrl']), 
                Text(card['name']), 
              ],
            ),
          );
        },
      ),
    );
  }
}
