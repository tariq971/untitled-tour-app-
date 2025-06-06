import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:untitled/ui/product/view_models/form_vm.dart';
import '../../data/form_repo.dart';

class AddFormPage extends StatelessWidget {
  AddFormPage({super.key});
  final FormViewModel vm = Get.find<FormViewModel>();
  late FormRepository formRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vm.currentFormId.value.isEmpty ? 'Add Form' : 'Edit Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: vm.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: vm.nameController,

                decoration: const InputDecoration(labelText: 'Name',
                  hintText: "Enter Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: vm.emailController,
                decoration: const InputDecoration(labelText: 'Email',
                  hintText: "example@gmail.com",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType:TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: vm.cnicController,
                decoration: const InputDecoration(labelText: 'CNIC',
                  hintText: "11111-1111111-1",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType:TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: vm.contactNoController,
                decoration: const InputDecoration(labelText: 'Contact No',
                  hintText: "0333-3333333",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: vm.cityController,
                decoration: const InputDecoration(labelText: 'City',
                  hintText: "Enter City",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (vm.currentFormId.value.isEmpty) {
                    await vm.createForm();
                  } else {
                    await vm.updateForm();
                  }
                  Get.offAllNamed("/customer_home");
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.put( FormRepository());
    Get.put( FormViewModel(repository: Get.find()));

  }
}