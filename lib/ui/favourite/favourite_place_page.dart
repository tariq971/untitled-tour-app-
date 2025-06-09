import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/favourite_place_repo.dart';
import 'favourite_place_controller.dart';
import 'add_favourite_place_page.dart';

class FavouritePlacesPage extends StatelessWidget {
  FavouritePlacesPage({Key? key}) : super(key: key);

  final FavouritePlaceController controller = Get.put(
    FavouritePlaceController(repository: FavouritePlaceRepository()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Places'),
        backgroundColor: const Color(0xff43cea2),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.favourites.isEmpty) {
          return const Center(
            child: Text(
              'No favourite places yet!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favourites.length,
          itemBuilder: (context, index) {
            final place = controller.favourites[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    place.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  place.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  place.location,
                  style: const TextStyle(
                    color: Colors.teal,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => controller.removeFavourite(place.id!),
                  tooltip: 'Remove from favourites',
                ),
                onTap: () {
                  // Optional: Show details dialog or page
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(place.name),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(place.imageUrl),
                          const SizedBox(height: 8),
                          Text(place.location, style: const TextStyle(color: Colors.teal)),
                          const SizedBox(height: 8),
                          Text(place.description),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.add_location_alt_rounded),
        label: const Text('Add Place'),
        onPressed: () {
          Get.to(() => const AddFavouritePlacePage())?.then((_) {
            controller.loadFavourites();
          });
        },
      ),
    );
  }
}