import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/product/view_models/form_vm.dart';
import 'add_form.dart';
import '../../data/form_repo.dart';
import '../../model/form-model.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FormViewModel vm = Get.find<FormViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Entries'),
      ),
      body: Obx(() {
        if (vm.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (vm.forms.isEmpty) {
          return const Center(child: Text('No forms available'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: vm.forms.length,
          itemBuilder: (context, index) {
            final form = vm.forms[index];
            return _buildFormCard(form, vm);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        vm.clearForm();
        Get.toNamed('/favourite');
      },child: Icon(Icons.add)),
    );
  }
  Widget _buildFormCard(FormModel form, FormViewModel vm) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(form.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${form.email}'),
            Text('Contact: ${form.contactNo}'),
            Text('City: ${form.city}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => vm.loadFormForEditing(form),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => vm.deleteForm(form.id!),
            ),
          ],
        ),
      ),
    );
  }
}

class FormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FormRepository());
    Get.lazyPut(() => FormViewModel(repository: Get.find()));
  }
}