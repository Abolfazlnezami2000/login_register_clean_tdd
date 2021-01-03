import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_register_clean_tdd/Features/login/data/data_sources/login_remote_data_source.dart';
import 'package:login_register_clean_tdd/Features/login/data/models/login_model.dart';
import 'package:login_register_clean_tdd/Features/login/data/repositories/login_repository_impl.dart';
import 'package:login_register_clean_tdd/Features/login/domain/entities/login.dart';
import 'package:login_register_clean_tdd/core/error/exceptions.dart';
import 'package:login_register_clean_tdd/core/error/failure.dart';
import 'package:login_register_clean_tdd/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  LoginRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
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

  group('getAnswerLogin', () {
    final String usernametest = 'test';
    final String passwordtest = 'test';
    final tLoginModel = LoginModel(out: true);
    final Login tLogin = tLoginModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getAnswer(usernametest, passwordtest);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAnswer(any, any))
              .thenAnswer((_) async => tLoginModel);
          // act
          final result = await repository.getAnswer(
              usernametest, passwordtest);
          // assert
          verify(mockRemoteDataSource.getAnswer(usernametest, passwordtest));
          expect(result, equals(Right(tLogin)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAnswer(any, any))
              .thenThrow(ServerException());
          // act
          final result = await repository.getAnswer(
              usernametest, passwordtest);
          // assert
          verify(mockRemoteDataSource.getAnswer(usernametest, passwordtest));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
