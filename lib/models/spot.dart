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
        inDateTime: data['inDateTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['inDateTime'])
            : null,
        outDateTime: data['outDateTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['inDateTime'])
            : null ,
        plate: data['plate']
    );
  }

  Map<String, Object?> toRTDBMap() {
    return {
      'id': id,
      'plate': plate,
      'inDateTime': inDateTime?.millisecondsSinceEpoch,
      'outDateTime': outDateTime?.millisecondsSinceEpoch,
    };
  }

  Map<String, Object?> toRemoveRTDBMap() {
    return {
      'id': id,
    };
  }

  String spotAsString() {
    String? plate = this.plate;
    if(plate != null){
      plate = "Ocupada: "+plate;
    }
    return 'Vaga ${this.id} - ${plate ?? "Livre"}';
  }
  ///custom comparing function to check if two users are equal
  bool isEqual(Spot model) {
    return this.id == model.id;
  }

  // @override
  // String toString() => id.toString();
}