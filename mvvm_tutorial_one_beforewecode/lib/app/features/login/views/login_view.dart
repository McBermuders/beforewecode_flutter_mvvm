import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/login_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/input_feedback_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_app_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';

class LoginView
    extends TheView<LoginViewModel> {
  LoginView(LoginViewModel viewModel)
      : super(viewModel, const Key("SampleFormExternalFeedbackView"));

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildWithViewModel(
      BuildContext context, LoginViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('www.beforewecode.com'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: "",
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+(?:\.\d+)?')),
                  ],
                  onChanged: (v) {
                    viewModel.updateUsername(v);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  validator: viewModel.validateUsername,
                ),
              ),
              InputFeedbackCoordinator(viewModel.inputFeedbackViewModel)
                  .start(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: (v) {
                    viewModel.updatePassword(v);
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: viewModel.validatePassword,
                ),
              ),
              InputFeedbackCoordinator(viewModel.loginFeedbackViewModel)
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
                    if (_formKey.currentState?.validate() == true) {
                      if (viewModel.login()) {

                            viewModel
                            .coordinator
                            .move(NavigationAppIdentifiers.detail, context);
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
