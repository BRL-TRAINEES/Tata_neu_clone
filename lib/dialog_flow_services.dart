import 'dart:convert';
import 'package:flutter/services.dart'; 
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

class DialogflowService {
  final String _projectId;
  final String _clientEmail;
  final String _privateKey;

  DialogflowService({
    required String projectId,
    required String clientEmail,
    required String privateKey,
  })  : _projectId = projectId,
        _clientEmail = clientEmail,
        _privateKey = privateKey;

  
  Future<String> _getAccessToken() async {
    final client = http.Client();

    //  service account credentials
    final serviceAccountCredentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": _projectId,
      "private_key_id": "", 
      "private_key": _privateKey,
      "client_email": _clientEmail,
      "client_id": "",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": ""
    });

    
    final authClient = await clientViaServiceAccount(
      serviceAccountCredentials,
      ['https://www.googleapis.com/auth/cloud-platform'],
    );

    return authClient.credentials.accessToken.data;
  }

  Future<String> sendMessage(String message) async {
    final accessToken = await _getAccessToken();
    final url =
        'https://dialogflow.googleapis.com/v2/projects/$_projectId/agent/sessions/123456:detectIntent';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'queryInput': {
          'text': {
            'text': message,
            'languageCode': 'en',
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['queryResult']['fulfillmentText'];
    } else {
      throw Exception('Failed to connect to Dialogflow: ${response.body}');
    }
  }

  
  static Future<DialogflowService> fromJson(String jsonPath) async {
    
    final jsonString = await rootBundle.loadString(jsonPath);
    final jsonData = jsonDecode(jsonString);

    return DialogflowService(
      projectId: jsonData['project_id'],
      clientEmail: jsonData['client_email'],
      privateKey: jsonData['private_key'],
    );
  }
}
