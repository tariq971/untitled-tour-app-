class Shop {
  String id;
  String shopName;
  String? shopLogo;
  String category;

  Shop(this.id, this.shopName, this.category);

  static Shop fromMap(Map<String, dynamic> map) {
    Shop p = Shop(map["id"], map["shopName"], map["category"]);
    p.shopLogo = map["shopLogo"];
    return p;
  }

  Map<String, dynamic> toMap() {
    return {
      "uId": id,
      "shopName": shopName,
      "shopLogo": shopLogo,
      "category": category,
    };
  }
}
