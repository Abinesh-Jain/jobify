import 'package:flutter/material.dart';
import 'package:jobify/routes/app_routes.dart';
import '../models/job.dart';
import '../services/auth_service.dart';
import '../services/job_service.dart';

class JobsController extends ChangeNotifier {
  final BuildContext context;

  JobsController(this.context);

  final AuthService _authService = AuthService();

  final JobService _jobService = JobService();

  // Variable to hold the search query
  String _searchQuery = '';

  // Setter for search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners(); // Notify listeners to update UI
  }

  // Get filtered jobs based on the search query
  Stream<List<Job>> getJobs() {
    return _jobService.getJobs().map((jobs) {
      if (_searchQuery.isEmpty) {
        return jobs;
      } else {
        // Filter jobs based on the search query
        return jobs.where((job) {
          return job.title!
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              job.company!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              job.location!.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> deleteJob(String id) async {
    await _jobService.deleteJob(id);
  }

  void saveJob(job) {
    if (job == null) return;
    if (job['id'] == null) {
      _jobService.addJob(Job.fromMap(job));
    } else {
      _jobService.updateJob(Job.fromMap(job));
    }
  }

  void signOut() {
    _authService.signOut();
    Navigator.pushReplacementNamed(context, AppRoutes.auth);
  }
}
