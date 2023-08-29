class SensorVal {
  final num ammonia;
  final num chlorine;
  final num hardness;
  final num phosphates;
  final num dissO2;
  final num co2;
  final num nitrate;
  final num nitrite;
  final num pH;
  final num temp;
  final DateTime timeStamp;
  SensorVal({
    required this.ammonia,
    required this.chlorine,
    required this.hardness,
    required this.phosphates,
    required this.dissO2,
    required this.co2,
    required this.nitrate,
    required this.nitrite,
    required this.pH,
    required this.temp,
    required this.timeStamp,
  });

  SensorVal copyWith({
    num? ammonia,
    num? chlorine,
    num? hardness,
    num? phosphates,
    num? dissO2,
    num? co2,
    num? nitrate,
    num? nitrite,
    num? pH,
    num? temp,
    DateTime? timeStamp,
  }) {
    return SensorVal(
      ammonia: ammonia ?? this.ammonia,
      chlorine: chlorine ?? this.chlorine,
      hardness: hardness ?? this.hardness,
      phosphates: phosphates ?? this.phosphates,
      dissO2: dissO2 ?? this.dissO2,
      co2: co2 ?? this.co2,
      nitrate: nitrate ?? this.nitrate,
      nitrite: nitrite ?? this.nitrite,
      pH: pH ?? this.pH,
      temp: temp ?? this.temp,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ammonia': ammonia,
      'chlorine': chlorine,
      'hardness': hardness,
      'phosphates': phosphates,
      'dissO2': dissO2,
      'co2': co2,
      'nitrate': nitrate,
      'nitrite': nitrite,
      'pH': pH,
      'temp': temp,
    };
  }

  factory SensorVal.fromMap(Map<dynamic, dynamic> map) {
    return SensorVal(
      ammonia: map['ammonia'] as num,
      chlorine: map['chlorine'] as num,
      hardness: map['hardness'] as num,
      phosphates: map['phosphates'] as num,
      dissO2: map['dissO2'] as num,
      co2: map['co2'] as num,
      nitrate: map['nitrate'] as num,
      nitrite: map['nitrite'] as num,
      pH: map['pH'] as num,
      temp: map['temp'] as num,
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp'] as int),
    );
  }

  @override
  String toString() {
    return 'SensorVal(ammonia: $ammonia, chlorine: $chlorine, hardness: $hardness, phosphates: $phosphates, dissO2: $dissO2, co2: $co2, nitrate: $nitrate, nitrite: $nitrite, pH: $pH, temp: $temp, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(covariant SensorVal other) {
    if (identical(this, other)) return true;

    return other.ammonia == ammonia &&
        other.chlorine == chlorine &&
        other.hardness == hardness &&
        other.phosphates == phosphates &&
        other.dissO2 == dissO2 &&
        other.co2 == co2 &&
        other.nitrate == nitrate &&
        other.nitrite == nitrite &&
        other.pH == pH &&
        other.temp == temp &&
        other.timeStamp == timeStamp;
  }

  @override
  int get hashCode {
    return ammonia.hashCode ^
        chlorine.hashCode ^
        hardness.hashCode ^
        phosphates.hashCode ^
        dissO2.hashCode ^
        co2.hashCode ^
        nitrate.hashCode ^
        nitrite.hashCode ^
        pH.hashCode ^
        temp.hashCode ^
        timeStamp.hashCode;
  }
}
