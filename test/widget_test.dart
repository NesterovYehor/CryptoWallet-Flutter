// import 'package:crypto_track/src/app.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   setUpAll(() async {
//     TestWidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(); // Make sure you have the Firebase configuration for testing
//   });

//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {

//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
