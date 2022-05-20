import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {

  String image = 'assets/cooking1.PNG';
  String title = 'lady';
  String description = 'cocking';

  OnBoarding({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(title,
              style: const TextStyle(
                color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Rouge Script'),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(description,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Rouge Script'),
            ),
          ),
          const SizedBox(height: 25),
          Image(
            image: AssetImage(image),
            height: 400,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
