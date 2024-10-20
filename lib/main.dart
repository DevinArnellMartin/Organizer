import 'package:flutter/material.dart';
import 'folder.dart'; 
import 'cards.dart';
import 'help.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Organizer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FolderScrn(), // Corrected this line
    ); 
  }
}
