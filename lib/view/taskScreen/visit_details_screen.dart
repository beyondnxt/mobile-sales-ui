import 'package:flutter/material.dart';

class VisitDetailsScreen extends StatelessWidget {
  const VisitDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text("Customer Name")),
              SizedBox(width: 20,),
              Expanded(
                flex: 2,
                child: Text("Sushalt"))
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text("Description")),
              SizedBox(width: 20,),
              Expanded(
                flex: 2,
                child: Text("Something Something"))
          ],
        ),
        
      ],
    ),
    );
  }
}