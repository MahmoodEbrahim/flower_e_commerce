import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/features/home/domain/entity/bestseller_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/categories_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasions_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/home_view_model/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/di/di.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeStates>(
          builder: (context, state) {
            if (state is HomeInitialState) {
              BlocProvider.of<HomeBloc>(context).add(GetHomeDataEvent());
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is HomeSuccessState) {
              final homeData = state.homeResponse;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Text(
                              "🌸 Flowery",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                                fontFamily: "IMFellEnglish",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Location
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 24),
                          const SizedBox(width: 6),
                          const Text(
                            "Deliver to 2XVP+XC - Sheikh Zayed ",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Icon(Icons.keyboard_arrow_down_outlined,
                              size: 24, color: Colors.pink),
                        ],
                      ),

                      // Categories
                      _buildSectionTitle('Categories', () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.categories,
                          arguments: homeData.categories,
                        );
                      }),
                      _buildCategoriesList(homeData.categories),

                      // Best Seller
                      _buildSectionTitle('Best Seller', () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.bestSellers,
                          arguments: homeData.bestSeller,
                        );
                      }),
                      _buildBestSellerList(homeData.bestSeller),

                      // Occasions
                      _buildSectionTitle('Occasions', () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.occasions,
                          arguments: homeData.occasions,
                        );
                      }),
                      _buildOccasionsList(homeData.occasions),

                      // Products
                      _buildSectionTitle('Products', () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.categories,
                          arguments: homeData.products,
                        );
                      }),
                      _buildProductsList(homeData.products),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: onSeeAll,
            child: const Text("See all",
                style: TextStyle(color: Colors.pink, fontSize: 15)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(List<CategoriesEntity>? categories) {
    if (categories == null || categories.isEmpty) {
      return const Text("No categories found.");
    }
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(category.image ?? ''),
                ),
                const SizedBox(height: 6),
                Text(category.name ?? '',
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsList(List<ProductsEntity>? products) {
    if (products == null || products.isEmpty) {
      return const Text("No products found.");
    }
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.productDetails,
                arguments: product,
              );
            },
            child: Container(
              width: 160,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Image.network(
                      product.imgCover ?? '',
                      width: 160,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal)),
                        Text('${product.price ?? 0} EGP',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBestSellerList(List<BestSellerEntity>? bestSellers) {
    if (bestSellers == null || bestSellers.isEmpty) {
      return const Text("No best sellers found.");
    }
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bestSellers.length,
        itemBuilder: (context, index) {
          final bestSeller = bestSellers[index];
          return GestureDetector(onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.productDetails,
              arguments: bestSeller,
            );
          },
             child:  Container(
                width: 140,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        bestSeller.imgCover ?? '',
                        width: 140,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(bestSeller.title ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          Text('${bestSeller.price ?? 0} EGP',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  Widget _buildOccasionsList(List<OccasionsEntity>? occasions) {
    if (occasions == null || occasions.isEmpty) {
      return const Text("No occasions found.");
    }
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: occasions.length,
        itemBuilder: (context, index) {
          final occasion = occasions[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    occasion.image ?? '',
                    width: 140,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6),
                Text(occasion.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          );
        },
      ),
    );
  }
}
