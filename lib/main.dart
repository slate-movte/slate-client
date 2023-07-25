import 'package:flutter/material.dart';

void main() {
  runApp(const Slate());
}

class Slate extends StatefulWidget {
  const Slate({super.key});

  @override
  State<Slate> createState() => _SlateState();
}

class _SlateState extends State<Slate> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
