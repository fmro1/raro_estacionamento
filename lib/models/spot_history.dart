class SpotHistory{
  SpotHistory({
    this.spotId,
    this.key,
    this.inDateTime,
    this.outDateTime,
    this.plate
  });

  int? spotId;
  String? key;
  String? plate;
  DateTime? inDateTime;
  DateTime? outDateTime;

  factory SpotHistory.fromRTDB(Map<String, dynamic> data){
    return SpotHistory(
      spotId: data['spotId'],
      key: data['key'],
      plate: data['plate']?.toString(),
      inDateTime: data['inDateTime'] == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(data['inDateTime']),
      outDateTime: data['outDateTime'] == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(data['outDateTime']),
    );
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