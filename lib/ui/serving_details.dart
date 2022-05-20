import 'package:flutter/material.dart';
import 'package:mvp_flutter/models/dish_details.dart' as model;

class DishDetails extends StatefulWidget {
  late model.ServingDetails servingDetails;
  late int index;

  DishDetails({Key? key, required this.servingDetails, required this.index}) : super(key: key);

  @override
  State<DishDetails> createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                widget.servingDetails.image!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Text(widget.servingDetails.name!)
          ],
        ),
        const SizedBox(width: 20),
        Text(widget.servingDetails.kCal! + ' Cal'),
      ],
    );
  }
}
