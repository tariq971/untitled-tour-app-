import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/favourite_place.dart';

class FavouritePlaceRepository {
  final _collection = FirebaseFirestore.instance.collection('favourite_places');

  Future<List<FavouritePlace>> getFavourites() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => FavouritePlace.fromFirestore(doc)).toList();
  }

  Future<void> addFavourite(FavouritePlace place) async {
    await _collection.add(place.toMap());
  }

  Future<void> removeFavourite(String id) async {
    await _collection.doc(id).delete();
  }
}