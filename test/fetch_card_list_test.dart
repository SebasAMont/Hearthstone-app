import 'package:first_app/src/core/util/constants_api_calls.dart';

import 'package:first_app/src/data/datasource/remote/card_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fetch_card_list_test.mocks.dart';
import 'mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late CardApiProvider cardApiProvider;

  setUp(() {
    client = MockClient();
    cardApiProvider = CardApiProvider(client: client);
  });

  group('fetchCardList', () {
    test('returns a response.body if the http call is successful', () async {
      when(
        client.get(
          Uri.parse(
            baseUrlApi + kRacesTotemEndPointApi,
          ),
          headers: kHeaderApi,
        ),
      ).thenAnswer(
        (_) async => http.Response(
          jsonMock,
          200,
        ),
      );
      expect(
        await cardApiProvider.fetchCardList(
          kRacesTotemEndPointApi,
          client,
        ),
        isA<String>(),
      );
    });
    test('throws an exception if the call completes with an error', () {
      when(
        client.get(
          Uri.parse(
            baseUrlApi + kRacesTotemEndPointApi,
          ),
          headers: kHeaderApi,
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'NotFound',
          404,
        ),
      );
      expect(
        cardApiProvider.fetchCardList(
          kRacesTotemEndPointApi,
          client,
        ),
        throwsException,
      );
    });
  });
}
