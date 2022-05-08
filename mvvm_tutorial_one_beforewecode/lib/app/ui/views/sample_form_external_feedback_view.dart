import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/sample_form_external_feedback_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/input_feedback_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_code_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

class SampleFormExternalFeedbackView
    extends View<SampleFormExternalFeedackViewModel> {
  const SampleFormExternalFeedbackView(
      SampleFormExternalFeedackViewModel viewModel)
      : super(viewModel, const Key("SampleFormExternalFeedbackView"));

  @override
  Widget buildWithViewModel(
      BuildContext context, SampleFormExternalFeedackViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('www.beforewecode.com'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: "",
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+(?:\.\d+)?')),
                ],
                onChanged: this.viewModel.updateUsername,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            InputFeedbackCoordinator(viewModel.getInputFeedbackViewModel())
                .start(),
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
            InputFeedbackCoordinator(viewModel.getLoginFeedbackViewModel())
                .start(),
            Semantics(
              button: true,
              label: "My own label",
              hint: "my own hint",
              excludeSemantics: true,
              container: true,
              child: MaterialButton(
                  child: const Text("Login"),
                  onPressed: () {
                    if (viewModel.login()) {
                      this.viewModel.coordinator.move(NavigationCodeIdentifiers.detail, context);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
