import 'dart:convert';
import 'package:auto_ecole_app/constants/contante.dart';
import 'package:auto_ecole_app/models/car.dart';
import 'package:auto_ecole_app/models/user.dart';
import 'package:http/http.dart' as http;

class VehiculeController {
  static List<Car> vehiculeList = [];

  static Future<void> fetchVehicule(User user) async {
    try {
      var urlSuffix = 'vehiculesbymoni';
                        String? token = user.token;

      var response = await http.get(Uri.parse('$url$urlSuffix/${user.typeid.toInt()}'),
        headers: {
          'Authorization': 'Bearer $token', // Include token in request headers
        });
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> vehicles = data['vehicles'];
        vehiculeList.clear(); 
        vehicles.forEach((vehicleData) {
          final car = Car.fromMap(vehicleData);
          vehiculeList.add(car);
        });
      } else {
        throw Exception('Failed to fetch vehicles');
      }
    } catch (error) {
      print('Error fetching vehicles: $error');
      throw Exception('Failed to load vehicles');
    }
  }
}
