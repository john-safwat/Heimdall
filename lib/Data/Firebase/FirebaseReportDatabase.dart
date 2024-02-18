import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Report/ReportDTO.dart';

FirebaseReportDatabase injectFirebaseReportDataBase() {
  return FirebaseReportDatabase.getInstance();
}

class FirebaseReportDatabase extends BaseDatabase{
  // singleton pattern
  FirebaseReportDatabase._();

  static FirebaseReportDatabase? _instance;

  static FirebaseReportDatabase getInstance() {
    return _instance ??= FirebaseReportDatabase._();
  }

  // function to get collection references
  CollectionReference<ReportDTO> getCollectionReference() {
    return FirebaseFirestore.instance.collection(constants.reportsCollection).withConverter(
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
