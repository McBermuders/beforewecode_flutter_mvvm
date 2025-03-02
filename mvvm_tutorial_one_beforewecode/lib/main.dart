import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/root_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/test_coordinator.dart';

import 'app/business/coordinators/detail_coordinator.dart';
import 'app/business/coordinators/form_coordinator.dart';
import 'app/business/coordinators/login_coordinator.dart';
import 'core/contracts/coordinators/coordinator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CoordinatorListWidget(),
    );
  }
}

class CoordinatorListWidget extends StatelessWidget {
  const CoordinatorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final coordinators = getCoordinators();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordinators'),
      ),
      body: ListView.builder(
        itemCount: coordinators.length,
        itemBuilder: (context, index) {
          final coordinator = coordinators[index];
          return ListTile(
            title: Text(coordinator.runtimeType.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => coordinator.start()),
              );
            },
          );
        },
      ),
    );
  }

  List<Coordinator> getCoordinators() {
    return [
      RootCoordinator(),
      TestCoordinator(),
      DetailCoordinator(),
      FormCoordinator(),
      LoginCoordinator(),
    ];
  }
}
