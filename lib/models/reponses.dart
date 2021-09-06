class Reponse {
  final String? id;
  final String? reponse;
  final num? value;

  const Reponse({
    this.id,
    this.reponse,
    this.value,
  });

  factory Reponse.fromJson(Map<String, dynamic> json) {
    return Reponse(
      id: json["_id"] as String?,
      reponse: json['reponse'] as String?,
      value: json['value'] as num?,
    );
  }
}
