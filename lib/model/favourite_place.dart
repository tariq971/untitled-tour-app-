import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritePlace {
  final String? id;
  final String name;
  final String imageUrl;
  final String location;
  final String description;

  FavouritePlace({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'description': description,
    };
  }

  factory FavouritePlace.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavouritePlace(
      id: doc.id,
      name: data['name'] ?? "",
      imageUrl: data['imageUrl'] ?? "",
      location: data['location'] ?? "",
      description: data['description'] ?? "",
    );
  }
}