import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/CartItem.dart';

class CartItemRepository {
  late CollectionReference cartItemCollection;

  CartItemRepository() {
    cartItemCollection = FirebaseFirestore.instance.collection('cartItem');
  }

  Future<void> updateCartItem(CartItem cartItem) {
    return cartItemCollection.doc(cartItem.getId()).set(cartItem.toMap());
  }

  Future<void> deleteCartItem(CartItem cartItem) {
    return cartItemCollection.doc(cartItem.getId()).delete();
  }
  Future<void> clearCart(String userId) async {
    var items= await loadAllProductsOnce(userId);
    var batch = FirebaseFirestore.instance.batch();
    for(var item in items){
      batch.delete(cartItemCollection.doc(item.getId()));
    }
    await batch.commit();
  }

  Future<void> addCartItem(CartItem cartItem) {
    return cartItemCollection.doc(cartItem.getId()).set(cartItem.toMap());
  }

  Stream<List<CartItem>> loadCartItemOfUser(String userId) {
    return cartItemCollection.where('userId',isEqualTo: userId).snapshots().map(
      (snapshot) {
        return convertToCartItem(snapshot);
      },
    );
  }
  Future<List<CartItem>>loadAllProductsOnce(String userId) async {
    var snapshot= await cartItemCollection.where("userId",isEqualTo: userId).get();
    return convertToCartItem(snapshot);
  }


  // AggregateQuery loadCartItemCount(String userId){
  //   return cartItemCollection.where('userId',isEqualTo: userId).count();
  // }

  List<CartItem> convertToCartItem(QuerySnapshot snapshot){
    List<CartItem> cartItem=[];
    for (var snap in snapshot.docs) {
      cartItem.add(CartItem.fromMap(snap.data() as Map<String, dynamic>));
    }
    return cartItem;
  }
}
