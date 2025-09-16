import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_delete_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_delete_address_use_case_test.mocks.dart';

@GenerateMocks([AddressRepositry])
void main() {
  const String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";
  const String id="68bea7d4a8bca307f9e2e8ec";

  late MockAddressRepositry mockAddressRepositry;
  late GetDeleteAddressUseCase deleteAddressUseCase;
  setUp((){
  mockAddressRepositry=MockAddressRepositry();
  deleteAddressUseCase=GetDeleteAddressUseCase(mockAddressRepositry);
  provideDummy<ApiResult<RemoveAddressDto>>(ApiFailedResult("Dummy Error"));
  });
  test('return ApiSuccessResult when repo success', () async{
  final successResponse=RemoveAddressDto(
    message: "success",
    address: [
      Address1(
          street: "Home",
          phone: "01010700700",
          city: "Benha",
          lat:"z",
          long:"z",
          username:"ahmedmuti",
          id: "68beb36ca8bca307f9e2e9fb"
      )
    ]
  );
  when(mockAddressRepositry.removeAddress(token, id)).thenAnswer((_)
  async=>ApiSucessResult(successResponse));
  final result=await deleteAddressUseCase.removeAddress(token, id);
  expect(result, isA<ApiSucessResult>());
  expect((result as ApiSucessResult).sucessResult, successResponse);
  verify(mockAddressRepositry.removeAddress(token, id)).called(1);
  });
  test('should throw an Exception when repository throws an exception', () async {
  // Arrange
  final exception = Exception('Failed to fetch data');
  when(mockAddressRepositry.removeAddress(token, id)).thenThrow(exception);

  // Act & Assert
  expect(
  () =>deleteAddressUseCase.removeAddress(token, id),
  throwsA(isA<Exception>().having(
  (e) => e.toString(),
  'message',
  contains('Failed to fetch data'),
  )),
  );
  verify(mockAddressRepositry.removeAddress(token, id)).called(1);
  verifyNoMoreInteractions(mockAddressRepositry);
  });
}