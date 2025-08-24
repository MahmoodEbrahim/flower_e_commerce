import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/bloc/home_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/bloc/home_events.dart';
import 'package:flower_e_commerce/features/home/presentation/bloc/home_states.dart';

import '../../../data/models/homemodel.dart';


class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<HomeBloc, HomeStates>(
        builder: (context, state) {
          if (state is HomeInitialState) {
            BlocProvider.of<HomeBloc>(context).add(GetHomeDataEvent());
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HomeErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is HomeSuccessState) {
            final homeData = state.homeResponse;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categories Section
                  _buildSectionTitle('Categories', () => {}),
                  _buildCategoriesList(homeData.categories),

                  // Best Seller Section
                  _buildSectionTitle('Best Seller', () => {}),
                  _buildBestSellerList(homeData.bestSeller), // تم التعديل هنا

                  // Products Section (بفرض وجودها في الـ JSON)
                  _buildSectionTitle('Products', () => {}),
                  _buildProductsList(homeData.products),

                  // Occasion Section
                  _buildSectionTitle('Occasion', () => {}),
                  _buildOccasionsList(homeData.occasions),
                ],
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
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: onViewAll,
            child: Text('View All', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(List<Categories>? categories) {
    if (categories == null || categories.isEmpty) {
      return Text("No categories found.");
    }
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(category.image!),
                ),
                SizedBox(height: 8),
                Text(category.name!),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsList(List<Products>? products) {
    if (products == null || products.isEmpty) {
      return Text("No products found.");
    }
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.imgCover!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8),
                Text(product.title!),
                Text('${product.price} EGP'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBestSellerList(List<BestSeller>? bestSellers) {
    if (bestSellers == null || bestSellers.isEmpty) {
      return Text("No best sellers found.");
    }
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bestSellers.length,
        itemBuilder: (context, index) {
          final bestSeller = bestSellers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  bestSeller.imgCover!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8),
                Text(bestSeller.title!),
                Text('${bestSeller.price} EGP'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOccasionsList(List<Occasions>? occasions) {
    if (occasions == null || occasions.isEmpty) {
      return Text("No occasions found.");
    }
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: occasions.length,
        itemBuilder: (context, index) {
          final occasion = occasions[index];
          return Text('Occasion: ${occasion.name}');
        },
      ),
    );
  }
}