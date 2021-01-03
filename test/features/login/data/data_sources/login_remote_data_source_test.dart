import 'package:flutter_test/flutter_test.dart';
import 'package:login_register_clean_tdd/Features/login/data/data_sources/login_remote_data_source.dart';
import 'package:login_register_clean_tdd/Features/login/data/models/login_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  LoginRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers',)))
        .thenAnswer((_) async => http.Response(any,201));
  }

  group('getAnswerLogin', () {
    final String usernametest = 'test';
    final String passwordtest = 'test';
    final tLoginModel = LoginModel(out : true);
        

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getAnswer(usernametest,passwordtest);
        // assert
        verify(mockHttpClient.post(
          'https://reqres.in/api/users/2',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return successful login when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getAnswer(usernametest,passwordtest);
        // assert
        expect(result, equals(tLoginModel));
      },
    );
  });
}
