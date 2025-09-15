import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_cities_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_cities_use_case_test.mocks.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';

@GenerateMocks([AddressRepositry])
void main() {
  late GetAllStatesUseCase getAllStatesUseCase;
  late MockAddressRepositry mockAddressRepository;

  setUp(() {
    mockAddressRepository = MockAddressRepositry();
    getAllStatesUseCase = GetAllStatesUseCase(mockAddressRepository);
    provideDummy<LocalDsResult<List<StateEntity>>>(LocalDsFailedResult("Dummy Error"));

  });
  String governateId="1";
  final states=[
    StateEntity(cityId: "1", governorateId: "1", cityNameAr: "15 مايو", cityNameEn: "15 May")
  ];
  test('return list of cities when repo success', () async{
when(mockAddressRepository.getStates(governateId)).thenAnswer((_)async=>
LocalDsSucessResult(states));
final result=await getAllStatesUseCase.getStates(governateId);
expect(result, isA<LocalDsSucessResult>());
final actualResult=(result as LocalDsSucessResult).sucessResult;
expect(actualResult.length, 1);
expect(actualResult[0].cityNameEn, "15 May");
verify(mockAddressRepository.getStates(governateId)).called(1);
  });
  test('should throw an Exception when repository throws an exception', () async {
    // Arrange
    final exception = Exception('Failed to fetch states');
    when(mockAddressRepository.getStates(governateId)).thenThrow(exception);

    // Act & Assert
    expect(
          () => getAllStatesUseCase.getStates(governateId),
      throwsA(isA<Exception>().having(
            (e) => e.toString(),
        'message',
        contains('Failed to fetch states'),
      )),
    );
    verify(mockAddressRepository.getStates(governateId)).called(1);
    verifyNoMoreInteractions(mockAddressRepository);
  });
}