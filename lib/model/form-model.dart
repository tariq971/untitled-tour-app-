import 'package:cloud_firestore/cloud_firestore.dart';

class FormEntity {
  final String? id;
  final String name;
  final String email;
  final String cnic;
  final String contactNo;
  final String city;

  FormEntity({
    this.id,
    required this.name,
    required this.email,
    required this.cnic,
    required this.contactNo,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'cnic': cnic,
      'contactNo': contactNo,
      'city': city,
    };
  }
}

class FormModel extends FormEntity {
  FormModel({
    String? id,
    required String name,
    required String email,
    required String cnic,
    required String contactNo,
    required String city,
  }) : super(
    id: id,
    name: name,
    email: email,
    cnic: cnic,
    contactNo: contactNo,
    city: city,
  );
  factory FormModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return FormModel(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      cnic: data['cnic'],
      contactNo: data['contactNo'],
      city: data['city'],
    );
  }
}