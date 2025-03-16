import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/job_editor.dart';
import '../controllers/jobs_controller.dart';
import '../models/job.dart';
import '../utils/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JobsController(context),
      child: Consumer<JobsController>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(Strings.jobs),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: value.signOut,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(48),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CupertinoSearchTextField(
                  onChanged: value.setSearchQuery,
                ),
              ),
            ),
          ),
          body: StreamBuilder(
            stream: value.getJobs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              }
              final jobs = snapshot.data ?? [];
              return ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return ListTile(
                    title: Text('${job.title}'),
                    subtitle: Text('${job.company} - ${job.location}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => onDeleteJob(
                        context: context,
                        controller: value,
                        job: job,
                      ),
                    ),
                    onTap: () =>
                        editJob(context: context, job: job, controller: value),
                  );
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => editJob(context: context, controller: value),
            icon: Icon(Icons.add),
            label: Text(Strings.addJob),
          ),
        ),
      ),
    );
  }

  void onDeleteJob({
    required BuildContext context,
    required JobsController controller,
    required Job job,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text(Strings.deleteJob),
        content: Text(Strings.deleteJobConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(Strings.cancel),
          ),
          TextButton(
            onPressed: () {
              controller.deleteJob(job.id!);
              Navigator.of(context).pop();
            },
            child: Text(Strings.delete),
          ),
        ],
      ),
    );
  }

  void editJob({
    required BuildContext context,
    Job? job,
    JobsController? controller,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(child: JobEditor(job: job)),
    ).then((value) => controller?.saveJob(value));
  }
}
