import 'package:flutter/material.dart';

import 'package:flutter_application_5/employee_detail.dart';
import 'package:flutter_application_5/employee_form_add.dart';
import 'package:flutter_application_5/employee_form_edit.dart';
import 'package:flutter_application_5/employee_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn Flutter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const EmployeeList(),
      routes: {
        'employee_list': (context) => const EmployeeList(),
        'employee_form_add': (context) => const EmployeeFormAdd(),
        'employee_form_edit': (context) => const EmployeeFormEdit(),
        'employee_detail': (context) => const EmployeeDetail()
      },
    );
  }
}
