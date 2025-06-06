import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/Order.dart' as MyOrder;

class OrderRepository {
  late CollectionReference orderCollection;

  OrderRepository() {
    orderCollection = FirebaseFirestore.instance.collection('order');
  }

  Future<void> updateOrder(MyOrder.Order order) {
    return orderCollection.doc(order.id).set(order.toMap());
  }

  Future<void> deleteOrder(MyOrder.Order order) {
    return orderCollection.doc(order.id).delete();
  }

  Future<void> addOrder(MyOrder.Order order) {
    var doc = orderCollection.doc();
    order.id=doc.id;
    return doc.set(order.toMap());
  }

  Stream<List<MyOrder.Order>> loadOrderOfUser(String userId) {
    return orderCollection.where('customerId',isEqualTo: userId).snapshots().map(
      (snapshot) {
        return convertToOrder(snapshot);
      },
    );
  }

  Stream<List<MyOrder.Order>> loadOrderOfShop(String userId) {
    return orderCollection.where('uId',isEqualTo: userId).snapshots().map(
      (snapshot) {
        return convertToOrder(snapshot);
      },
    );
  }


  // AggregateQuery loadOrderCount(String userId){
  //   return orderCollection.where('customerId',isEqualTo: userId).count();
  // }

  List<MyOrder.Order> convertToOrder(QuerySnapshot snapshot){
    List<MyOrder.Order> order=[];
    for (var snap in snapshot.docs) {
      order.add(MyOrder.Order.fromMap(snap.data() as Map<String, dynamic>));
    }
    return order;
  }
}
