import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Future addTodayWork(Map<String, dynamic> userWorkToday, String id) async {
    await FirebaseFirestore.instance
        .collection('TodayWork')
        .doc(id)
        .set(userWorkToday);
  }

  static Future addTomorrowWork(Map<String, dynamic> userWorkTomorrow, String id) async {
    await FirebaseFirestore.instance
        .collection('TomorrowWork')
        .doc(id)
        .set(userWorkTomorrow);
  }

  static Future addNextWeekWork(Map<String, dynamic> userWorkNextWeek, String id) async {
    await FirebaseFirestore.instance
        .collection('NextWeekWork')
        .doc(id)
        .set(userWorkNextWeek);
  }
}