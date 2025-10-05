import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/add_address_responsea.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_add_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_add_address_use_case_test.mocks.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';

@GenerateMocks([AddressRepositry])
void main() {
  const String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";
  AddAdressRequest request=AddAdressRequest(
      street: "Home",
      phone: "01010700700",
      city: "Benha",
      lat:"z",
      long:"z",
      username:"ahmedmuti"
  );
  final successResponse=AddAddressResponse(
      message: "success",address: [

    Address(
        street: "Home",
        phone: "01010700700",
        city: "Benha",
        lat:"z",
        long:"z",
        username:"ahmedmuti",
        Id: "68beb36ca8bca307f9e2e9fb"
    )
  ]
  );
late MockAddressRepositry mockAddressRepositry;
late GetAddAddressUseCase getAddAddressUseCase;
setUp((){
  mockAddressRepositry=MockAddressRepositry();
  getAddAddressUseCase=GetAddAddressUseCase(mockAddressRepositry);
  provideDummy<ApiResult<List<AddressEntity>>>(ApiFailedResult("Dummy Error"));
});
  test('return ApiSuccessResult when repo success', () async{
    final addresses=successResponse.address!.map((e)=>e.toEntity()).toList();
when(mockAddressRepositry.addAddress(request, token)).thenAnswer((_)
async=>ApiSucessResult(addresses));
final result=await getAddAddressUseCase.addAddress(request, token);
expect(result, isA<ApiSucessResult<List<AddressEntity>>>());
expect((result as ApiSucessResult).sucessResult, addresses);
verify(mockAddressRepositry.addAddress(request, token)).called(1);
  });
  test('should throw an Exception when repository throws an exception', () async {
    // Arrange
    final exception = Exception('Failed to fetch data');
    when(mockAddressRepositry.addAddress(request, token)).thenThrow(exception);

    // Act & Assert
    expect(
          () => getAddAddressUseCase.addAddress(request, token),
      throwsA(isA<Exception>().having(
            (e) => e.toString(),
        'message',
        contains('Failed to fetch data'),
      )),
    );
    verify(mockAddressRepositry.addAddress(request, token)).called(1);
    verifyNoMoreInteractions(mockAddressRepositry);
  });


}