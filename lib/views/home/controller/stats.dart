import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/constants/contante.dart';

class GetStats {
  static Future<void> GetStatsCount(User user) async {
    var urlSuffix = 'CountExamsCode';
    var urlSuffix2 = 'CountExamsConduit';
    var urlSuffix3 = 'CountMoniteurId';
                String? token = user.token;

    var response =
        await http.get(Uri.parse('$url$urlSuffix/${user.typeid.toInt()}'),
        headers: {
          'Authorization': 'Bearer $token', // Include token in request headers
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final NbexamCode = double.tryParse(data['nombre code'].toString()) ?? 0;
      print("NbexamCode");

      print('Response body NbexamCode: ${response.body}');
      final box = GetStorage();
      box.write('NbexamsCode', NbexamCode);
    }

    var response2 =
        await http.get(Uri.parse('$url$urlSuffix2/${user.typeid.toInt()}'),
        headers: {
          'Authorization': 'Bearer $token', // Include token in request headers
        });

    if (response2.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response2.body);
      final NbexamConduit =
          double.tryParse(data['nombre conduit'].toString()) ?? 0;
      print("NbexamConduit");
      print(NbexamConduit);
      final box = GetStorage();
      box.write('NbexamsConduit', NbexamConduit);
    }
    var response3 =
        await http.get(Uri.parse('$url$urlSuffix3/${user.typeid.toInt()}'),
        headers: {
          'Authorization': 'Bearer $token', // Include token in request headers
        });
    if (response3.statusCode == 200) {
      final Map<String, dynamic> data3 =
          json.decode(response3.body); // Use response3.body here
      final nbCondidat =
          double.tryParse(data3['nombre Condidats'].toString()) ??
              0; // Use data3 here
      print('Response body nb condidats: ${response3.body}');

      final box = GetStorage();
      box.write('Nbcandidat', nbCondidat);
    }
  }
}
