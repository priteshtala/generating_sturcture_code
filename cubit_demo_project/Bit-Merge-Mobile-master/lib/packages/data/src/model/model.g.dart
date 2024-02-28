// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map json) => Board(
      json['score'] as int,
      json['best'] as int,
      (json['tiles'] as List<dynamic>)
          .map((e) => Tile.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      over: json['over'] as bool? ?? false,
      won: json['won'] as bool? ?? false,
      undo: json['undo'] == null
          ? null
          : Board.fromJson(Map<String, dynamic>.from(json['undo'] as Map)),
    );

Map<String, dynamic> _$BoardToJson(Board instance) => <String, dynamic>{
      'score': instance.score,
      'best': instance.best,
      'tiles': instance.tiles.map((e) => e.toJson()).toList(),
      'over': instance.over,
      'won': instance.won,
      'undo': instance.undo?.toJson(),
    };

Tile _$TileFromJson(Map json) => Tile(
      json['id'] as String,
      json['value'] as int,
      json['index'] as int,
      nextIndex: json['nextIndex'] as int?,
      merged: json['merged'] as bool? ?? false,
    );

Map<String, dynamic> _$TileToJson(Tile instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'index': instance.index,
      'nextIndex': instance.nextIndex,
      'merged': instance.merged,
    };
