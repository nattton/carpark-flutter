// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_gate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastGate _$LastGateFromJson(Map<String, dynamic> json) => LastGate(
  gateIn: GateLogModel.fromJson(json['gateIn'] as Map<String, dynamic>),
  gateOut: GateLogModel.fromJson(json['gateOut'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LastGateToJson(LastGate instance) => <String, dynamic>{
  'gateIn': instance.gateIn,
  'gateOut': instance.gateOut,
};
