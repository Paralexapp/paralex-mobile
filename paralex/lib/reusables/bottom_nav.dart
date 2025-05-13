// import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:paralex/reusables/paints.dart';
//
// class CustomBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       color: PaintColors.white,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _bottomNav(context, icon: Iconsax.home_2, index: 0, label: "Home"),
//             _bottomNav(context,
//                 icon: Iconsax.archive_book, index: 1, label: "News"),
//             _bottomNav(context,
//                 icon: Iconsax.user_square, index: 2, label: "Search"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _bottomNav(BuildContext context,
//       {required IconData icon, required int index, required String label}) {
//     return GestureDetector(
//       onTap: () => onTap(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 30,
//             color: currentIndex == index
//                 ? PaintColors.paralexpurple
//                 : Colors.grey,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: currentIndex == index
//                   ? PaintColors.paralexpurple
//                   : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:paralex/reusables/paints.dart';
//
// class CustomBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       color: PaintColors.white,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _bottomNav(context, icon: Iconsax.home_2, index: 0, label: "Home"),
//             _bottomNav(context, icon: Iconsax.archive_book, index: 1, label: "News"),
//             _bottomNav(context, icon: Iconsax.user_square, index: 2, label: "Search"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _bottomNav(BuildContext context, {required IconData icon, required int index, required String label}) {
//     return GestureDetector(
//       onTap: () => onTap(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icon,
//             size: 30,
//             color: currentIndex == index ? PaintColors.paralexpurple : Colors.grey,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: currentIndex == index ? PaintColors.paralexpurple : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Text('Home Page')));
//   }
// }
//
// class NewsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Text('News Page')));
//   }
// }
//
// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Text('Search Page')));
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int _currentIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => HomePage()),
//         );
//         break;
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => NewsPage()),
//         );
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => SearchPage()),
//         );
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: IndexedStack(
//           index: _currentIndex,
//           children: [
//             HomePage(),
//             NewsPage(),
//             SearchPage(),
//           ],
//         ),
//         bottomNavigationBar: CustomBottomNavBar(
//           currentIndex: _currentIndex,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/paints.dart';
// LawyerDashboard
import 'package:paralex/news/news_screen.dart'; // NewsScreen
import 'package:paralex/service_provider/view/search_tab.dart';

import '../paralegal/lawyer_dashboard.dart'; // SearchTab

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: PaintColors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomNav(context, icon: Iconsax.home_2, index: 0, label: "Home"),
            _bottomNav(context, icon: Iconsax.archive_book, index: 1, label: "News"),
            _bottomNav(context, icon: Iconsax.user_square, index: 2, label: "Search"),
          ],
        ),
      ),
    );
  }

  Widget _bottomNav(BuildContext context, {required IconData icon, required int index, required String label}) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: currentIndex == index ? PaintColors.paralexpurple : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: currentIndex == index ? PaintColors.paralexpurple : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LawyerDashboard()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchTab()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            LawyerDashboard(),
            NewsScreen(),
            SearchTab(),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
