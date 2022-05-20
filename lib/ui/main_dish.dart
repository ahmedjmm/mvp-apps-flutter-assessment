import 'package:flutter/material.dart';

class MainDish extends StatelessWidget {
  late String image;
  late String title;
  late String time;

  MainDish({Key? key, required this.image, required this.title, required this.time}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(time),
                  const SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        )
    );
  }
}
