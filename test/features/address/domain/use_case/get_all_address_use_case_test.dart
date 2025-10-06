import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/address/api/models/response/get_all_address_response.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_address_use_case_test.mocks.dart';

@GenerateMocks([AddressRepositry])
void main() {
  late GetAllAddressesUseCase getAllAddressesUseCase;
  late MockAddressRepositry mockAddressRepository;

  setUp(() {
    mockAddressRepository = MockAddressRepositry();
    getAllAddressesUseCase = GetAllAddressesUseCase(mockAddressRepository);
    provideDummy<Result<List<AddressEntity>>>(FailedResult("Dummy Error"));
  });
  const String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";

  test('return ApiSuccessResult when repo success', () async {
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
    final addresses =
        successResponse.addresses?.map((e) => e.toEntity()).toList() ?? [];
    when(
      mockAddressRepository.getAllAddress(token),
    ).thenAnswer((_) async => SucessResult(addresses));

    final result = await getAllAddressesUseCase.getAllAddress(token);
    expect((result), isA<SucessResult>());
    expect((result as SucessResult).sucessResult, addresses);
    verify(mockAddressRepository.getAllAddress(token)).called(1);
  });
  test("should throw an Exception when repository throws an exception ", () {
    final exception = Exception("Failed to Fetch Addresses");
    when(mockAddressRepository.getAllAddress(token)).thenThrow(exception);
    expect(
      () => getAllAddressesUseCase.getAllAddress(token),
      throwsA(
        (isA<Exception>().having(
          (e) => e.toString(),
          "message",
          contains("Failed to Fetch Addresses"),
        )),
      ),
    );
    verify(mockAddressRepository.getAllAddress(token)).called(1);
  });
}
