import 'package:cloud_firestore/cloud_firestore.dart';

Stream<AggregateQuerySnapshot?> getArcadeCrowdnessStream(int id) {
  return FirebaseFirestore.instance
      .collection('reports')
      .where('id', isEqualTo: id)
      .where(
        'ttl',
        isGreaterThan: DateTime.now().subtract(const Duration(hours: 2)),
      )
      .aggregate(count(), sum("crowdness"))
      .get()
      .asStream();
}