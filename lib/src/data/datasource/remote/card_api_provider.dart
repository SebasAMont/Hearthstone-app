import 'dart:io';
import 'package:http/http.dart';
import '../../../core/util/constants_api_calls.dart';

class CardApiProvider {
  final Client client;

  CardApiProvider({required this.client});

  Future<String> fetchCardList(
    String endpointString,
    Client client,
  ) async {
    const Map<String, String> apiKeyHeader = kHeaderApi;
    final endpointUrl = Uri.parse(
      '$baseUrlApi$endpointString',
    );
    final response = await client.get(
      endpointUrl,
      headers: apiKeyHeader,
    );
    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else {
      return throw Exception(
        kApiFetchCardError,
      );
    }
  }
}
