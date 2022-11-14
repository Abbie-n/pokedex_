import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_details_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class PokemonDetails extends Equatable {
  final List<Abilities>? abilities;
  final int? baseExperience;
  final int? height;
  final int? id;
  final bool? isDefault;
  final String? locationAreaEncounters;
  final String? name;
  final int? order;
  final Ability? species;
  final Sprites? sprites;
  final List<Stats>? stats;
  final List<Types>? types;
  final int? weight;

  const PokemonDetails({
    this.abilities,
    this.baseExperience,
    this.height,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.name,
    this.order,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailsToJson(this);

  @override
  List<Object?> get props => [
        abilities,
        baseExperience,
        height,
        id,
        isDefault,
        locationAreaEncounters,
        name,
        order,
        species,
        sprites,
        stats,
        types,
        weight,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Abilities extends Equatable {
  final Ability? ability;
  final bool? isHidden;
  final int? slot;

  const Abilities({this.ability, this.isHidden, this.slot});

  factory Abilities.fromJson(Map<String, dynamic> json) =>
      _$AbilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$AbilitiesToJson(this);

  @override
  List<Object?> get props => [ability, isHidden, slot];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ability extends Equatable {
  final String? name;
  final String? url;

  const Ability({this.name, this.url});

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);

  @override
  List<Object?> get props => [name, url];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Sprites extends Equatable {
  final Other? other;

  const Sprites({this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);

  Map<String, dynamic> toJson() => _$SpritesToJson(this);

  @override
  List<Object?> get props => [other];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Other extends Equatable {
  final OfficialArtwork? officialArtwork;

  const Other({this.officialArtwork});

  Map<String, dynamic> toJson() {
    return {
      'official-artwork': officialArtwork?.toJson(),
    };
  }

  factory Other.fromJson(Map<String, dynamic> map) {
    return Other(
      officialArtwork: map['official-artwork'] != null
          ? OfficialArtwork.fromJson(map['official-artwork'])
          : null,
    );
  }

  @override
  List<Object?> get props => [officialArtwork];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OfficialArtwork extends Equatable {
  final String? frontDefault;

  const OfficialArtwork({this.frontDefault});

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialArtworkToJson(this);

  @override
  List<Object?> get props => [frontDefault];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Types extends Equatable {
  final int? slot;
  final Ability? type;

  const Types({this.slot, this.type});

  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);

  Map<String, dynamic> toJson() => _$TypesToJson(this);

  @override
  List<Object?> get props => [slot, type];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Stats extends Equatable {
  final int? baseStat;
  final int? effort;
  final Ability? stat;

  const Stats({this.baseStat, this.effort, this.stat});

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);

  @override
  List<Object?> get props => [baseStat, effort, stat];
}
