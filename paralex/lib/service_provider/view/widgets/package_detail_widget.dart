import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PackageDetailWidget extends StatelessWidget {
  const PackageDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Packages 1:",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Detail: 20 X 16 X 10(Inch), 32lbs",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Type: Electronic devices",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Image:",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        DottedBorder(
          color: Colors.grey, // Color of the dots
          strokeWidth: 2,      // Thickness of the dots
          borderType: BorderType.RRect,
          radius: Radius.circular(12), // Rounded corners (optional)
          dashPattern: [6, 4], // Length of dots and spacing
          child: SizedBox(
            width: 87,
            height: 85,
            child: Image.asset("assets/images/package_in_carton.png"),
          ),
        ),
      ],
    );
  }
}