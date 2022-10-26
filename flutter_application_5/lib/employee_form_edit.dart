



import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_5/employee_form_add.dart';
import 'package:flutter_application_5/employee_model.dart';
import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:office/employee_model.dart';

import 'restapi.dart';

class EmployeeFormEdit extends StatefulWidget{
  const EmployeeFormEdit({Key? key}) : super(key: key);


@override 
_EmployeeFormEditState createState => _EmployeeFormEditState();
}

class _EmployeeFormEditState extends State<_EmployeeFormEdit>{
  DataService ds = DataService();

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final birthday = TextEditingController();
  final address = TextEditingController();
  String gender = 'Male';
  String update_id= '';

  late Future<DateTime?> selectedDate;
  String date = "-";

  //employee data
  List<EmployeeModel> employee = [];

  selectIdEmployee(String id) async{
    List data = [];
    data = jsonDecode(await ds.selectId('63476b4c99b6c11c094bd50f','office','employee','63476cec99b6c11c094bd5ee', id));
    employee = data.map((e) => EmployeeModel.fromJson(e)).toList();

    name.text = employee[0].name;
    birthday.text = employee[0].birthday;
    phone.text = employee[0].phone;
    email.text = employee[0].email;
    address.text = employee[0].address;
    gender = employee[0].gender;
    update_id = employee[0].id;
  }

  @override 
  Widget builde(BuildContext context){
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    selectIdEmployee(args[0]);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Employee Form Edit"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
            child: TextField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Full Name',
              ),
            ),
            )
            //gender
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
               child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  filled: false,
                  border: InputBorder.none,
                ),
                value: gender,
                onChanged: (String? newValue){
                  if(kDebugMode){
                    print(newValue);
                  }

                  setState(() {
                    gender = newValue!;
                  });
                },
                items: <String>['Male','Female']
                .map <DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
              ),
              //birthday
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
                child: TextField(
                  controller: birthday,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Birthday",
                  ),
                  onTap: (){
                    showDialogPicker(context);
                  },
                )
              ),
              //phone
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
                child: TextField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Phone Number",
                  ),
                )
              ),
              //Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Email Address",
                  ),
                )
              ),
              //address
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical:16),
                child: TextField(
                  controller: address,
                  maxLines: 4,
                  minLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Address",
                  ),
                )
              ),
              //submit button
              Padding(
                padding: const  EdgeInsets.symmetric(horizontal: 8, vertical:16),
                child: SizedBox(  
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Colors.lightGreen, elevation: 0),
                      onPressed: () async {
                        bool updateStatus = await ds.updateId(
                          'name~email',
                          name.text+'~' + email.text,
                          '',
                          'office',
                          'employee',
                          '',
                        update_id);

                        if(updateStatus){
                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text("Update"),
                  ),
                ))
        ],
      ),
    );
  }

  //date picker
  void showDialogPicker(BuildContext context){
    selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      builder: (BuildContext context , Widget? child){
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    selectedDate.then((value) {
      setState(() {
        if (value == null) return;

        final DateFormat formatter = DateFormat('dd-mmm-yyyy');
        final String formattedDate = formatter.format(value);
      });
    }, onError: (Error){
      if(kDebugMode){
        print(Error);
      }
    });
  }
}