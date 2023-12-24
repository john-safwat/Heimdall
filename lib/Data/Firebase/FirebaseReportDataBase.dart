import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Report/ReportDTO.dart';

FirebaseReportDataBase injectFirebaseReportDataBase() {
  return FirebaseReportDataBase.getInstance();
}

class FirebaseReportDataBase {
  // singleton pattern
  FirebaseReportDataBase._();

  static FirebaseReportDataBase? _instance;

  static FirebaseReportDataBase getInstance() {
    return _instance ??= FirebaseReportDataBase._();
  }

  // function to get collection references
  CollectionReference<ReportDTO> getCollectionReference() {
    return FirebaseFirestore.instance.collection("Reports").withConverter(
      fromFirestore: (snapshot, options) => ReportDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // function to send the
  Future<ReportDTO> sendReport({required ReportDTO report})async {
    var ref = getCollectionReference().doc();
    report.id = ref.id;
    await ref.set(report);
    return report;
  }

}
