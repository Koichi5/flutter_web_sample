import 'dart:convert';
import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'http_text_provider.g.dart';

@riverpod
Future<Map<String, dynamic>> httpTextController(
    HttpTextControllerRef ref) async {
  const url = 'https://random-word-api.herokuapp.com/word';
  final startTime = DateTime.now();
  final response = await http.get(Uri.parse(url));
  final endTime = DateTime.now();
  final elapsedSeconds = endTime.difference(startTime).inMilliseconds;

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final randomWord = jsonResponse[0];

    return {
      'word': randomWord,
      'elapsedTime': elapsedSeconds,
    };
  } else {
    log('Request failed with status: ${response.statusCode}');
    return {
      'word': 'ERROR',
      'elapsedTime': elapsedSeconds,
    };
  }
}
