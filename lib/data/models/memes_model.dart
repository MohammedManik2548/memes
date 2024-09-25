class Meme {
  final String? id;
  final String? name;
  final String? url;
  final int? width;
  final int? height;

  Meme(
      {this.id,
      this.name,
      this.url,
      this.width,
      this.height});

  factory Meme.fromJson(Map<String, dynamic> json) {
    return Meme(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
