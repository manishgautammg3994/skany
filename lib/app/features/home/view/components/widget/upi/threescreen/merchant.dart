import 'package:flutter/material.dart';

class Merchants extends StatefulWidget {
    final ValueChanged<String?>? onChanged;
  const Merchants({Key? key, this.onChanged}) : super(key: key);

  @override
  State<Merchants> createState() => _MerchantsState();
}

class _MerchantsState extends State<Merchants> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}