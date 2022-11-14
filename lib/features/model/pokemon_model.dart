import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokemonModel {
  int? count;
  String? next;
  List<Results>? results;

  PokemonModel({this.count, this.next, this.results});

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Results {
  String? name;
  String? url;

  Results({this.name, this.url});

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
