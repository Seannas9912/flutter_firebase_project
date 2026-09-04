import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
  bool today = true, tomorrow = false, newWeek = false;
  final String todayTitle = 'Today',
      tomorrowTitle = 'Tomorrow',
      nextWeekTitle = 'Next Week';
  final TextEditingController taskController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? todoStream;

  String get selectedDay => today
        ? todayTitle
        : tomorrow
        ? tomorrowTitle
        : nextWeekTitle;

  void getOnLoad() {
    if (Firebase.apps.isEmpty) {
      todoStream = null;
      return;
    }
    todoStream = Database.getAllWorkSavedForUser(selectedDay);
  }

  @override
  void initState() {
    super.initState();
    getOnLoad();
  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

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
                            getOnLoad();
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
                            getOnLoad();
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
                            getOnLoad();
                          });
                        },
                        child: _textButton(title: nextWeekTitle),
                      ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(child: allWork()),
          ],
        ),
      ),
    );
  }

  Widget allWork() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: todoStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Unable to load tasks: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot<Map<String, dynamic>> ds =
                snapshot.data!.docs[index];
            return CheckboxListTile.adaptive(
              activeColor: Colors.white10,
              title: Text(
                ds["Work"] as String,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
              value: ds["Completed"] as bool? ?? false,
              onChanged: (newValue) async {
                if (newValue == true) {
                  final day = selectedDay;
                  await Database.completed(ds["Id"] as String, day);
                }
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
      },
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
              onTap: () async {
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> userTodo = {
                  "Work": taskController.text,
                  "Id": id,
                  "Completed": false,
                };
                await (today
                    ? Database.addTodayWork(userTodo, id)
                    : tomorrow
                    ? Database.addTomorrowWork(userTodo, id)
                    : Database.addNextWeekWork(userTodo, id));
                taskController.clear();
                if (context.mounted) {
                  Navigator.pop(context);
                }
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
