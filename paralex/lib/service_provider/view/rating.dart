import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paralex/service_provider/view/widgets/custom_button.dart';
import 'package:paralex/service_provider/view/widgets/custom_text_field.dart';
import '../../reusables/fonts.dart';
import '../../reusables/paints.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFCFE),
      appBar: AppBar(
        backgroundColor: PaintColors.white,
        centerTitle: true,
        title: Text(
          "Ratings",
          style: FontStyles.smallCapsIntro.copyWith(
              fontSize: 16,
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000)),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: PaintColors.paralexpurple),
                child: SvgPicture.asset(
                  "assets/images/blue_blank_human_image.svg",
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "How is your trip?",
                style: FontStyles.smallCapsIntro.copyWith(
                    fontSize: 20, letterSpacing: 0, color: Color(0xFF242E42)),
              ),
              SizedBox(height: 20),
              Text(
                "Your feedback will help improve\nservice experience",
                textAlign: TextAlign.center,
                style: FontStyles.smallCapsIntro.copyWith(
                    fontSize: 14, letterSpacing: 0, color: Color(0xFF8A8A8F)),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Icon(
                      index < _rating ? Icons.star : Icons.star,
                      color: index < _rating ? Color(0xFFFFAA00) : Color(0xFFE4E9F2),
                      size: 40.0,
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              CustomTextField(
                hintText: "Additional comments",
                maxline: 6,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CustomButton(
                desiredWidth: 0.9,
                buttonText: "Submit",
                buttonColor: PaintColors.paralexpurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
