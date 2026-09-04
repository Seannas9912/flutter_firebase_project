import 'package:flutter/material.dart';
import 'package:flutter_firebase_project/button/task_buttons.dart';
import 'package:flutter_firebase_project/service/database.dart';
import 'package:random_string/random_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool today = true, tomorrow = false, newWeek = false, value = false;
  final String todayTitle = 'Today',
      tomorrowTitle = 'Tomorrow',
      nextWeekTitle = 'Next Week';
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openBox();
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 38, 90, 138),
          size: 30,
        ),
      ),
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
            SizedBox(height: 7),
            Text(
              'Get things done with TODO',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
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
                          setState(() {
                            today = true;
                            tomorrow = false;
                            newWeek = false;
                          });
                        },
                        child: _textButton(title: todayTitle),
                      ),
                tomorrow
                    ? TaskButtons(title: tomorrowTitle)
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            today = false;
                            tomorrow = true;
                            newWeek = false;
                          });
                        },
                        child: _textButton(title: tomorrowTitle),
                      ),
                newWeek
                    ? TaskButtons(title: nextWeekTitle)
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            today = false;
                            tomorrow = false;
                            newWeek = true;
                          });
                        },
                        child: _textButton(title: nextWeekTitle),
                      ),
              ],
            ),
            SizedBox(height: 20),
            CheckboxListTile.adaptive(
              activeColor: Colors.white10,
              title: const Text(
                'Check me',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              value: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _textButton({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Future _openBox() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                SizedBox(width: 40),
                Text(
                  'Add Task',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: 'Enter task Description',
                  border: null,
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> userTodo = {
                  "Work": taskController.text,
                  "Id": id,
                };
                if (today) {
                  Database.addTodayWork(userTodo, id);
                } else if (tomorrow) {
                  Database.addTomorrowWork(userTodo, id);
                } else {
                  Database.addNextWeekWork(userTodo, id);
                }
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Add',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
