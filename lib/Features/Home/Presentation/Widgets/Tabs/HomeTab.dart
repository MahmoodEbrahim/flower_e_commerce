import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

import '../../view_model/bloc/home_bloc.dart';
import '../../view_model/bloc/home_events.dart';
import '../../view_model/bloc/home_states.dart';


class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HomeBloc, HomeStates>(
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
                                prefixIcon: Icon(Icons.search, color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,size: 24,),
                        const SizedBox(width: 6),
                        Text("Deliver to 2XVP+XC - Sheikh Zayed ",style: TextStyle(
                          fontSize: 18
                        ),),
                        Icon(Icons.keyboard_arrow_down_outlined,size: 24,color: Colors.pink,),

                      ],
                    ),
                    _buildSectionTitle('Categories', () {
                      final categories = homeData.categories;
                      print("Categories Data: $categories");
                    }),
                    _buildCategoriesList(homeData.categories),
                    _buildSectionTitle('Best Seller', () {
                      final bestseller =homeData.bestSeller;
                      print("bestseller Data: $bestseller");
                    }),
                    _buildBestSellerList(homeData.bestSeller),
                    _buildSectionTitle('Occasion', () {
                      final occasion =homeData.occasions;
                      print("occasions Data: $occasion");
                    }),
                    _buildOccasionsList(homeData.occasions),
                    _buildSectionTitle('Products', () {
                      final Products =homeData.products;
                      print("products Data: $Products");
                    }),
                    _buildProductsList(homeData.products),

                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: onViewAll,
            child: const Text('View All', style: TextStyle(color: Colors.pink,
            decoration: TextDecoration.underline,
              decorationColor: Colors.pink
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(List<Categories>? categories) {
    if (categories == null || categories.isEmpty) {
      return const Text("No categories found.");
    }
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xffF9ECF0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(24),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xffF9ECF0),
                        backgroundImage: NetworkImage(category.image!),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                category.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductsList(List<Products>? products) {
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
          return Container(
            width: 160,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    product.imgCover!,
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
                      Text(product.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal
                          )),
                      Text('${product.price} EGP',
                          style: const TextStyle(
                              color: Colors.
                              black,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBestSellerList(List<BestSeller>? bestSellers) {
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
          return Container(
            width: 140,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    bestSeller.imgCover!,
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
                      Text(bestSeller.title!,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal
                          )),
                      Text('${bestSeller.price} EGP',
                          style: const TextStyle(
                              color: Colors.
                              black,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOccasionsList(List<Occasions>? occasions) {
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
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: Image.network(
                    occasion.image!,
                    width: 140,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 6,),
                Text(
                  occasion.name ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
