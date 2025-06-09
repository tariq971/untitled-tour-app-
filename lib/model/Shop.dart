

class Shop {
  String id;
  String shopName;
  String? shopLogo;
  String category;

  Shop(this.id, this.shopName, this.category, {this.shopLogo});

  static Shop fromMap(Map<String, dynamic> map) {
    return Shop(
      map["id"]?.toString() ?? '',                          // handle null and ensure String
      map["shopName"]?.toString() ?? '',
      map["category"]?.toString() ?? '',
      shopLogo: map["shopLogo"]?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,                 // keep it 'id' for consistency
      "shopName": shopName,
      "shopLogo": shopLogo,
      "category": category,
    };
  }
}