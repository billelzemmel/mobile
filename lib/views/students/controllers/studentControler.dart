import 'dart:convert';
import 'package:auto_ecole_app/constants/contante.dart';
import 'package:auto_ecole_app/models/car.dart';
import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/views/students/models/students.dart';
import 'package:http/http.dart' as http;

class StudentsController {
  static List<Students> StudentsList = [];

  static Future<void> fetchStudents(User user) async {
    try {
      var urlSuffix = 'candidatsByMon';
                  String? token = user.token;

      var response =
          await http.get(Uri.parse('$url$urlSuffix/${user.typeid.toInt()}'),
        headers: {
          'Authorization': 'Bearer $token', // Include token in request headers
        });
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> students = data['candidats'];
        StudentsList.clear();
        for (var item in students) {
          StudentsList.add(Students(
            id: item['id'],
            nom: item['user']['nom'],
            prenom: item['user']['prenom'],
            image: item['user']['image_url'],
          ));
          print("stusents");
          print(StudentsList);
        }
      } else {
        throw Exception('Failed to fetch Students');
      }
    } catch (error) {
      print('Error fetching Students: $error');
      throw Exception('Failed to load Students');
    }
  }
}
