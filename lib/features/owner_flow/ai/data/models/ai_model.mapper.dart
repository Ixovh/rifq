// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'ai_model.dart';

class AIModelMapper extends ClassMapperBase<AIModel> {
  AIModelMapper._();

  static AIModelMapper? _instance;
  static AIModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AIModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AIModel';

  static String _$apiKey(AIModel v) => v.apiKey;
  static const Field<AIModel, String> _f$apiKey = Field('apiKey', _$apiKey);
  static String _$model(AIModel v) => v.model;
  static const Field<AIModel, String> _f$model = Field('model', _$model);
  static String _$instructions(AIModel v) => v.instructions;
  static const Field<AIModel, String> _f$instructions = Field(
    'instructions',
    _$instructions,
  );
  static String _$welcomeMessage(AIModel v) => v.welcomeMessage;
  static const Field<AIModel, String> _f$welcomeMessage = Field(
    'welcomeMessage',
    _$welcomeMessage,
  );

  @override
  final MappableFields<AIModel> fields = const {
    #apiKey: _f$apiKey,
    #model: _f$model,
    #instructions: _f$instructions,
    #welcomeMessage: _f$welcomeMessage,
  };

  static AIModel _instantiate(DecodingData data) {
    return AIModel(
      apiKey: data.dec(_f$apiKey),
      model: data.dec(_f$model),
      instructions: data.dec(_f$instructions),
      welcomeMessage: data.dec(_f$welcomeMessage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AIModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AIModel>(map);
  }

  static AIModel fromJson(String json) {
    return ensureInitialized().decodeJson<AIModel>(json);
  }
}

mixin AIModelMappable {
  String toJson() {
    return AIModelMapper.ensureInitialized().encodeJson<AIModel>(
      this as AIModel,
    );
  }

  Map<String, dynamic> toMap() {
    return AIModelMapper.ensureInitialized().encodeMap<AIModel>(
      this as AIModel,
    );
  }

  AIModelCopyWith<AIModel, AIModel, AIModel> get copyWith =>
      _AIModelCopyWithImpl<AIModel, AIModel>(
        this as AIModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AIModelMapper.ensureInitialized().stringifyValue(this as AIModel);
  }

  @override
  bool operator ==(Object other) {
    return AIModelMapper.ensureInitialized().equalsValue(
      this as AIModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AIModelMapper.ensureInitialized().hashValue(this as AIModel);
  }
}

extension AIModelValueCopy<$R, $Out> on ObjectCopyWith<$R, AIModel, $Out> {
  AIModelCopyWith<$R, AIModel, $Out> get $asAIModel =>
      $base.as((v, t, t2) => _AIModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AIModelCopyWith<$R, $In extends AIModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? apiKey,
    String? model,
    String? instructions,
    String? welcomeMessage,
  });
  AIModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AIModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AIModel, $Out>
    implements AIModelCopyWith<$R, AIModel, $Out> {
  _AIModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AIModel> $mapper =
      AIModelMapper.ensureInitialized();
  @override
  $R call({
    String? apiKey,
    String? model,
    String? instructions,
    String? welcomeMessage,
  }) => $apply(
    FieldCopyWithData({
      if (apiKey != null) #apiKey: apiKey,
      if (model != null) #model: model,
      if (instructions != null) #instructions: instructions,
      if (welcomeMessage != null) #welcomeMessage: welcomeMessage,
    }),
  );
  @override
  AIModel $make(CopyWithData data) => AIModel(
    apiKey: data.get(#apiKey, or: $value.apiKey),
    model: data.get(#model, or: $value.model),
    instructions: data.get(#instructions, or: $value.instructions),
    welcomeMessage: data.get(#welcomeMessage, or: $value.welcomeMessage),
  );

  @override
  AIModelCopyWith<$R2, AIModel, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AIModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

