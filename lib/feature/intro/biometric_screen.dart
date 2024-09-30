// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../config/theme/my_theme.dart';
//
// class BiometricScreen extends StatefulWidget {
//   static String routeName = 'biometric-screen';
//
//   const BiometricScreen({super.key});
//
//   @override
//   State<BiometricScreen> createState() => _BiometricScreenState();
// }
//
// class _BiometricScreenState extends State<BiometricScreen> {
//   bool isSwitched = false;
//
//   void toggleSwitch(bool value) {
//     if (isSwitched == false) {
//       setState(() {
//         isSwitched = true;
//       });
//       // Call your function here when the switch is turned on
//       onSwitchTurnedOn();
//     } else {
//       setState(() {
//         isSwitched = false;
//       });
//     }
//   }
//
//   void onSwitchTurnedOn() {
//     // Your function code here
//     print("Switch is turned ON");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(
//                 height: 100,
//               ),
//               Text(
//                 'Enable biometrics for more security and easy access',
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Turn on biometric authentication to use your fingerprint or face to unlock Sova Vault.",
//                 style: Theme.of(context).textTheme.displayLarge,
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Stack(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         'Biometric Authentication',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                       Text(
//                         'Turn on',
//                         style: Theme.of(context).textTheme.labelSmall,
//                       ),
//                     ],
//                   ),
//                   Positioned(
//                     right: 0,
//                     child: CupertinoSwitch(
//                       value: isSwitched,
//                       onChanged: toggleSwitch,
//                       trackColor: MyTheme.secondaryColor,
//                       activeColor: Colors.blue,
//                     ),
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 425, bottom: 30),
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     height: 48,
//                     width: 358,
//                     decoration: BoxDecoration(
//                         color: MyTheme.secondaryColor,
//                         borderRadius: BorderRadius.circular(8)),
//                     child: Center(
//                       child: Text(
//                         'Continue',
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
