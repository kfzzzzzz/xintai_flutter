class CivitaiModel {
  // final int? id;
  // final String? name;
  // final String? description;
  // final String? type;
  // final bool? poi;
  // final bool? nsfw;
  // final bool? allowNoCredit;
  // final String? allowCommercialUse;
  // final bool? allowDerivatives;
  // final bool? allowDifferentLicense;
  // final List<String> tags;
  final List<CivitaiModelVersion> modelVersions;

  CivitaiModel({
    // required this.id,
    // required this.name,
    // required this.description,
    // required this.type,
    // required this.poi,
    // required this.nsfw,
    // required this.allowNoCredit,
    // required this.allowCommercialUse,
    // required this.allowDerivatives,
    // required this.allowDifferentLicense,
    // required this.tags,
    required this.modelVersions,
  });

  factory CivitaiModel.fromJson(Map<String, dynamic> json) {
    return CivitaiModel(
      // id: json['id'],
      // name: json['name'],
      // description: json['description'],
      // type: json['type'],
      // poi: json['poi'],
      // nsfw: json['nsfw'],
      // allowNoCredit: json['allowNoCredit'],
      // allowCommercialUse: json['allowCommercialUse'],
      // allowDerivatives: json['allowDerivatives'],
      // allowDifferentLicense: json['allowDifferentLicense'],
      // tags: List<String>.from(json['tags']),
      modelVersions: List<CivitaiModelVersion>.from(
          json['modelVersions'].map((x) => CivitaiModelVersion.fromJson(x))),
    );
  }
}

class CivitaiModelVersion {
  // final int? id;
  // final int? modelId;
  // final String? name;
  // final String? createdAt;
  // final String? updatedAt;
  // final String? status;
  // final String? publishedAt;
  // final String? baseModel;
  // final String? baseModelType;
  // final int? earlyAccessTimeFrame;
  // final String? description;
  final List<CivitaiImageItem> images;

  CivitaiModelVersion({
    // required this.id,
    // required this.modelId,
    // required this.name,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.status,
    // required this.publishedAt,
    // required this.baseModel,
    // required this.baseModelType,
    // required this.earlyAccessTimeFrame,
    // required this.description,
    required this.images,
  });

  factory CivitaiModelVersion.fromJson(Map<String, dynamic> json) {
    return CivitaiModelVersion(
      // id: json['id'],
      // modelId: json['modelId'],
      // name: json['name'],
      // createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
      // status: json['status'],
      // publishedAt: json['publishedAt'],
      // baseModel: json['baseModel'],
      // baseModelType: json['baseModelType'],
      // earlyAccessTimeFrame: json['earlyAccessTimeFrame'],
      // description: json['description'],
      images: List<CivitaiImageItem>.from(
          json['images'].map((x) => CivitaiImageItem.fromJson(x))),
    );
  }
}

class CivitaiImageItem {
  //final int? id;
  final String url;
  //final String? hash;
  final int width;
  final int height;
  //final String? nsfwLevel;
  final String nsfw;
  //final DateTime? createdAt;
  //final int? postId;
  //final Map<String, int> stats;
  //final Map<String, dynamic>? meta; // 可能为null
  //final String? username;

  CivitaiImageItem({
    //required this.id,
    required this.url,
    //required this.hash,
    required this.width,
    required this.height,
    //required this.nsfwLevel,
    required this.nsfw,
    //required this.createdAt,
    //required this.postId,
    //required this.stats,
    //this.meta,
    //this.username,
  });

  factory CivitaiImageItem.fromJson(Map<String, dynamic> json) {
    return CivitaiImageItem(
      //id: json['id'],
      url: json['url'],
      //hash: json['hash'],
      width: json['width'],
      height: json['height'],
      // nsfwLevel: json['nsfwLevel'],
      nsfw: json['nsfw'],
      //createdAt: DateTime.parse(json['createdAt']),
      //postId: json['postId'],
      //stats: Map<String, int>.from(json['stats']),
      //meta: json['meta'],
      //username: json['username'],
    );
  }
}
