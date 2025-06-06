
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product{
  String id;
  String uId;
  // temp variable
  String? shopName;
  String placeName;
  String? image;
  double rent;

  int days;
  DateTime startDate;
  DateTime endDate;


  Product(this.id, this.uId,this.placeName,this.rent,this.days,this.startDate,this.endDate);

   static Product fromMap(Map<String,dynamic>map){

    Product p=Product(map["id"],map["uId"],map["placeName"],map['days']
      ,(map["rent"] is int) ? (map["rent"] as int).toDouble() : (map["rent"] ?? 0.0),
        (map['startDate'] as Timestamp).toDate(),(map['endDate']as Timestamp).toDate());
    p.image=map["image"];
    return p;
  }
  Map<String,dynamic> toMap(){
    return{
      "id":id,
      "uId":uId,
      "placeName":placeName,
      "image":image,
      "rent":rent,
      "days":days,
      "startDate":startDate,
      "endDate":endDate,
    };
  }

}