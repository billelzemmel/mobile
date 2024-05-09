import 'dart:convert';
import 'package:auto_ecole_app/models/user.dart';
import 'package:auto_ecole_app/views/calender/widgets/neat_and_clean_calendar_event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_ecole_app/constants/contante.dart'; 

class SessionController {
  static Future<List<NeatCleanCalendarEvent>> fetchSessions(User user) async {
    List<NeatCleanCalendarEvent> sessions = [];
      String? token = user.token;

    String urlSuffix = user.type == "moniteur" ? 'seancesBymon/${user.typeid.toInt()}' : 'seancesBycon/${user.typeid.toInt()}';
    try {
      var response = await http.get(Uri.parse('$url$urlSuffix'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final List<dynamic> sessionData = json.decode(response.body)['seances'];
        for (var data in sessionData) {
          NeatCleanCalendarEvent event = NeatCleanCalendarEvent(
            data['title'],
            description: 'Moniteur: ${data['moniteur_name']}, Candidat: ${data['candidat_name']}',
            startTime: DateTime.parse(data['start']),
            endTime: DateTime.parse(data['end_date']),
            color: Colors.blue, // You might want to handle colors differently based on some condition
          );
          sessions.add(event);
        }
      } else {
        throw Exception('Failed to load sessions');
      }
    } catch (e) {
      print('Error fetching sessions: $e');
      throw Exception('Failed to load sessions');
    }
    return sessions;
  }
}
