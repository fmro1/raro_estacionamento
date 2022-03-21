class Spot {
  Spot({
    required this.id,
    this.key,
    this.inDateTime,
    this.outDateTime,
    this.plate
  });
  int id;
  String? plate;
  String? key;
  DateTime? inDateTime;
  DateTime? outDateTime;

  factory Spot.fromRTDB(Map<String, dynamic> data){
    return Spot(
        id: data['id'] ?? -1,
        inDateTime: data['inDateTime'] ?? DateTime(2000),
        outDateTime: data['outDateTime'] ?? DateTime(2000),
        plate: data['plate']
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'plate': plate,
      'inDateTime': inDateTime,
      'outDateTime': outDateTime,
    };
  }
}