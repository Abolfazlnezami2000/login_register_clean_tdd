import 'package:flutter_test/flutter_test.dart';
import 'package:login_register_clean_tdd/Features/register/data/data_sources/register_remote_data_source.dart';
import 'package:login_register_clean_tdd/Features/register/data/models/register_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RegisterRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RegisterRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.post(any,
            headers: anyNamed('headers',)))
        .thenAnswer((_) async => http.Response(any,201));
  }

  group('getAnswerRegister', () {
    final String usernametest = 'test';
    final String passwordtest = 'test';
    final int phonenumbertest = 1234567890;
    final String emailtest = 'test@test.com';
    final String nametest = 'test';
    final tRegisterModel = RegisterModel(out : true);
        

    test(
      '''should perform a GET request on a URL with number
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getAnswer(usernametest,passwordtest,nametest,phonenumbertest,emailtest);
        // assert
        verify(mockHttpClient.post(
          'https://reqres.in/api/users',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return Register when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getAnswer(usernametest,passwordtest,nametest,phonenumbertest,emailtest);
        // assert
        expect(true, equals(tRegisterModel));
      },
    );
  });
}
