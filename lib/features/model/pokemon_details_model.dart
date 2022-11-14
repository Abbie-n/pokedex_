import 'package:json_annotation/json_annotation.dart';

part 'pokemon_details_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokemonDetails {
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
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Abilities {
  final Ability? ability;
  final bool? isHidden;
  final int? slot;

  const Abilities({this.ability, this.isHidden, this.slot});

  factory Abilities.fromJson(Map<String, dynamic> json) =>
      _$AbilitiesFromJson(json);

  Map<String, dynamic> toJson() => _$AbilitiesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ability {
  final String? name;
  final String? url;

  const Ability({this.name, this.url});

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Sprites {
  final Other? other;

  const Sprites({this.other});

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);

  Map<String, dynamic> toJson() => _$SpritesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Other {
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
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OfficialArtwork {
  final String? frontDefault;

  const OfficialArtwork({this.frontDefault});

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialArtworkToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Types {
  final int? slot;
  final Ability? type;

  const Types({this.slot, this.type});

  factory Types.fromJson(Map<String, dynamic> json) => _$TypesFromJson(json);

  Map<String, dynamic> toJson() => _$TypesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Stats {
  int? baseStat;
  int? effort;
  Ability? stat;

  Stats({this.baseStat, this.effort, this.stat});

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);

  Map<String, dynamic> toJson() => _$StatsToJson(this);
}
