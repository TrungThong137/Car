
import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({required this.iconPath, required this.onTap, Key? key})
      : super(key: key);

  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 214, 212, 212),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TextButton(
          onPressed: onTap,
          child: Image.asset(
            iconPath,
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
