import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:jobify/controllers/auth_controller.dart';
import 'package:provider/provider.dart';

import '../utils/form_keys.dart';
import '../utils/strings.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController(context)..init(),
      child: Consumer<AuthController>(
          builder: (context, value, child) => Scaffold(
                appBar: AppBar(
                  title: const Text(Strings.jobify),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilder(
                    key: value.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormBuilderTextField(
                          name: FormKeys.email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(hintText: Strings.email),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                        SizedBox(height: 8),
                        FormBuilderTextField(
                          name: FormKeys.password,
                          obscureText: true,
                          decoration:
                              InputDecoration(hintText: Strings.password),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(6),
                          ]),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(value.isLogin
                                ? Strings.alreadyAUser
                                : Strings.notAUser),
                            TextButton(
                                onPressed: value.toggleLogin,
                                child: Text(value.isLogin
                                    ? Strings.signUp
                                    : Strings.signIn)),
                          ],
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: value.onSubmit,
                          child: Text(
                              value.isLogin ? Strings.signIn : Strings.signUp),
                        ),
                        Divider(),
                        ElevatedButton(
                          onPressed: value.continueWithGoogle,
                          child: const Text(Strings.continueWithGoogle),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
