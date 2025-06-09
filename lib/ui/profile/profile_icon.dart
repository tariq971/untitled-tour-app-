import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/ui/profile/user_controller.dart';

class ProfileIcon extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double radius;
  final VoidCallback? onTap;

  const ProfileIcon({
    Key? key,
    this.imageUrl,
    this.initials,
    this.radius = 28,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatar = CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: Colors.grey[200],
      );
    } else {
      avatar = CircleAvatar(
        radius: radius,
        backgroundColor: Colors.teal[200],
        child: Text(
          initials ?? "?",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: radius * 0.9,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: avatar,
    );
  }

}
