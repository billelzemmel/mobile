import 'package:auto_ecole_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:auto_ecole_app/views/students/controllers/studentControler.dart';
import 'package:auto_ecole_app/views/students/models/students.dart';
import 'package:auto_ecole_app/constants/colors.dart';
import 'package:auto_ecole_app/constants/contante.dart';

class StudentBlock extends StatefulWidget {
  @override
  _StudentBlockState createState() => _StudentBlockState();
}

class _StudentBlockState extends State<StudentBlock> {
  late User? conuser;
  final boxs = GetStorage();

  @override
  void initState() {
    super.initState();
    conuser = boxs.read('connectedUser');
    if (conuser != null) {
      StudentsController.fetchStudents(conuser!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: StudentsController.StudentsList.length,
        itemBuilder: (BuildContext context, int index) {
          Students student = StudentsController.StudentsList[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${student.nom} ${student.prenom}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    student.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Text('Error loading image');
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
