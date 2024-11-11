import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../common/network/exceptions/api_exceptions.dart';
import '../features/description/models/description model.dart';
import '../features/search/models/artwork_model.dart';

const String baseUrl = 'http://localhost:3000/api';

class ApiService {
  Future<ArtworkModel> searchTopic({
    required String query,
  }) async {
    log('search got request');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/search'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': query,
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        log('response.body: $decodedResponse');
        return ArtworkModel.fromJson(decodedResponse);
      } else {
        throw ApiException('Failed to perform search', statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } on FormatException catch (_) {
      throw ApiException('Failed to parse response');
    } catch (e) {
      throw ApiException('Unexpected error occurred: $e');
    }
  }

  Future<DescriptionModel> fetchImageDescription({
    required String query,
  }) async {
    log('search got request');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/description'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'img_url': query,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        log('Raw response: $responseBody');

        final decodedResponse = json.decode(responseBody);

        final model = DescriptionModel.fromJson(decodedResponse);
        log('Created DescriptionModel: $model');
        return model;
      } else {
        throw ApiException('Failed to perform search', statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Failed to parse response: ${e.message}');
    } catch (e) {
      log('Unexpected error: $e');
      throw ApiException('Unexpected error occurred: $e');
    }
  }
}
