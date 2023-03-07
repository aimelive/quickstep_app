import 'package:flutter_dotenv/flutter_dotenv.dart';

String googleApiKey = dotenv.env['GOOGLE_API_KEY']!;
String backendUrl = dotenv.env['BACKEND_URL']!;
String backendApiUrl = "${dotenv.env['BACKEND_URL']}";
