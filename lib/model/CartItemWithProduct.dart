import 'CartItem.dart';
import 'Fav.dart';

class CartItemWithProduct {
  CartItem cartItem;
  Product product;
  CartItemWithProduct(this.cartItem, this.product);

  double getTotal(){
    return product.rent*cartItem.quantity;
  }
}