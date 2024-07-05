import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/sample_form_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_app_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';

class SampleFormView extends TheView<SampleFormViewModel> {
  SampleFormView(SampleFormViewModel viewModel)
      : super(viewModel, const Key("SampleFormView"));

  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("USA"), value: "USA"),
      const DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      const DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      const DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

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
                    onChanged: viewModel.updateUsername,
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
                    onChanged: viewModel.updatePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: viewModel.validatePassword),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    items: dropdownItems, onChanged: (_) {}),
              ),
              MaterialButton(
                child: const Text("Done"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (viewModel.login()) {
                      viewModel.coordinator
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
