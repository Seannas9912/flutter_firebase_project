import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Future addTodayWork(
    Map<String, dynamic> userWorkToday,
    String id,
  ) async {
    await FirebaseFirestore.instance
        .collection('Today')
        .doc(id)
        .set(userWorkToday);
  }

  static Future addTomorrowWork(
    Map<String, dynamic> userWorkTomorrow,
    String id,
  ) async {
    await FirebaseFirestore.instance
        .collection('Tomorrow')
        .doc(id)
        .set(userWorkTomorrow);
  }

  static Future addNextWeekWork(
    Map<String, dynamic> userWorkNextWeek,
    String id,
  ) async {
    await FirebaseFirestore.instance
        .collection('Next Week')
        .doc(id)
        .set(userWorkNextWeek);
  }

  static Future<Stream<QuerySnapshot>> getAllWorkSavedForUser(
    String day,
  ) async {
    return await FirebaseFirestore.instance.collection(day).snapshots();
  }

  static Future completed(String id, String day) async {
    return await FirebaseFirestore.instance.collection(day).doc(id).update({
      "Completed": true,
    });
  }
}
