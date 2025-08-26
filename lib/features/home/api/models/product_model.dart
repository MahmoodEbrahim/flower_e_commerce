class ProductModel {
  final double rateAvg;
  final int rateCount;
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final String category;
  final String occasion;
  final String createdAt;
  final String updatedAt;
  final int v;
  final bool isSuperAdmin;
  final int sold;

  ProductModel({
    required this.rateAvg,
    required this.rateCount,
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imgCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isSuperAdmin,
    required this.sold,
  });
}
