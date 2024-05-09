import 'dart:convert';
import 'package:auto_ecole_app/constants/contante.dart';
import 'package:auto_ecole_app/models/user.dart';
import 'package:http/http.dart' as http;

class Category {
  Category({
    this.title = '',
    this.typeexam = '',
    this.date = '',
    this.candidiatnom = '',
    this.moniteurnom = '',
    this.moniteurprenom = '',
    this.candidiatprenom = '',
    this.picture = '',
  });

  String title;
  String typeexam;
  String date;
  String candidiatnom;
  String moniteurnom;
  String picture;
  String moniteurprenom;
  String candidiatprenom;
  static List<Category> categoryList = <Category>[];
  static List<Category> categoryListRecent = <Category>[];

  static Future<void> fetchCategories(User user) async {
    print(user.typeid.toInt());
    try {
      var urlSuffix = user.type == 'moniteur' ? 'examsbyMonNoPag' : 'examsbyConNoPag';
      String? token = user.token;

      var response = await http.get(
        Uri.parse('$url$urlSuffix/${user.typeid.toInt()}'),
        headers: {
          'Authorization': 'Bearer $token', // Include token in request headers
        },
      );
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> exams = data['exams'];
        final currentDate = DateTime.now();
        categoryList.clear();
        categoryListRecent.clear();
        exams.forEach((exam) {
          final category = Category(
            title: exam['reference'] ?? '',
            typeexam: exam['types'] != null ? exam['types']['type'] ?? '' : '',
            date: exam['date'] ?? '',
            candidiatnom:
                exam['condidiat'] != null && exam['condidiat']['user'] != null
                    ? exam['condidiat']['user']['nom'] ?? ''
                    : '',
            moniteurprenom:
                exam['moniteur'] != null && exam['moniteur']['user'] != null
                    ? exam['moniteur']['user']['prenom'] ?? ''
                    : '',
            candidiatprenom:
                exam['condidiat'] != null && exam['condidiat']['user'] != null
                    ? exam['condidiat']['user']['prenom'] ?? ''
                    : '',
            moniteurnom:
                exam['moniteur'] != null && exam['moniteur']['user'] != null
                    ? exam['moniteur']['user']['nom'] ?? ''
                    : '',
            picture:
                exam['condidiat'] != null && exam['condidiat']['user'] != null
                    ? exam['condidiat']['user']['image_url'] ?? ''
                    : '',
          );
          if (DateTime.parse(category.date).isAfter(DateTime(2024, 4, 4))) {
            categoryListRecent.add(category);
          } else {
            categoryList.add(category);
          }
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (error) {
      print('Error fetching categories: $error');
      throw Exception('Failed to load categories');
    }
  }
}
