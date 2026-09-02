import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/button/task_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool today = true, tomorrow = false, newWeek = false;
  final String todayTitle = 'Today',
      tomorrowTitle = 'Tomorrow',
      nextWeekTitle = 'Next Week';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(175, 11, 71, 53),
              Color.fromARGB(255, 21, 122, 129),
              Color.fromARGB(255, 38, 90, 138),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HELLO\nSEAN',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Get things done with TODO',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                today
                    ? TaskButtons(title: todayTitle)
                    : GestureDetector(
                        onTap: () {
                          today = true;
                          tomorrow = false;
                          newWeek = false;
                          setState(() {});
                        },
                        child: textButton(title: todayTitle),
                      ),
                tomorrow
                    ? TaskButtons(title: tomorrowTitle)
                    : GestureDetector(
                        onTap: () {
                          today = false;
                          tomorrow = true;
                          newWeek = false;
                          setState(() {});
                        },
                        child: textButton(title: tomorrowTitle),
                      ),
                newWeek
                    ? TaskButtons(title: nextWeekTitle)
                    : GestureDetector(
                        onTap: () {
                          today = false;
                          tomorrow = false;
                          newWeek = true;
                          setState(() {});
                        },
                        child: textButton(title: nextWeekTitle),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textButton({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
