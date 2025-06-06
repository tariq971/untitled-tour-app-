import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Shop.dart';

class ShopRepository {
  late CollectionReference shopCollection;

  ShopRepository() {
    shopCollection = FirebaseFirestore.instance.collection("Shop");
  }
  Future<void> updateShop(Shop shop) {
    var doc = shopCollection.doc(shop.id);
    return doc.set(shop.toMap());
  }

  Future<void> deleteShop(Shop shop) {
    var doc = shopCollection.doc(shop.id);
    return doc.delete();
  }

  Future<void> addShop(Shop shop) {

    return shopCollection.doc(shop.id).set(shop.toMap());
  }

  Stream<List<Shop>> loadAllShop() {
    return shopCollection.snapshots().map((snapshot) {
      return convertToShops(snapshot);
    });
  }

  Future<List<Shop>> loadAllShopOnce() async {
    var snapshot = await shopCollection.get();
    return convertToShops(snapshot);
  }

  List<Shop> convertToShops(QuerySnapshot snapshot) {
    List<Shop> shop = [];
    for (var snap in snapshot.docs) {
      shop.add(Shop.fromMap(snap.data() as Map<String, dynamic>));
    }
    return shop;
  }
}
