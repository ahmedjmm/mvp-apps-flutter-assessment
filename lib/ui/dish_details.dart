import 'package:flutter/material.dart';
import 'package:mvp_flutter/ui/serving_details.dart' as ui;
import 'package:mvp_flutter/models/dish_details.dart' as model;
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DishDetails extends StatefulWidget {
  late String image;
  late String title;
  late String time;

  DishDetails(
      {Key? key, required this.image, required this.title, required this.time})
      : super(key: key);

  @override
  State<DishDetails> createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {
  /* API returned values don't have images so we add image to each item
     as required in the assessment*/
  List images = [
    'assets/noodles.png',
    'assets/egg.png',
    'assets/soup.png',
    'assets/food1.png',
    'assets/food2.png'
  ];
  int servingQuantity = 1;
  bool isLoading = true;

  late Future<List<model.ServingDetails>> _list;

  @override
  void initState() {
    _list = Provider.of<model.ServingDetails>(context, listen: false)
        .getServingDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.bookmark_border,
                  size: 26.0,
                ),
              ))
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.image), fit: BoxFit.cover)),
        child: SlidingUpPanel(
          maxHeight: 700,
          minHeight: 50,
          borderRadius: radius,
          panel: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: const [
                        Icon(
                          Icons.favorite_border,
                          color: Colors.pink,
                          size: 24.0,
                        ),
                        Text('easy'),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: Colors.pink,
                          size: 24.0,
                        ),
                        Text(widget.time)
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(
                          Icons.star_border,
                          color: Colors.pink,
                          size: 24.0,
                        ),
                        Text('4.8')
                      ],
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.pink,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Classic Japanese',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Ingredients',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('How many servings?')
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(26)),
                          color: Colors.grey[200]),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (servingQuantity > 1) {
                                  servingQuantity--;
                                }
                              });
                            },
                          ),
                          Text('$servingQuantity'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                servingQuantity++;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 100,
                  child: Consumer<model.ServingDetails>(
                    builder: (context, value, child) => FutureBuilder(
                      future: _list,
                      builder: (BuildContext context, AsyncSnapshot<List<model.ServingDetails>> snapshot) {
                        if (snapshot.hasData){
                          return ListView.separated(
                              separatorBuilder: (context, index) => const Divider(
                                color: Colors.transparent,
                              ),
                              itemCount: value.recipeList.length,
                              itemBuilder: (context, index) {
                                model.ServingDetails servingDetails = model.ServingDetails(
                                    name:value.recipeList[index].name!,
                                    image: images[index],
                                    kCal: value.recipeList[index].kCal!);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ui.DishDetails(
                                        servingDetails: servingDetails,
                                        index: index,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Provider.of<model.ServingDetails>(context,
                                                listen: false)
                                                .removeItem(index);
                                          },
                                          child: const Text('Remove'))
                                    ],
                                  ),
                                );
                              });
                        }
                        else {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          collapsed: Container(
            decoration:
            BoxDecoration(color: Colors.white, borderRadius: radius),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
