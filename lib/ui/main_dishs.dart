import 'package:flutter/material.dart';
import 'package:mvp_flutter/models/main_dish.dart';
import 'package:mvp_flutter/ui/dish_details.dart';
import 'package:mvp_flutter/ui/main_dish.dart' as ui;

class MainDishs extends StatefulWidget {
  const MainDishs({Key? key}) : super(key: key);

  @override
  State<MainDishs> createState() => _MainDishsState();
}

class _MainDishsState extends State<MainDishs> {
  final List<MainDish> _listOfMainDishes = [
    MainDish(
        image: 'assets/row_element_1.jpg',
        title: 'Salmon with couscous',
        time: '50 min'),
    MainDish(
        image: 'assets/row_element_2.jpg',
        title: 'Ramen with Shrimps',
        time: '20 min')
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('What do you want to cook today?',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900
              ),
            ),
            const SizedBox(height: 9),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide.none
                ),
                labelText: 'Recipe',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.redAccent,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              height: 500,
              child: ListView.separated(
                itemCount: _listOfMainDishes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DishDetails(
                            title: _listOfMainDishes[index].title,
                            image: _listOfMainDishes[index].image,
                            time: _listOfMainDishes[index].time,
                          )
                      )
                      );
                    },
                    child: SizedBox(
                      width: 300,
                      child: ui.MainDish(
                          image: _listOfMainDishes[index].image,
                          title: _listOfMainDishes[index].title,
                          time: _listOfMainDishes[index].time
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 20);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
