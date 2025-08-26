class ProductModel {
    int? rateAvg;
    int? rateCount;
    String? id;
    String? title;
    String? slug;
    String? description;
    String? imgCover;
    List<String>? images;
    int? price;
    int? priceAfterDiscount;
    int? quantity;
    String? category;
    String? occasion;
    bool? isSuperAdmin;
    int? sold;
    String? productModelId;

    ProductModel({
        this.rateAvg,
        this.rateCount,
        this.id,
        this.title,
        this.slug,
        this.description,
        this.imgCover,
        this.images,
        this.price,
        this.priceAfterDiscount,
        this.quantity,
        this.category,
        this.occasion,
        this.isSuperAdmin,
        this.sold,
        this.productModelId,
    });



}
