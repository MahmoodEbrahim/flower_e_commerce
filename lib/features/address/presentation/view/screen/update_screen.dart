import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/core/utils/validator.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_bloc.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_btn_widget.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custom_txt_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateAddressScreen extends StatefulWidget {
  final AddressEntity address;

  const UpdateAddressScreen({super.key, required this.address});

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final phone = TextEditingController();
  final userName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? selectedCity;
  String? selectedStreet;

  GoogleMapController? mapController;
  LatLng? selectedLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    phone.text = widget.address.phone ?? '';
    userName.text = widget.address.username ?? '';
    selectedCity = widget.address.city;
    selectedStreet = widget.address.street;
    selectedLocation = LatLng(
      double.tryParse(widget.address.lat ?? '') ?? 30.0444,
      double.tryParse(widget.address.long ?? '') ?? 31.2357,
    );

    markers.add(Marker(
      markerId: const MarkerId('selected-location'),
      position: selectedLocation!,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
    ));
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
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
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
  Widget build(BuildContext context) {
    final token = UserLocalStorage.getToken();
    return BlocProvider(
      create: (context) => getIt.get<AddressBloc>()
        ..add(GetGovernorateEvent())
        ..add(GetCountriesEvent())..add(GetStatesEvent(governateId: selectedCity!)),
      child: Scaffold(
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
                        height: 200.h,
                        child: GoogleMap(
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
                            target: selectedLocation ?? const LatLng(30.0444, 31.2357),
                            zoom: 14.0,
                          ),
                          markers: markers,
                          onTap: (LatLng position) {
                            setState(() {
                              selectedLocation = position;
                              markers.clear();
                              markers.add(Marker(
                                markerId: const MarkerId('selected-location'),
                                position: position,
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueRose),
                              ));
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

                      /// City & Area
                      /// City & Area
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedCity,
                              decoration: const InputDecoration(
                                labelText: "City",
                                border: OutlineInputBorder(),
                              ),
                              items: (state.governorates ?? [])
                                  .map((governorate) {
                                return DropdownMenuItem<String>(
                                  value: governorate.nameEn,
                                  child: Text(
                                    governorate.nameEn,
                                    style: getRegularStyle(
                                        color: AppColors.gray,
                                        fontSize: 14.sp),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                if (value != null) {
                                  setState(() {
                                    selectedCity = value;
                                    selectedStreet = null; // Reset area when city changes
                                  });
                                  _locateOnMap(value);
                                  context
                                      .read<AddressBloc>()
                                      .add(GetStatesEvent(governateId: value));

                                }
                              },
                              validator: (value) =>
                              value == null ? 'Please select a city' : null,
                              isExpanded: true,
                            ),
                          ),
                          SizedBox(width: 16.h),
                          Expanded(
                            child: BlocBuilder<AddressBloc, AddressState>(
                              builder: (context, state) {
                                // Ensure selectedStreet is valid (exists in state.states)
                                final validSelectedStreet = (state.states ?? [])
                                    .any((val) => val.cityNameEn == selectedStreet)
                                    ? selectedStreet
                                    : null;

                                return DropdownButtonFormField<String>(
                                  validator: (value) =>
                                  value == null ? "Please select an Area" : null,
                                  isExpanded: true,
                                  value: validSelectedStreet,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Area",
                                  ),
                                  items: (state.states ?? []).map((val) {
                                    return DropdownMenuItem<String>(
                                      value: val.cityNameEn,
                                      child: Text(
                                        val.cityNameEn,
                                        style: getRegularStyle(
                                            color: AppColors.gray,
                                            fontSize: 14.sp),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedStreet = value;
                                      });
                                      _locateOnMap(value);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      /// Update Button
                      BlocListener<AddressBloc, AddressState>(
                        listener: (context, state) {
                          if (state.updateState == RequestState.success) {
                            Navigator.of(context).pushReplacementNamed(
                                AppRoutes.saveAddress);
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message: "Location updated successfully",
                                backgroundColor: AppColors.pink,
                                textStyle: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          } else if (state.updateState ==
                              RequestState.error) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: state.UpdateAddressErrorMessage ??
                                    "Update failed",
                              ),
                            );
                          }
                        },
                        child: CustomBtnWidget(
                          txt: "Update Address",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AddressBloc>().add(
                                UpdateAddressEvent(
                                  token: token!,
                                  id: widget.address.id!,
                                  request: AddAdressRequest(
                                    username: userName.text,
                                    city: selectedCity ?? "",
                                    long: selectedLocation?.longitude
                                        .toString() ??
                                        "",
                                    lat: selectedLocation?.latitude
                                        .toString() ??
                                        "",
                                    phone: phone.text,
                                    street: selectedStreet ?? "",
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
