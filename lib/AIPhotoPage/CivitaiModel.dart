class CivitaiImageItem {
  final int id;
  final String url;
  final String hash;
  final int width;
  final int height;
  final String nsfwLevel;
  final bool nsfw;
  final DateTime createdAt;
  final int postId;
  final Map<String, int> stats;
  final Map<String, dynamic>? meta; // 可能为null
  final String? username;

  CivitaiImageItem({
    required this.id,
    required this.url,
    required this.hash,
    required this.width,
    required this.height,
    required this.nsfwLevel,
    required this.nsfw,
    required this.createdAt,
    required this.postId,
    required this.stats,
    this.meta,
    this.username,
  });

  factory CivitaiImageItem.fromJson(Map<String, dynamic> json) {
    return CivitaiImageItem(
      id: json['id'],
      url: json['url'],
      hash: json['hash'],
      width: json['width'],
      height: json['height'],
      nsfwLevel: json['nsfwLevel'],
      nsfw: json['nsfw'],
      createdAt: DateTime.parse(json['createdAt']),
      postId: json['postId'],
      stats: Map<String, int>.from(json['stats']),
      meta: json['meta'],
      username: json['username'],
    );
  }
}
