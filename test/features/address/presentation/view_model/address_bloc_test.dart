import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/get_all_address_response.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_add_address_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_address_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_cities_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_countries_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_governorate_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_delete_address_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_update_address_use_case.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_bloc.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:hive_test/hive_test.dart';
//
// import 'address_bloc_test.mocks.dart';
// @GenerateMocks([GetAddAddressUseCase,GetAllAddressesUseCase,
//   GetAllStatesUseCase,GetAllCountriesUseCase,
//   GetAllGovernorateUseCase,GetDeleteAddressUseCase,GetUpdateAddressUseCase
// ])
// void main() {
//   late AddressBloc bloc;
//   late MockGetAddAddressUseCase mockAddAddressUseCase;
//   late MockGetAllAddressesUseCase mockGetAllAddressUseCase;
//   late MockGetDeleteAddressUseCase mockDeleteAddressUseCase;
//   late MockGetUpdateAddressUseCase mockUpdateAddressUseCase;
//   late MockGetAllGovernorateUseCase mockGetGovernorateUseCase;
//   late MockGetAllStatesUseCase mockGetStatesUseCase;
//   late MockGetAllCountriesUseCase mockGetCountriesUseCase;
//    const String boxName = "user_box";
//    const String tokenBox = "token_box";
//    const String languageBox = "language_box";
//   TestWidgetsFlutterBinding.ensureInitialized();
//   setUp(()async{
//
//     await setUpTestHive();
//
//
//     if (!Hive.isAdapterRegistered(LoginModelAdapter().typeId)) {
//       Hive.registerAdapter(LoginModelAdapter());
//     }
//     if (!Hive.isAdapterRegistered(UserModelAdapter().typeId)) {
//       Hive.registerAdapter(UserModelAdapter());
//     }
//     if (!Hive.isAdapterRegistered(AddressEntityAdapter().typeId)) {
//       Hive.registerAdapter(AddressEntityAdapter());
//     }
//
//
//
//
//     mockAddAddressUseCase = MockGetAddAddressUseCase();
//     mockGetAllAddressUseCase = MockGetAllAddressesUseCase();
//     mockDeleteAddressUseCase = MockGetDeleteAddressUseCase();
//     mockUpdateAddressUseCase = MockGetUpdateAddressUseCase();
//     mockGetGovernorateUseCase = MockGetAllGovernorateUseCase();
//     mockGetStatesUseCase = MockGetAllStatesUseCase();
//     mockGetCountriesUseCase = MockGetAllCountriesUseCase();
//
//     bloc = AddressBloc(
//       mockAddAddressUseCase,
//       mockGetAllAddressUseCase,
//       mockDeleteAddressUseCase,
//       mockGetGovernorateUseCase,
//       mockGetStatesUseCase,
//       mockGetCountriesUseCase,
//       mockUpdateAddressUseCase,
//     );
//     provideDummy<ApiResult<List<AddressEntity>>>(ApiFailedResult("Dummy Error"));
//     provideDummy<ApiResult<RemoveAddressDto>>(ApiFailedResult("Dummy Error"));
//
//   });
//   tearDown(() async {
//
//     if (Hive.isBoxOpen(boxName)) {
//       await Hive.box(boxName).clear();
//       await Hive.box(boxName).close();
//     }
//     if (Hive.isBoxOpen(tokenBox)) {
//       await Hive.box(tokenBox).clear();
//       await Hive.box(tokenBox).close();
//     }
//     if (Hive.isBoxOpen(languageBox)) {
//       await Hive.box(languageBox).clear();
//       await Hive.box(languageBox).close();
//     }
//     await tearDownTestHive();
//   });
//   const String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";
//   AddAdressRequest request=AddAdressRequest(
//       street: "Home",
//       phone: "01010700700",
//       city: "Benha",
//       lat:"z",
//       long:"z",
//       username:"ahmedmuti"
//   );
//   group("Add Address", (){
//     final address=[
//       AddressEntity(
//         id: '1',
//         street: 'Street 1',
//         city: 'City 1',
//         phone: '0100000',
//         lat: '0.0',
//         long: '0.0',
//         username: 'testUser',
//       )
//     ];
//
//     blocTest<AddressBloc,AddressState>
//       ("emits [loading, success] when GetAddAddressEvent succeeds", build: (){
//       when(mockAddAddressUseCase.addAddress(request, token)).thenAnswer((_)
//       async=>ApiSucessResult(address));
//       return bloc;
//     },act: (bloc)=>bloc..add(GetAddAddressEvent(request: request, token: token)),
//         expect:()=> [
//
//           AddressState(  addAddressRequestState: RequestState.loading),
//           AddressState(          addAddressRequestState: RequestState.success,
//               addressEntity: address
//           )
//         ],verify: (_)=>verify(mockAddAddressUseCase.addAddress(request, token)).called(1));
//   },);
//   final error="Failed to add address";
//   blocTest("emits [loading, failure] when GetAddAddressEvent succeeds",
//       build: (){
//
//         when(mockAddAddressUseCase.addAddress(request, token)).thenAnswer((_)async
//         =>ApiFailedResult(error));
//         return bloc;
//       },act: (bloc)=>bloc..add(GetAddAddressEvent(request: request, token: token)),expect: ()=>[
//         AddressState(addAddressRequestState: RequestState.loading),
//         AddressState(addAddressRequestState: RequestState.error,
//             addAddressErrorMessage: error)
//       ]);
//   group("Get Delete Addresses", (){
//     const String id="68beb36ca8bca307f9e2e9fb";
//     final success=RemoveAddressDto(
//         message: "success",
//         address: [
//           Address1(
//               street: "Home",
//               phone: "01010700700",
//               city: "Cairo",
//               lat:"z",
//               long:"z",
//               username:"ahmedmuti",
//               id: "68beb36ca8bca307f9e2e9fb"
//           )
//         ]
//     );
//     blocTest("emits [loading, success] when DeleteAddAddressEvent succeeds",
//         build: (){
//           when(mockDeleteAddressUseCase.removeAddress(token, id)).thenAnswer((_)async=>
//               ApiSucessResult(success));
//           return bloc;
//         },act: (b)=>b..add(DeleteAddressEvent(id: id, token: token)),expect: ()=>[
//           AddressState(
//               deleteAddressRequestState: RequestState.loading
//           ),
//           AddressState(
//               deleteAddressRequestState: RequestState.success,
//               removeAddressDto: success
//           )
//         ],verify: (_)=>verify(mockDeleteAddressUseCase.removeAddress(token, id)).
//         called(1));
//     final error="Failed to delete address";
//     blocTest("emits [loading, failure] when DeleteAddAddressEvent failed", build: (){
//
//       when(mockDeleteAddressUseCase.removeAddress(token, id)).thenAnswer((_)async=>
//           ApiFailedResult(error));
//       return bloc;
//     },act: (b)=>b..add(DeleteAddressEvent(id: id, token: token)),expect: ()=>[
//       AddressState(
//           deleteAddressRequestState: RequestState.loading
//       ),
//       AddressState(
//           deleteAddressRequestState: RequestState.error,
//           deleteAddressErrorMessage:error
//       )
//     ]);
//     group("Update Adress", (){
//       AddAdressRequest request=AddAdressRequest(
//           street: "Home",
//           phone: "01010700700",
//           city: "Benha",
//           lat:"z",
//           long:"z",
//           username:"ahmedmuti"
//       );
//       final address=[
//         AddressEntity(
//           id: '1',
//           street: 'Street 1',
//           city: 'City 1',
//           phone: '0100000',
//           lat: '0.0',
//           long: '0.0',
//           username: 'testUser',
//         )
//       ];
//       blocTest("emits [loading, success] when UpdateAddAddressEvent succeeds",
//           build: (){
//             when(mockUpdateAddressUseCase.updateAddress(token, id, request)).thenAnswer((_)async=>
//                 ApiSucessResult(address));
//
//             return bloc;
//           },act:
//               (b)=>b..add(UpdateAddressEvent(id: id, token: token, request: request)),expect: ()=>[
//             AddressState(updateState: RequestState.loading),
//             AddressState(updateState: RequestState.success,updateAddresses: address)
//           ],verify: (_)=>verify(mockUpdateAddressUseCase.updateAddress(token, id, request)).called(1));
//     },);
//     final errorMessage="load to update address";
//     blocTest("emits [loading, failure] when UpdateAddAddressEvent failed", build: (){
//       when(mockUpdateAddressUseCase.updateAddress(token, id, request)).thenAnswer((_)
//       async=>ApiFailedResult(errorMessage));
//       return bloc;
//     },act: (b)=>b..add(UpdateAddressEvent(id: id,
//         token: token, request: request)),expect: ()=>[
//       AddressState(updateState: RequestState.loading,
//       ),
//       AddressState(updateState: RequestState.error,
//           UpdateAddressErrorMessage: errorMessage
//       )
//     ],verify: (_)=>verify(mockUpdateAddressUseCase
//         .updateAddress(token, id, request)).called(1));
//     group("Get All Addresses", (){
//       final successResponse=GetAllAddressResponse(
//           message: "success",addresses: [
//
//         Addresses(
//             street: "Home",
//             phone: "01010700700",
//             city: "Benha",
//             lat:"z",
//             long:"z",
//             username:"ahmedmuti",
//             Id: "68beb36ca8bca307f9e2e9fb"
//         )
//       ]
//       );
//       final addresses=successResponse.addresses?.map((e)=>e.toEntity()).toList()??[];
//       blocTest("emits [loading, success] when GetAddAddressEvent succeeds", build: (){
//         when(mockGetAllAddressUseCase.getAllAddress(token)).thenAnswer((_)
//         async=>ApiSucessResult(addresses));
//         return bloc;
//       },act: (b)=>b..add(GetAllddressEvent(token: token)),expect: ()=>[
//         AddressState(
//           getAddressRequestState: RequestState.loading,
//
//         ),
//         AddressState(
//             getAddressRequestState: RequestState.success,
//             addresses: addresses
//
//         ),
//       ],verify: (_)=>verify(mockGetAllAddressUseCase.getAllAddress(token)).called(1));
//     });  final errorMsg="Failed to load Addresses";
//     blocTest("emits [loading, failure] when GetAddAddressEvent failed", build: (){
//
//       when(mockGetAllAddressUseCase.getAllAddress(token)).thenAnswer((_)async=>
//           ApiFailedResult(errorMsg));
//       return bloc;
//     },act: (b)=>b..add(GetAllddressEvent(token: token)),expect: ()=>[
//       AddressState(
//           getAddressRequestState: RequestState.loading
//       ),
//       AddressState(
//           getAddressRequestState: RequestState.error,
//           getAddressErrorMessage: errorMsg
//
//       ),
//     ]);
//   });
//
//
// }
