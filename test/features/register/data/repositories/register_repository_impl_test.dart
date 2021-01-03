import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_register_clean_tdd/Features/register/data/data_sources/register_remote_data_source.dart';
import 'package:login_register_clean_tdd/Features/register/data/models/register_model.dart';
import 'package:login_register_clean_tdd/Features/register/data/repositories/register_repository_impl.dart';
import 'package:login_register_clean_tdd/Features/register/domain/entities/register.dart';
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements RegisterRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  RegisterRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RegisterRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAnswer Register', () {
    final String usernametest = 'test';
    final String passwordtest = 'test';
    final int phonenumbertest = 1234567890;
    final String emailtest = 'test@test.com';
    final String nametest = 'test';
    final tRegisterModel = RegisterModel(out: true);
    final Register tRegister = tRegisterModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getAnswer(
            usernametest, passwordtest, nametest, phonenumbertest, emailtest);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAnswer(any, any, any, any, any))
              .thenAnswer((_) async => tRegisterModel);
          // act
          final result = await repository.getAnswer(
              usernametest, passwordtest, nametest, phonenumbertest, emailtest);
          // assert
          verify(mockRemoteDataSource.getAnswer(usernametest, passwordtest,
              nametest, phonenumbertest, emailtest));
          expect(result, equals(Right(tRegister)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAnswer(any, any, any, any, any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getAnswer(
              usernametest, passwordtest, nametest, phonenumbertest, emailtest);
          // assert
          verify(mockRemoteDataSource.getAnswer(usernametest, passwordtest,
              nametest, phonenumbertest, emailtest));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
