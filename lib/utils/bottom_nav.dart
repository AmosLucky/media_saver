// import 'package:flutter/material.dart';

// class MyBottomNav extends StatefulWidget {
//   int currentIndex;
//   var controller;
//   MyBottomNav({Key? key, required this.currentIndex, required this.controller})
//       : super(key: key);

//   @override
//   State<MyBottomNav> createState() => _MyBottomNavState();
// }

// class _MyBottomNavState extends State<MyBottomNav> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: widget.currentIndex,
//       onTap: (_index) {
//         widget.currentIndex = _index;
//         //print(_index);
//         //widget.controller.jumpTo(_index.toDouble());
//         widget.controller.animateToPage(_index,
//             duration: Duration(seconds: 1), curve: Curves.easeOut);
//         setState(() {});
//         // switch (_index) {
//         //   case 0:
//         //     return;
//         //   case 1:
//         //     return;
//         //   case 2:
//         //     return;
//         // }
//       },
//       selectedItemColor: Colors.blueAccent,
//       showUnselectedLabels: true,
//       //backgroundColor: Colors.black,
//       unselectedItemColor: Colors.grey,
//       items: [
//         navItem(Icons.whatshot, "WhatsApp"),
//         navItem(Icons.video_library_sharp, "Youtube"),
//         navItem(Icons.insert_chart, "Instagram"),
//         navItem(Icons.file_download, "Downloads"),
//       ],
//     );
//   }

//   navItem(icon, text) {
//     return BottomNavigationBarItem(
//       icon: Icon(
//         icon,
//       ),
//       title: Text(
//         text,
//         style: TextStyle(fontFamily: "Roboto"),
//       ),
//     );
//   }
// }
