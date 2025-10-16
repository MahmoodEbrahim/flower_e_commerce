
  import 'package:flower_e_commerce/features/home/presentation/views/widgets/no_products.dart';
import 'package:flower_e_commerce/features/home/domain/entity/occasion_entity.dart';
import 'package:flutter/material.dart';

Widget buildOccasionsList(List<OccasionsEntity>? occasions ,) {
    if (occasions == null || occasions.isEmpty) {
      return const NoProducts();
    }
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: occasions.length,
        itemBuilder: (context, index) {
          final occasion = occasions[index];
          return GestureDetector(
            onTap: (){
              // Navigator.of(context).push(MaterialPageRoute(builder:
              //     (context)=>ProductDetailsScreen(
              //     product: Routes.fakeProduct
              // )));
            },
            child:    Container(
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
            ),
          );


        },
      ),
    );
  }

