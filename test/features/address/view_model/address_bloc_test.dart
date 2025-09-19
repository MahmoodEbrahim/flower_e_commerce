import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/api/models/response/get_all_address_response.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/time_zone.dart';
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


import 'address_bloc_test.mocks.dart';
@GenerateMocks([GetAddAddressUseCase,GetAllAddressesUseCase,

  GetAllStatesUseCase,GetAllCountriesUseCase,
  GetAllGovernorateUseCase,GetDeleteAddressUseCase,GetUpdateAddressUseCase
])
void main() {
  late AddressBloc bloc;
  late MockGetAddAddressUseCase mockAddAddressUseCase;
  late MockGetAllAddressesUseCase mockGetAllAddressUseCase;
  late MockGetDeleteAddressUseCase mockDeleteAddressUseCase;
  late MockGetUpdateAddressUseCase mockUpdateAddressUseCase;
  late MockGetAllGovernorateUseCase mockGetGovernorateUseCase;
  late MockGetAllStatesUseCase mockGetStatesUseCase;
  late MockGetAllCountriesUseCase mockGetCountriesUseCase;
  const String boxName = "user_box";
   const String tokenBox = "token_box";
   const String languageBox = "language_box";
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(()async{







    mockAddAddressUseCase = MockGetAddAddressUseCase();
    mockGetAllAddressUseCase = MockGetAllAddressesUseCase();
    mockDeleteAddressUseCase = MockGetDeleteAddressUseCase();
    mockUpdateAddressUseCase = MockGetUpdateAddressUseCase();
    mockGetGovernorateUseCase = MockGetAllGovernorateUseCase();
    mockGetStatesUseCase = MockGetAllStatesUseCase();
    mockGetCountriesUseCase = MockGetAllCountriesUseCase();

    bloc = AddressBloc(
      mockAddAddressUseCase,
      mockGetAllAddressUseCase,
      mockDeleteAddressUseCase,
      mockGetGovernorateUseCase,
      mockGetStatesUseCase,
      mockGetCountriesUseCase,
      mockUpdateAddressUseCase,
    );


    provideDummy<ApiResult<List<AddressEntity>>>(ApiFailedResult("Dummy Error"));
    provideDummy<ApiResult<RemoveAddressDto>>(ApiFailedResult("Dummy Error"));
provideDummy<LocalDsResult<List<CountryEntity>>>(LocalDsFailedResult("Dummy Error Countries"));
    provideDummy<LocalDsResult<List<GovernorateEntity>>>(LocalDsFailedResult("Dummy Error Governorates"));
    provideDummy<LocalDsResult<List<StateEntity>>>(LocalDsFailedResult("Dummy Error States"));

  });

  const String token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjhhMjE4MjVhOGJjYTMwN2Y5ZGU5MzY1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NTczMjU5MDl9.HKOPAn1Jc4jKqfmts8nPMvcBb1MLoDqP4olR2ND9pLk";
  AddAdressRequest request=AddAdressRequest(
      street: "Home",
      phone: "01010700700",
      city: "Benha",
      lat:"z",
      long:"z",
      username:"ahmedmuti"
  );
  final loginModel = LoginModel(
    user: UserModel(
 iid: "123",
      email: "mariam@gmail.com",
      firstName: "mariam",
      lastName: "mohmed",
      gender: "female",
      phone: "01061728082",
      photo: "",
      role: "user",
      wishlist: [],
      addresses: [],
    ),
    token: token
  );
  final address1=[
    AddressEntity(
      id: '1',
      street: 'Street 1',
      city: 'City 1',
      phone: '0100000',
      lat: '0.0',
      long: '0.0',
      username: 'testUser',
    )
  ];
  final updatedUser = UserModel(
    iid: "123",
    email: "mariam@gmail.com",
    firstName: "mariam",
    lastName: "mohmed",
    gender: "female",
    phone: "01061728082",
    photo: "",
    role: "user",
    wishlist: [],
    addresses:address1 ,
  );
  final updatedLoginModel =
  LoginModel(user: updatedUser,token: token);
  group("Add Address", (){


    blocTest<AddressBloc,AddressState>
      ("emits [loading, success] when GetAddAddressEvent succeeds",
        build: (){
      when(mockAddAddressUseCase.addAddress(request, token)).thenAnswer((_)
      async=>ApiSucessResult(address1));

      return bloc;
    },act: (bloc)=>bloc..add(GetAddAddressEvent(request: request, token: token)),
        expect:()=> [

          AddressState(
            addAddressRequestState: RequestState.loading
          ),
    AddressState(   addAddressRequestState: RequestState.success,
              addressEntity: address1
          )
        ],verify: (_)=>
            verify(mockAddAddressUseCase.
            addAddress(request, token)).called(1));

  },);
  final error="Failed to add address";
  blocTest("emits [loading, failure] when GetAddAddressEvent succeeds",
      build: (){

        when(mockAddAddressUseCase.addAddress(request, token)).thenAnswer((_)async
        =>ApiFailedResult(error));
        return bloc;
      },act: (bloc)=>bloc..add(GetAddAddressEvent(request: request, token: token)),expect: ()=>[
        AddressState(addAddressRequestState: RequestState.loading),
        AddressState(addAddressRequestState: RequestState.error,
            addAddressErrorMessage: error)
      ]);
  group("Get Delete Addresses", (){
    const String id="68beb36ca8bca307f9e2e9fb";
    final success=RemoveAddressDto(
        message: "success",
        address: [
          Address1(
              street: "Home",
              phone: "01010700700",
              city: "Cairo",
              lat:"z",
              long:"z",
              username:"ahmedmuti",
              id: "68beb36ca8bca307f9e2e9fb"
          )
        ]
    );
    blocTest("emits [loading, success] when DeleteAddAddressEvent succeeds",
        build: (){
          when(mockDeleteAddressUseCase.removeAddress(token, id)).thenAnswer((_)async=>
              ApiSucessResult(success));
          return bloc;
        },act: (b)=>b..add(DeleteAddressEvent(id: id, token: token)),expect: ()=>[
          AddressState(
              deleteAddressRequestState: RequestState.loading
          ),
          AddressState(
              deleteAddressRequestState: RequestState.success,
              removeAddressDto: success
          )
        ],verify: (_)=>verify(mockDeleteAddressUseCase.removeAddress(token, id)).
        called(1));
    final error="Failed to delete address";
    blocTest("emits [loading, failure] when DeleteAddAddressEvent failed", build: (){

      when(mockDeleteAddressUseCase.removeAddress(token, id)).thenAnswer((_)async=>
          ApiFailedResult(error));
      return bloc;
    },act: (b)=>b..add(DeleteAddressEvent(id: id, token: token)),expect: ()=>[
      AddressState(
          deleteAddressRequestState: RequestState.loading
      ),
      AddressState(
          deleteAddressRequestState: RequestState.error,
          deleteAddressErrorMessage:error
      )
    ]);
    group("Update Adress", (){
      AddAdressRequest request=AddAdressRequest(
          street: "Home",
          phone: "01010700700",
          city: "Benha",
          lat:"z",
          long:"z",
          username:"ahmedmuti"
      );
      final address=[
        AddressEntity(
          id: '1',
          street: 'Street 1',
          city: 'City 1',
          phone: '0100000',
          lat: '0.0',
          long: '0.0',
          username: 'testUser',
        )
      ];
      blocTest("emits [loading, success] when UpdateAddAddressEvent succeeds",
          build: (){
            when(mockUpdateAddressUseCase.updateAddress(token, id, request)).thenAnswer((_)async=>
                ApiSucessResult(address));

            return bloc;
          },act:
              (b)=>b..add(UpdateAddressEvent(id: id, token: token, request: request)),expect: ()=>[
            AddressState(updateState: RequestState.loading),
            AddressState(updateState: RequestState.success,updateAddresses: address)
          ],verify: (_)=>verify(mockUpdateAddressUseCase.updateAddress(token, id, request)).called(1));
    },);
    final errorMessage="load to update address";
    blocTest("emits [loading, failure] when UpdateAddAddressEvent failed", build: (){
      when(mockUpdateAddressUseCase.updateAddress(token, id, request)).thenAnswer((_)
      async=>ApiFailedResult(errorMessage));
      return bloc;
    },act: (b)=>b..add(UpdateAddressEvent(id: id,
        token: token, request: request)),expect: ()=>[
      AddressState(updateState: RequestState.loading,
      ),
      AddressState(updateState: RequestState.error,
          UpdateAddressErrorMessage: errorMessage
      )
    ],verify: (_)=>verify(mockUpdateAddressUseCase
        .updateAddress(token, id, request)).called(1));
    group("Get All Addresses", (){
      final successResponse=GetAllAddressResponse(
          message: "success",addresses: [

        Addresses(
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
      final addresses=successResponse.addresses?.map((e)=>e.toEntity()).toList()??[];
      blocTest("emits [loading, success] when GetAddAddressEvent succeeds", build: (){
        when(mockGetAllAddressUseCase.getAllAddress(token)).thenAnswer((_)
        async=>ApiSucessResult(addresses));
        return bloc;
      },act: (b)=>b..add(GetAllddressEvent(token: token)),expect: ()=>[
        AddressState(
          getAddressRequestState: RequestState.loading,

        ),
        AddressState(
            getAddressRequestState: RequestState.success,
            addresses: addresses

        ),
      ],verify: (_)=>verify(mockGetAllAddressUseCase.getAllAddress(token)).called(1));
    });  final errorMsg="Failed to load Addresses";
    blocTest("emits [loading, failure] when GetAddAddressEvent failed", build: (){

      when(mockGetAllAddressUseCase.getAllAddress(token)).thenAnswer((_)async=>
          ApiFailedResult(errorMsg));
      return bloc;
    },act: (b)=>b..add(GetAllddressEvent(token: token)),expect: ()=>[
      AddressState(
          getAddressRequestState: RequestState.loading
      ),
      AddressState(
          getAddressRequestState: RequestState.error,
          getAddressErrorMessage: errorMsg

      ),
    ]);
  });

  final countries=[

    CountryEntity(isoCode: "AF", name: "Afghanistan", phoneCode: "93", flag: "🇦🇫", currency: "AFN",
        latitude: "33.00000000", longitude: "65.00000000", timezones: [
          Timezone(
            zoneName: "Asia\/Kabul",
            gmtOffset: 16200,
            gmtOffsetName: "UTC+04:30",
            abbreviation: "AFT",
            tzName: "Afghanistan Time",
          )
        ])

  ];
  group("GET Countries Event", (){
blocTest<AddressBloc,AddressState>
  ("emits loading and success states when getCountries returns success", build: (){
  when(mockGetCountriesUseCase.getCountries()).thenAnswer((_)async=>
      LocalDsSucessResult(countries));
  return bloc;
},act: (bloc)=>bloc..add(GetCountriesEvent(),),expect: ()=>[
  AddressState(countryRequestState: RequestState.loading),
  AddressState(
    countries: countries,countryRequestState: RequestState.success
  )
],verify: (_){
  verify(mockGetCountriesUseCase.getCountries()).called(1);
});
final countriesError="error in countries";
blocTest<AddressBloc,AddressState>
  ("emits loading and failure states when getCountries returns failed",
    build: (){

    when(mockGetCountriesUseCase.getCountries()).thenAnswer((_)
    async=>LocalDsFailedResult(countriesError));

    return bloc;},
act: (bloc)=>bloc..add(GetCountriesEvent(),),expect: ()=>[
  AddressState(countryRequestState: RequestState.loading),
      AddressState(countryRequestState: RequestState.error,
      countryErrorMessage: countriesError
      ),

    ],verify: (_)=>verify(mockGetCountriesUseCase.getCountries()).called(1)
);
  },);
  final governorates=[
    GovernorateEntity(id: "1", nameEn: "Cairo", nameAr: "القاهرة"),
    GovernorateEntity(id: "2", nameEn: "Giza", nameAr: "الجيزة"),
    GovernorateEntity(id: "3", nameEn: "Alexandria", nameAr: "الأسكندرية"),
    GovernorateEntity(id: "4", nameEn: "Dakahlia", nameAr: "الدقهلية")

  ];
  final governoratesErrorMessage="Error Governorates";
  group("Get Governorates Event", (){
    blocTest<AddressBloc,AddressState>(
        "emits loading and success states when getGovernorates returns success", build: (){
  when(mockGetGovernorateUseCase.getGovernorates()).thenAnswer((_)async=>
      LocalDsSucessResult(governorates));
      return bloc;
    },act: (bloc)=>bloc..add(GetGovernorateEvent()),expect: ()=>[
      AddressState(
        governorateRequestState: RequestState.loading
      ),
      AddressState(
        governorates: governorates,
        governorateRequestState: RequestState.success
      )
    ],verify: (_)=>verify(mockGetGovernorateUseCase.getGovernorates()).called(1));
  blocTest<AddressBloc,AddressState>(
      "emits loading and failure states when getGovernorates returns failed", build: (){
    when(mockGetGovernorateUseCase.getGovernorates()).thenAnswer
      ((_)async=>
        LocalDsFailedResult(governoratesErrorMessage));
    return bloc;
  },act: (bloc)=>bloc.add(GetGovernorateEvent()),expect: ()=>[
    AddressState(
      governorateRequestState: RequestState.loading
    ),
    AddressState(
      governorateRequestState: RequestState.error,
        governateErrorMessage: governoratesErrorMessage
    )
  ],verify: (_)=>verify(mockGetGovernorateUseCase
      .getGovernorates()).called(1));
  });
  String governateId="1";
  final states=[
    StateEntity(cityId: "1", governorateId: "1", cityNameAr: "15 مايو", cityNameEn: "15 May")
  ];
  final statesError="States Error Message";

group("Get States Event", (){
blocTest<AddressBloc,AddressState>
  ("emits loading and success states when getStates returns success",
    build: (){
    when(mockGetStatesUseCase.getStates(governateId)).thenAnswer((_)async
    =>LocalDsSucessResult(states));
  return bloc;
    },act: (bloc)=>bloc..add(GetStatesEvent(governateId: governateId)),
expect: ()=>[
  AddressState(stateRequestState: RequestState.loading),
  AddressState(stateRequestState: RequestState.success,states: states),

],verify: (_)=>verify(mockGetStatesUseCase.getStates(governateId)).called(1));
blocTest("emits loading and failed states when getStates returns success", build: (){
  when(mockGetStatesUseCase.getStates(governateId)).thenAnswer((_)async=>
      LocalDsFailedResult(statesError));
  return bloc;

},act: (bloc)=>bloc..add(GetStatesEvent(governateId: governateId)),expect: ()=>[
  AddressState(stateRequestState: RequestState.loading),
  AddressState(stateRequestState: RequestState.error,stateErrorMessage:
  statesError),
],verify: (_)=>verify(mockGetStatesUseCase.getStates(governateId)).called(1));
});
}
