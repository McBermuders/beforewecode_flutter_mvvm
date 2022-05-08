import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/sample_form_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_code_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

class SampleFormView extends View<SampleFormViewModel> {
  const SampleFormView(SampleFormViewModel viewModel)
      : super(viewModel, const Key("SampleFormView"));

  @override
  Widget buildWithViewModel(
      BuildContext context, SampleFormViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Semantics(
              label: "Tim Button",
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                ),
              ),
            ),
            if (viewModel.showUpdateUsernameError())
              const Text("This Character is not allowed"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: this.viewModel.updatePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            MaterialButton(
                child: const Text("Login"),
                onPressed: () {
                  if (this.viewModel.login()) {
                    this
                        .viewModel
                        .coordinator
                        .move(NavigationCodeIdentifiers.detail, context);
                  }
                }),
            if (viewModel.showUpdateLoginError())
              const Text("try 123 and easyasabc"),
          ],
        ),
      ),
    );
  }
}
