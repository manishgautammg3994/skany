import 'package:flutter/material.dart';

class DynamicUPI extends StatefulWidget {
    final ValueChanged<String?>? onChanged;
  const DynamicUPI({Key? key, this.onChanged}) : super(key: key);

  @override
  State<DynamicUPI> createState() => _DynamicUPIState();
}

class _DynamicUPIState extends State<DynamicUPI> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}