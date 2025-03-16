import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/job.dart';

class JobService {
  final CollectionReference jobCollection =
      FirebaseFirestore.instance.collection('jobs');

  Stream<List<Job>> getJobs() {
    return jobCollection.snapshots().map((snapshot) => snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Job(
            id: doc.id,
            title: data['title'],
            description: data['description'],
            company: data['company'],
            location: data['location'],
          );
        }).toList());
  }

  Future<DocumentReference<Object?>> addJob(Job job) {
    return jobCollection.add(job.toMap());
  }

  Future<void> updateJob(Job job) {
    return jobCollection.doc(job.id).update(job.toMap());
  }

  Future<void> deleteJob(String id) {
    return jobCollection.doc(id).delete();
  }
}
