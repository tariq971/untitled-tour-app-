import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String uId;
  String placeName;
  String? image;
  double rent;
  int days;
  DateTime startDate;
  DateTime endDate;

  Product(
      this.id,
      this.uId,
      this.placeName,
      this.rent,
      this.days,
      this.startDate,
      this.endDate,
      );

  static Product fromMap(Map<String, dynamic> map) {
    // Handle rent as double
    double rentValue = 0.0;
    if (map["rent"] is int) {
      rentValue = (map["rent"] as int).toDouble();
    } else if (map["rent"] is double) {
      rentValue = map["rent"] ?? 0.0;
    } else if (map["rent"] != null) {
      rentValue = double.tryParse(map["rent"].toString()) ?? 0.0;
    }

    // Handle days as int
    int daysValue = 0;
    if (map["days"] is int) {
      daysValue = map["days"];
    } else if (map["days"] is double) {
      daysValue = (map["days"] as double).toInt();
    } else if (map["days"] != null) {
      daysValue = int.tryParse(map["days"].toString()) ?? 0;
    }

    // Date parsing robust for web + mobile
    DateTime parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
      if (value is DateTime) return value;
      return DateTime.now();
    }

    return Product(
      map["id"] ?? "",
      map["uId"] ?? "",
      map["placeName"] ?? "",
      rentValue,
      daysValue,
      parseDate(map["startDate"]),
      parseDate(map["endDate"]),
    )..image = map["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uId": uId,
      "placeName": placeName,
      "image": image,
      "rent": rent,
      "days": days,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate.toIso8601String(),
    };
  }
}