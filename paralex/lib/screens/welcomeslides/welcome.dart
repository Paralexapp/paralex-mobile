import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:paralax/reusables/fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:paralax/routes/navs.dart';

class WelcomeSliders extends StatefulWidget {
  const WelcomeSliders({super.key});

  @override
  State<WelcomeSliders> createState() => _WelcomeSlidersState();
}

class _WelcomeSlidersState extends State<WelcomeSliders> {
  static final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  final List<Widget> showSliders = [
    const Slide(
      sub: "Leveraging on wealth of experience",
      image: "assets/images/rider.jpeg",
      title: "Expertise and \n experience",
      // color: Colors.black12,
      text: "",
    ),
    const SlideB(
      sub: "Strategies specific to your nich",
      image: "assets/images/manwithsmile.jpeg",
      title: "Personalized\n approach",
      // color: Colors.black12,
      text: "",
    ),
    const SlideC(
      sub: "Service you can always count on",
      image: "assets/images/rideb.jpeg",
      title: "Responsive \n and Reliable",
      // color: Colors.black12,
      text: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
        type: MaterialType.transparency,
        child: Container(
          child: Stack(
            children: [
              Positioned(
                  child: PageView(
                controller: _pageController,
                children: showSliders,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
              )),
              Positioned(
                  top: size.height * 0.75,
                  left: 20,
                  child: SmoothPageIndicator(
                    effect: const JumpingDotEffect(
                        dotColor: Colors.white,
                        dotHeight: 20,
                        dotWidth: 20,
                        activeDotColor: Colors.white,
                        verticalOffset: 1),
                    controller: _pageController,
                    count: 3,
                  )),
              _currentPage < 3
                  ? Container(
                      child: Positioned(
                        top: size.height * 0.80,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: size.width * 0.9,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: InkWell(
                            onTap: () => Get.toNamed(Nav.lastWelcomeScreen),
                            child: Center(
                                child: Text(
                              "GET  STARTED",
                              style: FontStyles.smallCapsIntro.copyWith(
                                  color: Colors.black,
                                  letterSpacing: 0,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Positioned(
                  top: size.height * 0.94,
                  left: size.width * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: FontStyles.smallCapsIntro
                            .copyWith(letterSpacing: 0, fontSize: 14),
                      ),
                      InkWell(
                        onTap: () => Get.toNamed(Nav.login),
                        child: Text(
                          "Sign in",
                          style: FontStyles.smallCapsIntro.copyWith(
                              letterSpacing: 0,
                              fontWeight: FontWeight.w900,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}

class Slide extends StatelessWidget {
  final String text, title, sub, image;

  const Slide(
      {super.key,
      required this.title,
      required this.text,
      required this.image,
      required this.sub});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        Container(
          decoration: BoxDecoration(
              // color: Colors.red,
              gradient: LinearGradient(
            begin: FractionalOffset.center,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.0),
              Colors.black,
            ],
          )),
        ),
        Positioned(
            top: size.height * 0.60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontStyles.headingText.copyWith(
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    sub,
                    style: FontStyles.smallCapsIntro.copyWith(
                        fontSize: 19,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class SlideB extends StatelessWidget {
  final String text, title, sub, image;

  const SlideB(
      {super.key,
      required this.title,
      required this.text,
      required this.image,
      required this.sub});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        Container(
          decoration: BoxDecoration(
              // color: Colors.red,
              gradient: LinearGradient(
            begin: FractionalOffset.center,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.0),
              Colors.black,
            ],
          )),
        ),
        Positioned(
            top: size.height * 0.60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontStyles.headingText.copyWith(
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    sub,
                    style: FontStyles.smallCapsIntro.copyWith(
                        fontSize: 19,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class SlideC extends StatelessWidget {
  final String text, title, sub, image;

  const SlideC(
      {super.key,
      required this.title,
      required this.text,
      required this.image,
      required this.sub});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        Container(
          decoration: BoxDecoration(
              // color: Colors.red,
              gradient: LinearGradient(
            begin: FractionalOffset.center,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.0),
              Colors.black,
            ],
          )),
        ),
        Positioned(
            top: size.height * 0.60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FontStyles.headingText.copyWith(
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    sub,
                    style: FontStyles.smallCapsIntro.copyWith(
                        fontSize: 19,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
