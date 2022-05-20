import 'package:flutter/material.dart';

class Nav4 extends StatefulWidget {
  const Nav4({Key? key}) : super(key: key);

  @override
  State<Nav4> createState() => _Nav4State();
}

class _Nav4State extends State<Nav4> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('bottom navigation 4'),
    );
  }
}
