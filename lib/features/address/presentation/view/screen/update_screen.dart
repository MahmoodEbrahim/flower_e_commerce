import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/core/utils/validator.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';

import 'package:flower_e_commerce/features/address/presentation/view_model/address_bloc.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateAddressDetailsScreen extends StatefulWidget {
  final AddressEntity address;

  const UpdateAddressDetailsScreen({
    super.key,
    required this.address,
  });

  @override
  State<UpdateAddressDetailsScreen> createState() =>
      _UpdateAddressDetailsScreenState();
}

class _UpdateAddressDetailsScreenState extends State<UpdateAddressDetailsScreen> {
  late final TextEditingController phone;
  late final TextEditingController userName;
  var formKey = GlobalKey<FormState>();
  String? selectedCity;
  String? selectedStreet;

  late final addressController ;
  String? selectedAddress;
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String? goverId;
  Set<Marker> markers = {};
String _mapStyle="";
  @override
  void initState() {
    super.initState();
_loadMapStyle();
    phone = TextEditingController(text: widget.address.phone);
    userName = TextEditingController(text: widget.address.username);
    selectedStreet = widget.address.street;
    addressController = TextEditingController(
        text: widget.address.street
    );

    if (widget.address.lat != null && widget.address.long != null) {
      selectedLocation = LatLng(
        double.tryParse(widget.address.lat!) ?? 30.0444,
        double.tryParse(widget.address.long!) ?? 31.2357,
      );
      markers.add(Marker(
        markerId: const MarkerId('selected-location'),
     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        position: selectedLocation!,
      ));
    }

    addressController.addListener(_updateLocation);
  }
  Future<void> _loadMapStyle() async {
    final style = await rootBundle.loadString("assets/json/map_style.json");
    setState(() => _mapStyle = style);
  }
  void _updateLocation() async {
    if (addressController.text.isNotEmpty) {
      await _locateOnMap(addressController.text);
    }
  }

  Future<void> _locateOnMap(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          selectedLocation =
              LatLng(locations.first.latitude, locations.first.longitude);
          markers.clear();
          markers.add(Marker(
            markerId: const MarkerId('selected-location'),
            position: selectedLocation!,
          ));
        });
        if (mapController != null) {
          mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(selectedLocation!, 14.0),
          );
        }
      }
    } catch (e) {
      print("Error locating on map: $e");
    }
  }

  @override
  void dispose() {
    phone.dispose();
    userName.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = UserLocalStorage.getToken();
    return BlocProvider(
      create: (context) =>
      getIt.get<AddressBloc>()
        ..add(GetGovernorateEvent())
        ..add(GetCountriesEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Update Address",
                style: getMediumStyle(color: AppColors.black, fontSize: 20.sp),
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_sharp),
              ),
            ),
            body: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                // تحديد المدينة المحددة مسبقاً
                if (selectedCity == null) {
                  final currentGovernorate = state.governorates.firstWhere(
                        (g) => g.nameEn.toLowerCase() == widget.address.city?.toLowerCase(),
                    orElse: () => GovernorateEntity(id: '', nameAr: '', nameEn: ''),
                  );
                  if (currentGovernorate.id.isNotEmpty) {
                    selectedCity = currentGovernorate.id;
                    goverId = currentGovernorate.id;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.read<AddressBloc>().
                      add(GetStatesEvent(governateId: currentGovernorate.id));
                    });
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.4,

                            child: GoogleMap(
                              style: _mapStyle,
                              onMapCreated: (controller) {
                                mapController = controller;
                                if (selectedLocation != null) {
                                  mapController!.animateCamera(
                                    CameraUpdate.newLatLngZoom(
                                        selectedLocation!, 14.0),
                                  );
                                }
                              },
                              myLocationButtonEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: selectedLocation ??
                                    const LatLng(30.0444, 31.2357), // Cairo
                                zoom: 14.0,
                              ),
                              markers: markers,
                              onTap: (LatLng position) {
                                setState(() {
                                  selectedLocation = position;
                                  markers.clear();
                                  markers.add(
                                    Marker(
                                      markerId:
                                      const MarkerId('selected-location'),
                                      position: position,
                                    ),
                                  );
                                });
                                mapController!.animateCamera(
                                  CameraUpdate.newLatLng(position),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),


                          /// Phone
                          CustomTxtFieldWidget(
                            lbl: "Enter the address",
                            hint: "address",
                            validator: (value){
                              if(value!.isEmpty ||value==null){
                                return "must be not empty";
                              }else{
                                return null;
                              }
                            },
                            controller: addressController,
                          ),
                          SizedBox(height: 16.h),

                          /// Phone
                          CustomTxtFieldWidget(
                            lbl: "Enter the Phone",
                            hint: "Phone number",
                            validator: Validator.validatePhoneNumber,
                            controller: phone,
                          ),
                          SizedBox(height: 16.h),

                          /// Username
                          CustomTxtFieldWidget(
                            lbl: "Enter the recipient name",
                            hint: "Recipient name",
                            validator: Validator.validateUsername,
                            controller: userName,
                          ),
                          SizedBox(height: 16.h),

                          /// City & Street
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  initialValue: selectedCity,
                                  decoration: const InputDecoration(
                                    labelText: "City",
                                    border: OutlineInputBorder(),
                                  ),
                                  items: state.governorates.map((governorate) {
                                    return DropdownMenuItem<String>(
                                      value: governorate.id,
                                      child: Text(
                                        governorate.nameEn,
                                        style: getRegularStyle(
                                            color: AppColors.gray,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList() ??
                                      [],
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedCity = value;
                                        selectedStreet = null;
                                        goverId = value;
                                      });
                                      context
                                          .read<AddressBloc>()
                                          .add(GetStatesEvent(governateId: value));

                                      final selectedGovernorate =
                                      state.governorates.firstWhere(
                                            (g) => g.id == value,
                                        orElse: () => GovernorateEntity(
                                            id: '', nameAr: '', nameEn: ''),
                                      );

                                      if (selectedGovernorate.nameEn.isNotEmpty) {
                                        _locateOnMap(selectedGovernorate.nameEn);
                                      }
                                    }
                                  },
                                  validator: (value) =>
                                  value == null ? 'Please select a city' : null,
                                  isExpanded: true,
                                ),
                              ),
                              SizedBox(width: 16.h),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  validator: (value) => value == null
                                      ? "Please select an Area"
                                      : null,
                                  isExpanded: true,
                                  initialValue: selectedStreet,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Area",
                                  ),
                                  items: state.states.map((val) {
                                    return DropdownMenuItem<String>(
                                      value: val.cityNameEn,
                                      child: Text(
                                        val.cityNameEn,
                                        style: getRegularStyle(
                                            color: AppColors.gray,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList() ??
                                      [],
                                  onChanged: (value) {
                                    if (value != null) {
                                      selectedStreet = value;
                                      setState(() {});
                                      _locateOnMap(value);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),

                          BlocListener<AddressBloc, AddressState>(
                            listener: (context, state) {
                              if (state.updateState == RequestState.success) {
                                Navigator.of(context).pushReplacementNamed(
                                    AppRoutes.saveAddress);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content:
                                Text("Update Address Successfuly")));


                              } else if (state.updateState == RequestState.error) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.getAddressErrorMessage!)));
                              }
                            },
                            child: CustomBtnWidget(
                              txt:
                                   "Update Address",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  final selectedGovernorate =
                                  state.governorates.firstWhere(
                                        (g) => g.id == selectedCity,
                                    orElse: () => GovernorateEntity(
                                        id: '', nameAr: '', nameEn: ''),
                                  );

                                  context.read<AddressBloc>().add(
                                    UpdateAddressEvent(
                                      id: widget.address.id!, //
                                      request: AddAdressRequest(
                                        username: userName.text,
                                        city: selectedGovernorate.nameEn ?? '',
                                        long: selectedLocation?.longitude
                                            .toString() ??
                                            "",
                                        lat: selectedLocation?.latitude
                                            .toString() ??
                                            "",
                                        phone: phone.text,
                                        street: selectedStreet ?? "",
                                      ),
                                      token: token!,
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}