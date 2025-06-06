import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/form_repo.dart';
import '../../../model/form-model.dart';

class FormViewModel extends GetxController {
  final FormRepository _repository;
  final formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cnicController = TextEditingController();
  final contactNoController = TextEditingController();
  final cityController = TextEditingController();

  // State variables
  var isLoading = false.obs;
  var error = ''.obs;
  var forms = <FormModel>[].obs;
  var currentFormId = ''.obs;

  FormViewModel({required FormRepository repository}) : _repository = repository;

  @override
  void onInit() {
    super.onInit();
    fetchForms();
  }

  Future<void> createForm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading(true);
    try {
      final form = FormEntity(
        name: nameController.text,
        email: emailController.text,
        cnic: cnicController.text,
        contactNo: contactNoController.text,
        city: cityController.text,
      );
      await _repository.createForm(form);
      clearForm();
      await fetchForms();
    } catch (e) {
      error(e.toString());
      Get.snackbar('Error', 'Failed to create form');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchForms() async {
    isLoading(true);
    try {
      final result = await _repository.getAllForms();
      forms.assignAll(result);
    } catch (e) {
      error(e.toString());
      Get.snackbar('Error', 'Failed to fetch forms');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateForm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading(true);
    try {
      final form = FormEntity(
        id: currentFormId.value,
        name: nameController.text,
        email: emailController.text,
        cnic: cnicController.text,
        contactNo: contactNoController.text,
        city: cityController.text,
      );
      await _repository.updateForm(form);
      clearForm();
      await fetchForms();
    } catch (e) {
      error(e.toString());
      Get.snackbar('Error', 'Failed to update form');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteForm(String id) async {
    isLoading(true);
    try {
      await _repository.deleteForm(id);
      if (currentFormId.value == id) {
        clearForm();
      }
      await fetchForms();
      Get.snackbar('Success', 'Form deleted successfully');
    } catch (e) {
      error(e.toString());
      Get.snackbar('Error', 'Failed to delete form');
    } finally {
      isLoading(false);
    }
  }

  void loadFormForEditing(FormModel form) {
    currentFormId.value = form.id!;
    nameController.text = form.name;
    emailController.text = form.email;
    cnicController.text = form.cnic;
    contactNoController.text = form.contactNo;
    cityController.text = form.city;
    Get.toNamed('/AddFormPage');
  }

  void clearForm() {
    currentFormId.value = '';
    nameController.clear();
    emailController.clear();
    cnicController.clear();
    contactNoController.clear();
    cityController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    cnicController.dispose();
    contactNoController.dispose();
    cityController.dispose();
    super.onClose();
  }
}