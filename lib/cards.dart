import 'package:flutter/material.dart';
import 'help.dart';
import 'models.dart';

class CardsScreen extends StatelessWidget {
  final int folderId;
  const CardsScreen({required this.folderId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      body: FutureBuilder<List<CardModel>>(
        future: DatabaseHelper.instance.getCardsForFolder(folderId), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Err:Card Load Failed'));
          } else {
            final cards = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(card.imageUrl), 
                      Text(card.name),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
