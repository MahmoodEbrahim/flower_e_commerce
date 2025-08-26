class BestSellerEntity {
  BestSellerEntity({
    this.rateAvg,
    this.rateCount,
    this.id,
    this.title,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
  });
  double? rateAvg;
  double? rateCount;
  String? id;
  String? title;
  String? description;
  String? imgCover;
  List<String>? images;
  int? price;
  int? priceAfterDiscount;
  int? quantity;
  String? category;
  String? occasion;
}
