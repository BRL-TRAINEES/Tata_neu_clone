import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> loadServiceAccountKey() async {
  
  final file = File('/path/to/tataneuappclone2-f3f9cd4e5508.json');
  try {
    final jsonString = await file.readAsString();
    return json.decode(jsonString);
  } catch (e) {
    print("Error loading JSON file: $e");
    return {};
  }
}
