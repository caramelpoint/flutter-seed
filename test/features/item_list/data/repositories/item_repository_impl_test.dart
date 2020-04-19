import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:caramelseed/core/error/exceptions.dart';
import 'package:caramelseed/core/error/failures.dart';
import 'package:caramelseed/core/network/network_info.dart';
import 'package:caramelseed/features/item_list/data/datasources/item_remote_data_source.dart';
import 'package:caramelseed/features/item_list/data/repositories/item_repository_impl.dart';
import 'package:caramelseed/features/item_list/domain/entities/item.dart';
import 'package:caramelseed/features/item_list/domain/repositories/item_repository.dart';
import 'package:mockito/mockito.dart';

class MockItemRemoteDataSource extends Mock implements ItemRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockNetworkInfo mockNetworkInfo;
  MockItemRemoteDataSource mockRemoteDataSource;
  ItemRepository repository;

  setUpAll(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockItemRemoteDataSource();
    repository = ItemRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final List<Item> list = <Item>[
    const Item(
      id: 'Test Id',
      name: 'Test Name',
      createdAt: 'Test today',
      updatedAt: 'Test today',
    )
  ];

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

  group('Get All', () {
    runTestsOffline(() {
      test(
        'should return a no connection failure',
        () async {
          when(mockRemoteDataSource.getAll()).thenAnswer((_) async => list);

          final result = await repository.getAll();

          verifyNever(mockRemoteDataSource.getAll());
          expect(result, Left(NoConnectionFailure()));
        },
      );
    });

    runTestsOnline(() {
      test(
        'should return a list of items when everything is ok',
        () async {
          when(mockRemoteDataSource.getAll()).thenAnswer((_) async => list);

          final result = await repository.getAll();

          verify(mockRemoteDataSource.getAll());
          expect(result, Right(list));
        },
      );
      test(
        'should return a GetAllItemsFailure failure when a server error occurs',
        () async {
          when(mockRemoteDataSource.getAll()).thenThrow(ServerException());

          final result = await repository.getAll();

          verify(mockRemoteDataSource.getAll());
          expect(result, Left(GetAllItemsFailure()));
        },
      );
    });
  });
}
