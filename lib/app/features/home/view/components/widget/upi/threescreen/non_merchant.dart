import 'package:flutter/material.dart';

class NonMerchants extends StatefulWidget {
   final ValueChanged<String?>? onChanged;
  const NonMerchants({Key? key, this.onChanged}) : super(key: key);

  @override
  State<NonMerchants> createState() => _NonMerchantsState();
}

class _NonMerchantsState extends State<NonMerchants> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

