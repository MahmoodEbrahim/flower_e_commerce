class ProductEntity {
    String id;
    String title;
    String slug;
    String description;
    String imgCover;
    List<String> images;
    int price;
    int? priceAfterDiscount;
    int quantity;
    String category;
    String occasion;
  

    ProductEntity({
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
       
    });

  


}
