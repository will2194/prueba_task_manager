import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prueba_task_manager/fetures/countries/domain/entities/country.dart';

part 'country_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CountryModel extends Country {
  CountryModel({
    required super.code,
    required super.name,
    super.capital,
    required super.emoji,
  });

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  static List<CountryModel> fromJsonList(List<dynamic> list) => list
      .map((dynamic map) => CountryModel.fromJson(map as Map<String, dynamic>))
      .toList();
}
