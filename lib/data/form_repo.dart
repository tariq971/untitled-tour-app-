import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/form-model.dart';

class FormRepository {
  final FirebaseFirestore _firestore;

  FormRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<FormModel> createForm(FormEntity form) async {
    final docRef = await _firestore.collection('forms').add(form.toMap());
    return FormModel(
      id: docRef.id,
      name: form.name,
      email: form.email,
      cnic: form.cnic,
      contactNo: form.contactNo,
      city: form.city,
    );
  }

  Future<List<FormModel>> getAllForms() async {
    final snapshot = await _firestore.collection('forms').get();
    return snapshot.docs.map((doc) => FormModel.fromSnapshot(doc)).toList();
  }

  Future<void> updateForm(FormEntity form) async {
    await _firestore.collection('forms').doc(form.id).update(form.toMap());
  }

  Future<void> deleteForm(String id) async {
    await _firestore.collection('forms').doc(id).delete();
  }
}