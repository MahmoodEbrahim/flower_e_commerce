import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/get_all_address_response.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_update_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_update_address_use_case_test.mocks.dart';

@GenerateMocks([AddressRepositry])
void main() {
  const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";
  AddAdressRequest request = AddAdressRequest(
    street: "Home",
    phone: "01010700700",
    city: "Benha",
    lat: "z",
    long: "z",
    username: "ahmedmuti",
  );
  final successResponse = GetAllAddressResponse(
    message: "success",
    addresses: [
      Addresses(
        street: "Home",
        phone: "01010700700",
        city: "Benha",
        lat: "z",
        long: "z",
        username: "ahmedmuti",
        Id: "68beb36ca8bca307f9e2e9fb",
      ),
    ],
  );
  const String id = "68bea7d4a8bca307f9e2e8ec";
  late MockAddressRepositry mockAddressRepositry;

  late GetUpdateAddressUseCase getUpdateAddressUseCase;
  setUp(() {
    mockAddressRepositry = MockAddressRepositry();
    getUpdateAddressUseCase = GetUpdateAddressUseCase(mockAddressRepositry);
    provideDummy<Result<List<AddressEntity>>>(FailedResult("Dummy Error"));
  });
  test('should return ApisuccessResult when repo success', () async {
    final addresses = successResponse.addresses!
        .map((e) => e.toEntity())
        .toList();

    when(
      mockAddressRepositry.updateAddress(token, id, request),
    ).thenAnswer((_) async => SucessResult(addresses));
    final result = await getUpdateAddressUseCase.updateAddress(
      token,
      id,
      request,
    );
    expect(result, isA<SucessResult<List<AddressEntity>>>());
    expect((result as SucessResult).sucessResult, addresses);
    verify(mockAddressRepositry.updateAddress(token, id, request)).called(1);
  });
  test(
    'should throw an Exception when repository throws an exception',
    () async {
      // Arrange
      final exception = Exception('Failed to fetch data');
      when(
        mockAddressRepositry.updateAddress(token, id, request),
      ).thenThrow(exception);

      // Act & Assert
      expect(
        () => getUpdateAddressUseCase.updateAddress(token, id, request),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Failed to fetch data'),
          ),
        ),
      );
      verify(mockAddressRepositry.updateAddress(token, id, request)).called(1);
      verifyNoMoreInteractions(mockAddressRepositry);
    },
  );
}
