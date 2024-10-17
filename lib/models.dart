class Folder {
  int? id;
  String name;
  DateTime timestamp;

  Folder({this.id, required this.name, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static Folder fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'],
      name: map['name'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class CardModel {
  int? id;
  String name;
  String suit;
  String imageUrl;
  int folderId; 

  CardModel({this.id, required this.name, required this.suit, required this.imageUrl, required this.folderId});

 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'suit': suit,
      'img_url': imageUrl,
      'folderID': folderId,
    };
  }

  static CardModel fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      name: map['name'],
      suit: map['suit'],
      imageUrl: map['img_url'],
      folderId: map['folderID'],
    );
  }
}
