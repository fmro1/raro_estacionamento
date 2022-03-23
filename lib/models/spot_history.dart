class SpotHistory{
  SpotHistory({
    this.spotId,
    this.key,
    this.inDateTime,
    this.outDateTime,
    this.plate,
    this.error,
  });

  int? spotId;
  String? key;
  String? plate;
  DateTime? inDateTime;
  DateTime? outDateTime;
  String? error;

  factory SpotHistory.fromRTDB(Map<String, dynamic> data){
    try{
      return SpotHistory(
        spotId: data['spotId'],
        key: data['key'],
        plate: data['plate']?.toString(),
        inDateTime: data['inDatetime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(data['inDatetime']),
        outDateTime: data['outDatetime'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(data['outDatetime']),
      );
    } catch(e){
      return SpotHistory(spotId: 0, error: "Inconsistência nos dados: $e",);
    }
  }

  Map<String, Object?> toRTDBJson() {
    return {
      'spotId': spotId,
      'key': key,
      'plate': plate,
      'inDatetime': inDateTime?.millisecondsSinceEpoch,
      'outDatetime': outDateTime?.millisecondsSinceEpoch,
    };
  }
}