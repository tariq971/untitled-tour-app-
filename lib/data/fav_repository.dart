import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Fav.dart';

class ProductsRepository {
  late CollectionReference productsCollection;
// late MediaRepository mediaRepository;
  ProductsRepository() {
    productsCollection = FirebaseFirestore.instance.collection("products");
  }
  Future<void> updateProduct(Product product) {
    var doc = productsCollection.doc(product.id);
    return doc.set(product.toMap());
  }

  Future<void> deleteProduct(Product product) {
    var doc = productsCollection.doc(product.id);
    return doc.delete();
  }

  Future<void> addProduct(Product product) {
    var doc = productsCollection.doc();
    product.id = doc.id;
    return doc.set(product.toMap());
  }

  Stream<List<Product>> loadAllProducts() {
    return productsCollection.snapshots().map((snapshot) {
      return convertToProducts(snapshot);
    });
  }

  Stream<List<Product>> loadProductsOfShop(String uId) {
    return productsCollection.where("uId", isEqualTo: uId).snapshots().map((
      snapshot,
    ) {
      return convertToProducts(snapshot);
    });
  }

  Future<List<Product>> loadAllProductsOnce() async {
    var snapshot = await productsCollection.get();
    return convertToProducts(snapshot);
  }

  List<Product> convertToProducts(QuerySnapshot snapshot) {
    List<Product> products = [];
    for (var snap in snapshot.docs) {
      try
    {
    products.add(Product.fromMap(snap.data() as Map<String, dynamic>));
  }
      catch (e){
  print('Error converting product:, data: ${snap.data()},data: ${snap.id},error: $e');
  }
    }
    return products;
  }


}
