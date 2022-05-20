import 'package:flutter/material.dart';

class Nav3 extends StatefulWidget {
  const Nav3({Key? key}) : super(key: key);

  @override
  State<Nav3> createState() => _Nav3State();
}

class _Nav3State extends State<Nav3> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('bottom navigation 3'),
    );
  }
}
