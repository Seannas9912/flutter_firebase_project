import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Future<void> addWork(
    Map<String, dynamic> userWorkToday,
    String id,
    String title,
  ) async {
    await FirebaseFirestore.instance
        .collection(title)
        .doc(id)
        .set(userWorkToday);
  }

  static Future<void> deleteWork(String id, String day) async {
    await FirebaseFirestore.instance.collection(day).doc(id).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllWorkSavedForUser(
    String day,
  ) {
    return FirebaseFirestore.instance.collection(day).snapshots();
  }

  static Future<void> completed(String id, String day, bool? completed) {
    return FirebaseFirestore.instance.collection(day).doc(id).update({
      "Completed": completed ?? false,
    });
  }
}
