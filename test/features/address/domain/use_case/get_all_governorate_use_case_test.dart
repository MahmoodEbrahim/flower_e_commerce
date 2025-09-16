import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_governorate_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/address/domain/repositry/address_repositry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_governorate_use_case_test.mocks.dart';

@GenerateMocks([AddressRepositry])
void main() {
  late MockAddressRepositry mockAddressRepositry;
  late GetAllGovernorateUseCase getAllGovernorateUseCase;
  final governorates=[
    GovernorateEntity(id: "1", nameEn: "Cairo", nameAr: "القاهرة"),
    GovernorateEntity(id: "2", nameEn: "Giza", nameAr: "الجيزة"),
    GovernorateEntity(id: "3", nameEn: "Alexandria", nameAr: "الأسكندرية"),
    GovernorateEntity(id: "4", nameEn: "Dakahlia", nameAr: "الدقهلية")

  ];
  setUp((){
    mockAddressRepositry=MockAddressRepositry();
    getAllGovernorateUseCase=GetAllGovernorateUseCase(mockAddressRepositry);
    provideDummy<LocalDsResult<List<GovernorateEntity>>>(LocalDsFailedResult("Dummy Error"));

  });
  test('return list of all governorates when repo success', () async{
   when(mockAddressRepositry.getGovernorates()).thenAnswer((_)async=>
   LocalDsSucessResult(governorates));
   final result=await getAllGovernorateUseCase.getGovernorates();
   final actualResult=(result as LocalDsSucessResult).sucessResult;
   expect(actualResult.length, 4);
   expect(actualResult[0].nameEn, "Cairo");
   verify(mockAddressRepositry.getGovernorates()).called(1);
  });
  test("should throw an Exception when repository throws an exception", ()async{
    final exception=Exception("Failed to Load Governorates");
    when(mockAddressRepositry.getGovernorates()).thenThrow(exception);
    expect(()=>getAllGovernorateUseCase.getGovernorates(), 
        throwsA(isA<Exception>().having((error)=>error.toString(),
        "message", contains("Failed to Load Governorates"))));
    verify(mockAddressRepositry.getGovernorates()).called(1);
  });
}