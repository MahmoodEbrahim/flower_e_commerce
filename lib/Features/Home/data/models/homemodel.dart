// lib/features/home/data/models/homemodel.dart

class Homemodel {
  Homemodel({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,});

  Homemodel.fromJson(dynamic json) {
    message = json['message'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['bestSeller'] != null) {
      bestSeller = [];
      json['bestSeller'].forEach((v) {
        bestSeller?.add(BestSeller.fromJson(v));
      });
    }
    if (json['occasions'] != null) {
      occasions = [];
      json['occasions'].forEach((v) {
        occasions?.add(Occasions.fromJson(v));
      });
    }
  }
  String? message;
  List<Products>? products;
  List<Categories>? categories;
  List<BestSeller>? bestSeller;
  List<Occasions>? occasions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (bestSeller != null) {
      map['bestSeller'] = bestSeller?.map((v) => v.toJson()).toList();
    }
    if (occasions != null) {
      map['occasions'] = occasions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Occasions {
  Occasions({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,});

  Occasions.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isSuperAdmin = json['isSuperAdmin'];
  }
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  bool? isSuperAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['isSuperAdmin'] = isSuperAdmin;
    return map;
  }

}

class BestSeller {
  BestSeller({
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
  });

  BestSeller.fromJson(dynamic json) {
    rateAvg = json['rateAvg'];
    rateCount = json['rateCount'];
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    imgCover = json['imgCover'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    quantity = json['quantity'];
    category = json['category'];
    occasion = json['occasion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    isSuperAdmin = json['isSuperAdmin'];
    sold = json['sold'];
  }
  num? rateAvg; // تم التغيير من int? إلى num?
  num? rateCount; // تم التغيير من int? إلى num?
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price; // تم التغيير من int? إلى num?
  num? priceAfterDiscount; // تم التغيير من int? إلى num?
  int? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? isSuperAdmin;
  int? sold;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rateAvg'] = rateAvg;
    map['rateCount'] = rateCount;
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['imgCover'] = imgCover;
    map['images'] = images;
    map['price'] = price;
    map['priceAfterDiscount'] = priceAfterDiscount;
    map['quantity'] = quantity;
    map['category'] = category;
    map['occasion'] = occasion;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['isSuperAdmin'] = isSuperAdmin;
    map['sold'] = sold;
    map['id'] = id;
    return map;
  }

}

class Categories {
  Categories({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.isSuperAdmin,});

  Categories.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isSuperAdmin = json['isSuperAdmin'];
  }
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  bool? isSuperAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['isSuperAdmin'] = isSuperAdmin;
    return map;
  }

}

class Products {
  Products({
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
  });

  Products.fromJson(dynamic json) {
    rateAvg = json['rateAvg'];
    rateCount = json['rateCount'];
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    imgCover = json['imgCover'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    quantity = json['quantity'];
    category = json['category'];
    occasion = json['occasion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    isSuperAdmin = json['isSuperAdmin'];
    sold = json['sold'];
  }
  num? rateAvg; // تم التغيير من int? إلى num?
  num? rateCount; // تم التغيير من int? إلى num?
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price; // تم التغيير من int? إلى num?
  num? priceAfterDiscount; // تم التغيير من int? إلى num?
  int? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? isSuperAdmin;
  int? sold;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rateAvg'] = rateAvg;
    map['rateCount'] = rateCount;
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['imgCover'] = imgCover;
    map['images'] = images;
    map['price'] = price;
    map['priceAfterDiscount'] = priceAfterDiscount;
    map['quantity'] = quantity;
    map['category'] = category;
    map['occasion'] = occasion;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['isSuperAdmin'] = isSuperAdmin;
    map['sold'] = sold;
    map['id'] = id;
    return map;
  }

}