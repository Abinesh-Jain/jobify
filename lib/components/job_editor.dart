import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:jobify/utils/strings.dart';

import '../models/job.dart';
import '../utils/form_keys.dart';

class JobEditor extends StatelessWidget {
  JobEditor({super.key, this.job, this.onSave});

  final Job? job;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  final void Function(Map? job)? onSave;

  void _save(BuildContext context) {
    final valid = formKey.currentState?.saveAndValidate();
    if (valid == true) {
      final values = formKey.currentState?.value;
      if (job != null) values?[FormKeys.id] = job!.id;
      onSave?.call(values);
      Navigator.of(context).pop(values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job == null ? Strings.addJob : Strings.editJob,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            FormBuilderTextField(
              initialValue: job?.title,
              name: FormKeys.title,
              decoration: InputDecoration(hintText: Strings.title),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            SizedBox(height: 8),
            FormBuilderTextField(
              initialValue: job?.description,
              name: FormKeys.description,
              decoration: InputDecoration(hintText: Strings.description),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            SizedBox(height: 8),
            FormBuilderTextField(
              initialValue: job?.company,
              name: FormKeys.company,
              decoration: InputDecoration(hintText: Strings.company),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            SizedBox(height: 8),
            FormBuilderTextField(
              initialValue: job?.location,
              name: FormKeys.location,
              decoration: InputDecoration(hintText: Strings.location),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                  onPressed: () => _save(context),
                  child: Text(Strings.save),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  onPressed: Navigator.of(context).pop,
                  child: Text(Strings.cancel),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
