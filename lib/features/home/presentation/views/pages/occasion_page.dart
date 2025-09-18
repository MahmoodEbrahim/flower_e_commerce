import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/no_products.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasion_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_states.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/occasion_grid.dart';
import 'package:flower_e_commerce/features/home/presentation/views/widgets/occasion_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//end of this
class OccasionPage extends StatefulWidget {
  const OccasionPage({super.key, this.occasions});
  final List<OccasionsEntity>? occasions;
  @override
  State<OccasionPage> createState() => _OccasionPageState();
}

class _OccasionPageState extends State<OccasionPage> {

  int currIndex = 0;

  final ProductsDetialsOccasionBloc occasionBloc =getIt.get<ProductsDetialsOccasionBloc>();
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return BlocProvider.value(
      value: occasionBloc
        ..add(
          GetProductsDetialsByOccasionEvent(
            occassionId: widget.occasions![currIndex].id!,
          ),
        ),
      child: Scaffold(
          backgroundColor: AppColors.white,

          appBar: AppBar(
            backgroundColor: AppColors.white,

            leading:    IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 24.0,
                color: AppColors.black,
              ),
            ),
            title:  Text(
              local!.occasion,
              style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: 20.0),
            ) ,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Column(
                children: [

                  SizedBox(
                    height: 10.0,
                  ),
                  DefaultTabController(
                    length: widget.occasions!.length,
                    child: TabBar(
                        onTap: (index) {
                          currIndex = index;
                          setState(() {});
                        },
                        indicatorColor: AppColors.pink,
                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        indicatorWeight: 2,
                        dividerColor: Colors.transparent,
                        indicatorPadding: EdgeInsets.only(),
                        padding: EdgeInsets.zero,
                        tabs: List.generate(
                            widget.occasions!.length,
                            (index) => OccasionTab(
                                  title: widget.occasions![index].name!,
                                  id: widget.occasions![index].id!,
                                  isSelected: index == currIndex,
                                ))),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  BlocBuilder<ProductsDetialsOccasionBloc, OccasionStates>(
                      builder: (context, state) {
                    switch (state.requestState) {
                      case RequestState.init:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200.0,
                            ),
                            LoadingAnimationWidget.inkDrop(
                                color: AppColors.pink, size: 50)
                          ],
                        );
                      case RequestState.loading:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 230.0,
                            ),
                            LoadingAnimationWidget.inkDrop(
                                color: AppColors.pink, size: 50)
                          ],
                        );

                      case RequestState.success:
                        return state.productsDetials.isNotEmpty
                            ? Expanded(
                                child: OccasionGrid(
                                occasion: state.productsDetials,
                              ))
                            : NoProducts();
                      case RequestState.error:
                        return Center(
                          child: Text(state.errorMessage!),
                        );
                    }
                  })
                ],
              ),
            ),
          )),
    );
  }
}
