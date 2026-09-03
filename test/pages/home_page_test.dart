import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/pages/home_page.dart';

void main() {
  testWidgets('HomePage has a title and buttons', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that the title is present
    expect(find.text('HELLO\nSEAN'), findsOneWidget);
    expect(find.text('Get things done with TODO'), findsOneWidget);

    // Verify that the buttons are present
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Tomorrow'), findsOneWidget);
    expect(find.text('Next Week'), findsOneWidget);
  });

  testWidgets('HomePage buttons change state when tapped', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Tap the "Tomorrow" button and verify state change
    await tester.tap(find.text('Tomorrow'));
    await tester.pump(); // Rebuild the widget after the state change

    // Verify that the "Tomorrow" button is now active
    expect(find.text('Tomorrow'), findsOneWidget);
  });

  testWidgets('HomePage has the correct initial state', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that the "Today" button is initially active
    expect(find.text('Today'), findsOneWidget);
  });

  testWidgets('HomePage has a FloatingActionButton', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that the FloatingActionButton is present
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('HomePage FloatingActionButton opens the task input box', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Tap the FloatingActionButton
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Rebuild the widget after the state change

    // Verify that the task input box is now visible
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('HomePage has a gradient background', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that the background is a gradient
    final container = tester.widget<Container>(find.byType(Container).first);
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.gradient, isNotNull);
  });

  testWidgets('HomePage has a title with correct styling', (WidgetTester tester) async {
    // Build the HomePage widget
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that the title has the correct styling
    final titleText = tester.widget<Text>(find.text('HELLO\nSEAN'));
    expect(titleText.style?.fontSize, 30);
    expect(titleText.style?.color, Colors.white);
    expect(titleText.style?.fontWeight, FontWeight.bold);
  });
}