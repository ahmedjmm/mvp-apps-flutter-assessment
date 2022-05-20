import 'package:flutter/material.dart';
import 'package:mvp_flutter/models/dish_details.dart';
import 'package:mvp_flutter/ui/dishes.dart';
import 'package:mvp_flutter/ui/on_board.dart' as on_boarding;
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)  => ServingDetails(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<on_boarding.OnBoarding> slides = [
    on_boarding.OnBoarding(title: 'title 1', image: 'assets/cooking1.PNG', description: 'description 1'),
    on_boarding.OnBoarding(title: 'title 2', image: 'assets/cooking2.PNG', description: 'description 2'),
    on_boarding.OnBoarding(title: 'title 3', image: 'assets/cooking3.PNG', description: 'description 3'),
  ];
  int viewPageCurrentIndex = 0;
  int paletteIndex = 0;
  PageController controller = PageController(initialPage: 0);
  late List<PaletteColor> colors;

  void updatePalettes() async {
    colors = [];
    for(on_boarding.OnBoarding slide in slides){
      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(AssetImage(slide.image));
      colors.add(paletteGenerator.dominantColor ?? PaletteColor(Colors.redAccent, 2));
    }
    setState(() {
    });
  }

  Container buildDot(int index, BuildContext context){
    return Container(
      height: 10,
      width: viewPageCurrentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    updatePalettes();
    controller = PageController(initialPage: viewPageCurrentIndex);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.isNotEmpty ? colors[paletteIndex].color :
        Colors.black,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(() {
                    viewPageCurrentIndex = value;
                    paletteIndex = value;
                  });
                },
                itemCount: slides.length,
                itemBuilder: (context, index){
                  return on_boarding.OnBoarding(
                    title: slides[index].title,
                    image: slides[index].image,
                    description: slides[index].description,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                    (index) => buildDot(index, context),
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: FloatingActionButton.extended(
                label: Text(viewPageCurrentIndex == slides.length-1 ? "Continue": "Next",
                  style: TextStyle(
                      color: colors.isNotEmpty ? colors[paletteIndex].color :
                      Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
                backgroundColor: Colors.white,
                onPressed: () {
                  if(viewPageCurrentIndex == slides.length - 1) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Dishes()),);
                  }
                  controller.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.bounceIn);
                },
              ),
            ),
          ],
        )
    );
  }
}
