// import 'package:flutter/material.dart';
// import 'package:todoapp/screen/HomeScreen.dart';

// class Buttonnavigationmenu extends StatefulWidget {
//   const Buttonnavigationmenu({super.key});

//   @override
//   State<Buttonnavigationmenu> createState() => _ButtonnavigationmenuState();
// }

// class _ButtonnavigationmenuState extends State<Buttonnavigationmenu> {
//   int currentIndex = 0;

//   final List<Widget> screens = [
//     Homescreen(),
//     Center(child: Text("Calculator Screen")),
//     Center(child: Homescreen()),
//     Center(child: Text("Leave Tracker")),
//     Center(child: Text("Profile Screen")),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: screens[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.white,
//         selectedFontSize: 12,
//         unselectedFontSize: 12,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         elevation: 10,
//         items: [
//           getNavItem(index: 0, label: "Home", icon: Icons.home),
//           getNavItem(index: 1, label: "Calculator", icon: Icons.calculate),
//           getNavItem(
//             index: 2,
//             label: "Add",
//             icon: Icons.add_circle,
//             isadd: true,
//           ),
//           getNavItem(index: 3, label: "Leave", icon: Icons.time_to_leave),
//           getNavItem(index: 4, label: "Profile", icon: Icons.person),
//         ],
//       ),
//     );
//   }

//   BottomNavigationBarItem getNavItem({
//     required int index,
//     required String label,
//     required IconData icon,
//     bool? isadd = false,
//   }) {
//     final isActive = currentIndex == index;

//     return BottomNavigationBarItem(
//       icon: Container(
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: isActive && isadd == false ? Colors.blue : Colors.transparent,
//           boxShadow:
//               isActive && isadd == false
//                   ? [
//                     BoxShadow(
//                       color: Colors.blue.shade200,
//                       blurRadius: 8,
//                       spreadRadius: 1,
//                     ),
//                   ]
//                   : [],
//         ),
//         child:
//             isadd != true
//                 ? Icon(
//                   icon,
//                   color: isActive ? Colors.white : Colors.grey,
//                   size: 24,
//                 )
//                 : Positioned(
//                   bottom: -220,
//                   left: 100,
//                   child: FloatingActionButton(
//                     onPressed: () {},
//                     child: Icon(Icons.add),
//                   ),
//                 ),
//       ),
//       label: label,
//     );
//   }
// }
