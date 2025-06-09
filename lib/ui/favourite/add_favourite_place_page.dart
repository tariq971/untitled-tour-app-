import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/favourite_place.dart';
// import '../../models/favourite_place.dart';
import 'favourite_place_controller.dart';

class AddFavouritePlacePage extends StatefulWidget {
  const AddFavouritePlacePage({Key? key}) : super(key: key);

  @override
  State<AddFavouritePlacePage> createState() => _AddFavouritePlacePageState();
}

class _AddFavouritePlacePageState extends State<AddFavouritePlacePage> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String imageUrl = "";
  String location = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavouritePlaceController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Favourite Place"),
        backgroundColor: const Color(0xff43cea2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Place Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Enter place name" : null,
                onSaved: (value) => name = value!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Image URL",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Enter image URL" : null,
                onSaved: (value) => imageUrl = value!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Enter location" : null,
                onSaved: (value) => location = value!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Enter description" : null,
                onSaved: (value) => description = value!.trim(),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await controller.addFavourite(FavouritePlace(
                      name: name,
                      imageUrl: imageUrl,
                      location: location,
                      description: description,
                    ));
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}