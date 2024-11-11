import 'package:flutter/material.dart';
import 'package:paralax/reusables/paints.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: PaintColors.fadedPinkBg),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(''),
              const Column(
                children: [
                  Text("Joshua Idowu vs LAGCL"),
                  Text("SEPTEMBER 16 .8:00"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
