import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/sample_form_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_app_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

class SampleFormView extends View<SampleFormViewModel> {
  SampleFormView(SampleFormViewModel viewModel)
      : super(viewModel, const Key("SampleFormView"));

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildWithViewModel(
      BuildContext context, SampleFormViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Semantics(
                label: "Tim Button",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    initialValue: "",
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+(?:\.\d+)?')),
                    ],
                    onChanged: this.viewModel.updateUsername,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              if (viewModel.showUpdateUsernameError())
                const Text("This Character is not allowed"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: this.viewModel.updatePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: this.viewModel.validatePassword),
              ),
              MaterialButton(
                child: const Text("Done"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (this.viewModel.login()) {
                      this
                          .viewModel
                          .coordinator
                          .move(NavigationAppIdentifiers.detail, context);
                    }
                  }
                },
              ),
              if (viewModel.showUpdateLoginError())
                const Text("try 123 and easyasabc"),
            ],
          ),
        ),
      ),
    );
  }
}
