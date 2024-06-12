// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moneygram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoneygramDepositRequestDto _$MoneygramDepositRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramDepositRequestDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramDepositRequestDto {
  String get signedTx => throw _privateConstructorUsedError;
  String get account => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramDepositRequestDtoCopyWith<MoneygramDepositRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramDepositRequestDtoCopyWith<$Res> {
  factory $MoneygramDepositRequestDtoCopyWith(MoneygramDepositRequestDto value,
          $Res Function(MoneygramDepositRequestDto) then) =
      _$MoneygramDepositRequestDtoCopyWithImpl<$Res,
          MoneygramDepositRequestDto>;
  @useResult
  $Res call({String signedTx, String account, String amount, String lang});
}

/// @nodoc
class _$MoneygramDepositRequestDtoCopyWithImpl<$Res,
        $Val extends MoneygramDepositRequestDto>
    implements $MoneygramDepositRequestDtoCopyWith<$Res> {
  _$MoneygramDepositRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
    Object? account = null,
    Object? amount = null,
    Object? lang = null,
  }) {
    return _then(_value.copyWith(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramDepositRequestDtoImplCopyWith<$Res>
    implements $MoneygramDepositRequestDtoCopyWith<$Res> {
  factory _$$MoneygramDepositRequestDtoImplCopyWith(
          _$MoneygramDepositRequestDtoImpl value,
          $Res Function(_$MoneygramDepositRequestDtoImpl) then) =
      __$$MoneygramDepositRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedTx, String account, String amount, String lang});
}

/// @nodoc
class __$$MoneygramDepositRequestDtoImplCopyWithImpl<$Res>
    extends _$MoneygramDepositRequestDtoCopyWithImpl<$Res,
        _$MoneygramDepositRequestDtoImpl>
    implements _$$MoneygramDepositRequestDtoImplCopyWith<$Res> {
  __$$MoneygramDepositRequestDtoImplCopyWithImpl(
      _$MoneygramDepositRequestDtoImpl _value,
      $Res Function(_$MoneygramDepositRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
    Object? account = null,
    Object? amount = null,
    Object? lang = null,
  }) {
    return _then(_$MoneygramDepositRequestDtoImpl(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramDepositRequestDtoImpl implements _MoneygramDepositRequestDto {
  const _$MoneygramDepositRequestDtoImpl(
      {required this.signedTx,
      required this.account,
      required this.amount,
      required this.lang});

  factory _$MoneygramDepositRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MoneygramDepositRequestDtoImplFromJson(json);

  @override
  final String signedTx;
  @override
  final String account;
  @override
  final String amount;
  @override
  final String lang;

  @override
  String toString() {
    return 'MoneygramDepositRequestDto(signedTx: $signedTx, account: $account, amount: $amount, lang: $lang)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramDepositRequestDtoImpl &&
            (identical(other.signedTx, signedTx) ||
                other.signedTx == signedTx) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.lang, lang) || other.lang == lang));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedTx, account, amount, lang);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramDepositRequestDtoImplCopyWith<_$MoneygramDepositRequestDtoImpl>
      get copyWith => __$$MoneygramDepositRequestDtoImplCopyWithImpl<
          _$MoneygramDepositRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramDepositRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramDepositRequestDto
    implements MoneygramDepositRequestDto {
  const factory _MoneygramDepositRequestDto(
      {required final String signedTx,
      required final String account,
      required final String amount,
      required final String lang}) = _$MoneygramDepositRequestDtoImpl;

  factory _MoneygramDepositRequestDto.fromJson(Map<String, dynamic> json) =
      _$MoneygramDepositRequestDtoImpl.fromJson;

  @override
  String get signedTx;
  @override
  String get account;
  @override
  String get amount;
  @override
  String get lang;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramDepositRequestDtoImplCopyWith<_$MoneygramDepositRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MoneygramDepositResponseDto _$MoneygramDepositResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramDepositResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramDepositResponseDto {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramDepositResponseDtoCopyWith<MoneygramDepositResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramDepositResponseDtoCopyWith<$Res> {
  factory $MoneygramDepositResponseDtoCopyWith(
          MoneygramDepositResponseDto value,
          $Res Function(MoneygramDepositResponseDto) then) =
      _$MoneygramDepositResponseDtoCopyWithImpl<$Res,
          MoneygramDepositResponseDto>;
  @useResult
  $Res call({String id, String url, String token});
}

/// @nodoc
class _$MoneygramDepositResponseDtoCopyWithImpl<$Res,
        $Val extends MoneygramDepositResponseDto>
    implements $MoneygramDepositResponseDtoCopyWith<$Res> {
  _$MoneygramDepositResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramDepositResponseDtoImplCopyWith<$Res>
    implements $MoneygramDepositResponseDtoCopyWith<$Res> {
  factory _$$MoneygramDepositResponseDtoImplCopyWith(
          _$MoneygramDepositResponseDtoImpl value,
          $Res Function(_$MoneygramDepositResponseDtoImpl) then) =
      __$$MoneygramDepositResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String url, String token});
}

/// @nodoc
class __$$MoneygramDepositResponseDtoImplCopyWithImpl<$Res>
    extends _$MoneygramDepositResponseDtoCopyWithImpl<$Res,
        _$MoneygramDepositResponseDtoImpl>
    implements _$$MoneygramDepositResponseDtoImplCopyWith<$Res> {
  __$$MoneygramDepositResponseDtoImplCopyWithImpl(
      _$MoneygramDepositResponseDtoImpl _value,
      $Res Function(_$MoneygramDepositResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? token = null,
  }) {
    return _then(_$MoneygramDepositResponseDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramDepositResponseDtoImpl
    implements _MoneygramDepositResponseDto {
  const _$MoneygramDepositResponseDtoImpl(
      {required this.id, required this.url, required this.token});

  factory _$MoneygramDepositResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MoneygramDepositResponseDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String url;
  @override
  final String token;

  @override
  String toString() {
    return 'MoneygramDepositResponseDto(id: $id, url: $url, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramDepositResponseDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramDepositResponseDtoImplCopyWith<_$MoneygramDepositResponseDtoImpl>
      get copyWith => __$$MoneygramDepositResponseDtoImplCopyWithImpl<
          _$MoneygramDepositResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramDepositResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramDepositResponseDto
    implements MoneygramDepositResponseDto {
  const factory _MoneygramDepositResponseDto(
      {required final String id,
      required final String url,
      required final String token}) = _$MoneygramDepositResponseDtoImpl;

  factory _MoneygramDepositResponseDto.fromJson(Map<String, dynamic> json) =
      _$MoneygramDepositResponseDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramDepositResponseDtoImplCopyWith<_$MoneygramDepositResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MoneygramChallengeSignRequestDto _$MoneygramChallengeSignRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramChallengeSignRequestDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramChallengeSignRequestDto {
  String get signedTx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramChallengeSignRequestDtoCopyWith<MoneygramChallengeSignRequestDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramChallengeSignRequestDtoCopyWith<$Res> {
  factory $MoneygramChallengeSignRequestDtoCopyWith(
          MoneygramChallengeSignRequestDto value,
          $Res Function(MoneygramChallengeSignRequestDto) then) =
      _$MoneygramChallengeSignRequestDtoCopyWithImpl<$Res,
          MoneygramChallengeSignRequestDto>;
  @useResult
  $Res call({String signedTx});
}

/// @nodoc
class _$MoneygramChallengeSignRequestDtoCopyWithImpl<$Res,
        $Val extends MoneygramChallengeSignRequestDto>
    implements $MoneygramChallengeSignRequestDtoCopyWith<$Res> {
  _$MoneygramChallengeSignRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
  }) {
    return _then(_value.copyWith(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramChallengeSignRequestDtoImplCopyWith<$Res>
    implements $MoneygramChallengeSignRequestDtoCopyWith<$Res> {
  factory _$$MoneygramChallengeSignRequestDtoImplCopyWith(
          _$MoneygramChallengeSignRequestDtoImpl value,
          $Res Function(_$MoneygramChallengeSignRequestDtoImpl) then) =
      __$$MoneygramChallengeSignRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedTx});
}

/// @nodoc
class __$$MoneygramChallengeSignRequestDtoImplCopyWithImpl<$Res>
    extends _$MoneygramChallengeSignRequestDtoCopyWithImpl<$Res,
        _$MoneygramChallengeSignRequestDtoImpl>
    implements _$$MoneygramChallengeSignRequestDtoImplCopyWith<$Res> {
  __$$MoneygramChallengeSignRequestDtoImplCopyWithImpl(
      _$MoneygramChallengeSignRequestDtoImpl _value,
      $Res Function(_$MoneygramChallengeSignRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
  }) {
    return _then(_$MoneygramChallengeSignRequestDtoImpl(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramChallengeSignRequestDtoImpl
    implements _MoneygramChallengeSignRequestDto {
  const _$MoneygramChallengeSignRequestDtoImpl({required this.signedTx});

  factory _$MoneygramChallengeSignRequestDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MoneygramChallengeSignRequestDtoImplFromJson(json);

  @override
  final String signedTx;

  @override
  String toString() {
    return 'MoneygramChallengeSignRequestDto(signedTx: $signedTx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramChallengeSignRequestDtoImpl &&
            (identical(other.signedTx, signedTx) ||
                other.signedTx == signedTx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedTx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramChallengeSignRequestDtoImplCopyWith<
          _$MoneygramChallengeSignRequestDtoImpl>
      get copyWith => __$$MoneygramChallengeSignRequestDtoImplCopyWithImpl<
          _$MoneygramChallengeSignRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramChallengeSignRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramChallengeSignRequestDto
    implements MoneygramChallengeSignRequestDto {
  const factory _MoneygramChallengeSignRequestDto(
          {required final String signedTx}) =
      _$MoneygramChallengeSignRequestDtoImpl;

  factory _MoneygramChallengeSignRequestDto.fromJson(
          Map<String, dynamic> json) =
      _$MoneygramChallengeSignRequestDtoImpl.fromJson;

  @override
  String get signedTx;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramChallengeSignRequestDtoImplCopyWith<
          _$MoneygramChallengeSignRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MoneygramChallengeSignResponseDto _$MoneygramChallengeSignResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramChallengeSignResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramChallengeSignResponseDto {
  String get signedTx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramChallengeSignResponseDtoCopyWith<MoneygramChallengeSignResponseDto>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramChallengeSignResponseDtoCopyWith<$Res> {
  factory $MoneygramChallengeSignResponseDtoCopyWith(
          MoneygramChallengeSignResponseDto value,
          $Res Function(MoneygramChallengeSignResponseDto) then) =
      _$MoneygramChallengeSignResponseDtoCopyWithImpl<$Res,
          MoneygramChallengeSignResponseDto>;
  @useResult
  $Res call({String signedTx});
}

/// @nodoc
class _$MoneygramChallengeSignResponseDtoCopyWithImpl<$Res,
        $Val extends MoneygramChallengeSignResponseDto>
    implements $MoneygramChallengeSignResponseDtoCopyWith<$Res> {
  _$MoneygramChallengeSignResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
  }) {
    return _then(_value.copyWith(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramChallengeSignResponseDtoImplCopyWith<$Res>
    implements $MoneygramChallengeSignResponseDtoCopyWith<$Res> {
  factory _$$MoneygramChallengeSignResponseDtoImplCopyWith(
          _$MoneygramChallengeSignResponseDtoImpl value,
          $Res Function(_$MoneygramChallengeSignResponseDtoImpl) then) =
      __$$MoneygramChallengeSignResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String signedTx});
}

/// @nodoc
class __$$MoneygramChallengeSignResponseDtoImplCopyWithImpl<$Res>
    extends _$MoneygramChallengeSignResponseDtoCopyWithImpl<$Res,
        _$MoneygramChallengeSignResponseDtoImpl>
    implements _$$MoneygramChallengeSignResponseDtoImplCopyWith<$Res> {
  __$$MoneygramChallengeSignResponseDtoImplCopyWithImpl(
      _$MoneygramChallengeSignResponseDtoImpl _value,
      $Res Function(_$MoneygramChallengeSignResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signedTx = null,
  }) {
    return _then(_$MoneygramChallengeSignResponseDtoImpl(
      signedTx: null == signedTx
          ? _value.signedTx
          : signedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramChallengeSignResponseDtoImpl
    implements _MoneygramChallengeSignResponseDto {
  const _$MoneygramChallengeSignResponseDtoImpl({required this.signedTx});

  factory _$MoneygramChallengeSignResponseDtoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$MoneygramChallengeSignResponseDtoImplFromJson(json);

  @override
  final String signedTx;

  @override
  String toString() {
    return 'MoneygramChallengeSignResponseDto(signedTx: $signedTx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramChallengeSignResponseDtoImpl &&
            (identical(other.signedTx, signedTx) ||
                other.signedTx == signedTx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signedTx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramChallengeSignResponseDtoImplCopyWith<
          _$MoneygramChallengeSignResponseDtoImpl>
      get copyWith => __$$MoneygramChallengeSignResponseDtoImplCopyWithImpl<
          _$MoneygramChallengeSignResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramChallengeSignResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramChallengeSignResponseDto
    implements MoneygramChallengeSignResponseDto {
  const factory _MoneygramChallengeSignResponseDto(
          {required final String signedTx}) =
      _$MoneygramChallengeSignResponseDtoImpl;

  factory _MoneygramChallengeSignResponseDto.fromJson(
          Map<String, dynamic> json) =
      _$MoneygramChallengeSignResponseDtoImpl.fromJson;

  @override
  String get signedTx;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramChallengeSignResponseDtoImplCopyWith<
          _$MoneygramChallengeSignResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SwapToStellarRequestDto _$SwapToStellarRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _SwapToStellarRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SwapToStellarRequestDto {
  String get solanaSenderAddress => throw _privateConstructorUsedError;
  String get stellarReceiverAddress => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapToStellarRequestDtoCopyWith<SwapToStellarRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapToStellarRequestDtoCopyWith<$Res> {
  factory $SwapToStellarRequestDtoCopyWith(SwapToStellarRequestDto value,
          $Res Function(SwapToStellarRequestDto) then) =
      _$SwapToStellarRequestDtoCopyWithImpl<$Res, SwapToStellarRequestDto>;
  @useResult
  $Res call(
      {String solanaSenderAddress,
      String stellarReceiverAddress,
      String amount});
}

/// @nodoc
class _$SwapToStellarRequestDtoCopyWithImpl<$Res,
        $Val extends SwapToStellarRequestDto>
    implements $SwapToStellarRequestDtoCopyWith<$Res> {
  _$SwapToStellarRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solanaSenderAddress = null,
    Object? stellarReceiverAddress = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      solanaSenderAddress: null == solanaSenderAddress
          ? _value.solanaSenderAddress
          : solanaSenderAddress // ignore: cast_nullable_to_non_nullable
              as String,
      stellarReceiverAddress: null == stellarReceiverAddress
          ? _value.stellarReceiverAddress
          : stellarReceiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SwapToStellarRequestDtoImplCopyWith<$Res>
    implements $SwapToStellarRequestDtoCopyWith<$Res> {
  factory _$$SwapToStellarRequestDtoImplCopyWith(
          _$SwapToStellarRequestDtoImpl value,
          $Res Function(_$SwapToStellarRequestDtoImpl) then) =
      __$$SwapToStellarRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String solanaSenderAddress,
      String stellarReceiverAddress,
      String amount});
}

/// @nodoc
class __$$SwapToStellarRequestDtoImplCopyWithImpl<$Res>
    extends _$SwapToStellarRequestDtoCopyWithImpl<$Res,
        _$SwapToStellarRequestDtoImpl>
    implements _$$SwapToStellarRequestDtoImplCopyWith<$Res> {
  __$$SwapToStellarRequestDtoImplCopyWithImpl(
      _$SwapToStellarRequestDtoImpl _value,
      $Res Function(_$SwapToStellarRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solanaSenderAddress = null,
    Object? stellarReceiverAddress = null,
    Object? amount = null,
  }) {
    return _then(_$SwapToStellarRequestDtoImpl(
      solanaSenderAddress: null == solanaSenderAddress
          ? _value.solanaSenderAddress
          : solanaSenderAddress // ignore: cast_nullable_to_non_nullable
              as String,
      stellarReceiverAddress: null == stellarReceiverAddress
          ? _value.stellarReceiverAddress
          : stellarReceiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SwapToStellarRequestDtoImpl implements _SwapToStellarRequestDto {
  const _$SwapToStellarRequestDtoImpl(
      {required this.solanaSenderAddress,
      required this.stellarReceiverAddress,
      required this.amount});

  factory _$SwapToStellarRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SwapToStellarRequestDtoImplFromJson(json);

  @override
  final String solanaSenderAddress;
  @override
  final String stellarReceiverAddress;
  @override
  final String amount;

  @override
  String toString() {
    return 'SwapToStellarRequestDto(solanaSenderAddress: $solanaSenderAddress, stellarReceiverAddress: $stellarReceiverAddress, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapToStellarRequestDtoImpl &&
            (identical(other.solanaSenderAddress, solanaSenderAddress) ||
                other.solanaSenderAddress == solanaSenderAddress) &&
            (identical(other.stellarReceiverAddress, stellarReceiverAddress) ||
                other.stellarReceiverAddress == stellarReceiverAddress) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, solanaSenderAddress, stellarReceiverAddress, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapToStellarRequestDtoImplCopyWith<_$SwapToStellarRequestDtoImpl>
      get copyWith => __$$SwapToStellarRequestDtoImplCopyWithImpl<
          _$SwapToStellarRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SwapToStellarRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _SwapToStellarRequestDto implements SwapToStellarRequestDto {
  const factory _SwapToStellarRequestDto(
      {required final String solanaSenderAddress,
      required final String stellarReceiverAddress,
      required final String amount}) = _$SwapToStellarRequestDtoImpl;

  factory _SwapToStellarRequestDto.fromJson(Map<String, dynamic> json) =
      _$SwapToStellarRequestDtoImpl.fromJson;

  @override
  String get solanaSenderAddress;
  @override
  String get stellarReceiverAddress;
  @override
  String get amount;
  @override
  @JsonKey(ignore: true)
  _$$SwapToStellarRequestDtoImplCopyWith<_$SwapToStellarRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SwapToSolanaRequestDto _$SwapToSolanaRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _SwapToSolanaRequestDto.fromJson(json);
}

/// @nodoc
mixin _$SwapToSolanaRequestDto {
  String get stellarSenderAddress => throw _privateConstructorUsedError;
  String get solanaReceiverAddress => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SwapToSolanaRequestDtoCopyWith<SwapToSolanaRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwapToSolanaRequestDtoCopyWith<$Res> {
  factory $SwapToSolanaRequestDtoCopyWith(SwapToSolanaRequestDto value,
          $Res Function(SwapToSolanaRequestDto) then) =
      _$SwapToSolanaRequestDtoCopyWithImpl<$Res, SwapToSolanaRequestDto>;
  @useResult
  $Res call(
      {String stellarSenderAddress,
      String solanaReceiverAddress,
      String amount});
}

/// @nodoc
class _$SwapToSolanaRequestDtoCopyWithImpl<$Res,
        $Val extends SwapToSolanaRequestDto>
    implements $SwapToSolanaRequestDtoCopyWith<$Res> {
  _$SwapToSolanaRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stellarSenderAddress = null,
    Object? solanaReceiverAddress = null,
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      stellarSenderAddress: null == stellarSenderAddress
          ? _value.stellarSenderAddress
          : stellarSenderAddress // ignore: cast_nullable_to_non_nullable
              as String,
      solanaReceiverAddress: null == solanaReceiverAddress
          ? _value.solanaReceiverAddress
          : solanaReceiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SwapToSolanaRequestDtoImplCopyWith<$Res>
    implements $SwapToSolanaRequestDtoCopyWith<$Res> {
  factory _$$SwapToSolanaRequestDtoImplCopyWith(
          _$SwapToSolanaRequestDtoImpl value,
          $Res Function(_$SwapToSolanaRequestDtoImpl) then) =
      __$$SwapToSolanaRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stellarSenderAddress,
      String solanaReceiverAddress,
      String amount});
}

/// @nodoc
class __$$SwapToSolanaRequestDtoImplCopyWithImpl<$Res>
    extends _$SwapToSolanaRequestDtoCopyWithImpl<$Res,
        _$SwapToSolanaRequestDtoImpl>
    implements _$$SwapToSolanaRequestDtoImplCopyWith<$Res> {
  __$$SwapToSolanaRequestDtoImplCopyWithImpl(
      _$SwapToSolanaRequestDtoImpl _value,
      $Res Function(_$SwapToSolanaRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stellarSenderAddress = null,
    Object? solanaReceiverAddress = null,
    Object? amount = null,
  }) {
    return _then(_$SwapToSolanaRequestDtoImpl(
      stellarSenderAddress: null == stellarSenderAddress
          ? _value.stellarSenderAddress
          : stellarSenderAddress // ignore: cast_nullable_to_non_nullable
              as String,
      solanaReceiverAddress: null == solanaReceiverAddress
          ? _value.solanaReceiverAddress
          : solanaReceiverAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SwapToSolanaRequestDtoImpl implements _SwapToSolanaRequestDto {
  const _$SwapToSolanaRequestDtoImpl(
      {required this.stellarSenderAddress,
      required this.solanaReceiverAddress,
      required this.amount});

  factory _$SwapToSolanaRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SwapToSolanaRequestDtoImplFromJson(json);

  @override
  final String stellarSenderAddress;
  @override
  final String solanaReceiverAddress;
  @override
  final String amount;

  @override
  String toString() {
    return 'SwapToSolanaRequestDto(stellarSenderAddress: $stellarSenderAddress, solanaReceiverAddress: $solanaReceiverAddress, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SwapToSolanaRequestDtoImpl &&
            (identical(other.stellarSenderAddress, stellarSenderAddress) ||
                other.stellarSenderAddress == stellarSenderAddress) &&
            (identical(other.solanaReceiverAddress, solanaReceiverAddress) ||
                other.solanaReceiverAddress == solanaReceiverAddress) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, stellarSenderAddress, solanaReceiverAddress, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SwapToSolanaRequestDtoImplCopyWith<_$SwapToSolanaRequestDtoImpl>
      get copyWith => __$$SwapToSolanaRequestDtoImplCopyWithImpl<
          _$SwapToSolanaRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SwapToSolanaRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _SwapToSolanaRequestDto implements SwapToSolanaRequestDto {
  const factory _SwapToSolanaRequestDto(
      {required final String stellarSenderAddress,
      required final String solanaReceiverAddress,
      required final String amount}) = _$SwapToSolanaRequestDtoImpl;

  factory _SwapToSolanaRequestDto.fromJson(Map<String, dynamic> json) =
      _$SwapToSolanaRequestDtoImpl.fromJson;

  @override
  String get stellarSenderAddress;
  @override
  String get solanaReceiverAddress;
  @override
  String get amount;
  @override
  @JsonKey(ignore: true)
  _$$SwapToSolanaRequestDtoImplCopyWith<_$SwapToSolanaRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MoneygramSwapResponseDto _$MoneygramSwapResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramSwapResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramSwapResponseDto {
  String get encodedTx => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramSwapResponseDtoCopyWith<MoneygramSwapResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramSwapResponseDtoCopyWith<$Res> {
  factory $MoneygramSwapResponseDtoCopyWith(MoneygramSwapResponseDto value,
          $Res Function(MoneygramSwapResponseDto) then) =
      _$MoneygramSwapResponseDtoCopyWithImpl<$Res, MoneygramSwapResponseDto>;
  @useResult
  $Res call({String encodedTx});
}

/// @nodoc
class _$MoneygramSwapResponseDtoCopyWithImpl<$Res,
        $Val extends MoneygramSwapResponseDto>
    implements $MoneygramSwapResponseDtoCopyWith<$Res> {
  _$MoneygramSwapResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encodedTx = null,
  }) {
    return _then(_value.copyWith(
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramSwapResponseDtoImplCopyWith<$Res>
    implements $MoneygramSwapResponseDtoCopyWith<$Res> {
  factory _$$MoneygramSwapResponseDtoImplCopyWith(
          _$MoneygramSwapResponseDtoImpl value,
          $Res Function(_$MoneygramSwapResponseDtoImpl) then) =
      __$$MoneygramSwapResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String encodedTx});
}

/// @nodoc
class __$$MoneygramSwapResponseDtoImplCopyWithImpl<$Res>
    extends _$MoneygramSwapResponseDtoCopyWithImpl<$Res,
        _$MoneygramSwapResponseDtoImpl>
    implements _$$MoneygramSwapResponseDtoImplCopyWith<$Res> {
  __$$MoneygramSwapResponseDtoImplCopyWithImpl(
      _$MoneygramSwapResponseDtoImpl _value,
      $Res Function(_$MoneygramSwapResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? encodedTx = null,
  }) {
    return _then(_$MoneygramSwapResponseDtoImpl(
      encodedTx: null == encodedTx
          ? _value.encodedTx
          : encodedTx // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramSwapResponseDtoImpl implements _MoneygramSwapResponseDto {
  const _$MoneygramSwapResponseDtoImpl({required this.encodedTx});

  factory _$MoneygramSwapResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoneygramSwapResponseDtoImplFromJson(json);

  @override
  final String encodedTx;

  @override
  String toString() {
    return 'MoneygramSwapResponseDto(encodedTx: $encodedTx)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramSwapResponseDtoImpl &&
            (identical(other.encodedTx, encodedTx) ||
                other.encodedTx == encodedTx));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, encodedTx);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramSwapResponseDtoImplCopyWith<_$MoneygramSwapResponseDtoImpl>
      get copyWith => __$$MoneygramSwapResponseDtoImplCopyWithImpl<
          _$MoneygramSwapResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramSwapResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramSwapResponseDto implements MoneygramSwapResponseDto {
  const factory _MoneygramSwapResponseDto({required final String encodedTx}) =
      _$MoneygramSwapResponseDtoImpl;

  factory _MoneygramSwapResponseDto.fromJson(Map<String, dynamic> json) =
      _$MoneygramSwapResponseDtoImpl.fromJson;

  @override
  String get encodedTx;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramSwapResponseDtoImplCopyWith<_$MoneygramSwapResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MoneygramFeeRequestDto _$MoneygramFeeRequestDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramFeeRequestDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramFeeRequestDto {
  String get amount => throw _privateConstructorUsedError;
  RampTypeDto get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramFeeRequestDtoCopyWith<MoneygramFeeRequestDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramFeeRequestDtoCopyWith<$Res> {
  factory $MoneygramFeeRequestDtoCopyWith(MoneygramFeeRequestDto value,
          $Res Function(MoneygramFeeRequestDto) then) =
      _$MoneygramFeeRequestDtoCopyWithImpl<$Res, MoneygramFeeRequestDto>;
  @useResult
  $Res call({String amount, RampTypeDto type});
}

/// @nodoc
class _$MoneygramFeeRequestDtoCopyWithImpl<$Res,
        $Val extends MoneygramFeeRequestDto>
    implements $MoneygramFeeRequestDtoCopyWith<$Res> {
  _$MoneygramFeeRequestDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RampTypeDto,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramFeeRequestDtoImplCopyWith<$Res>
    implements $MoneygramFeeRequestDtoCopyWith<$Res> {
  factory _$$MoneygramFeeRequestDtoImplCopyWith(
          _$MoneygramFeeRequestDtoImpl value,
          $Res Function(_$MoneygramFeeRequestDtoImpl) then) =
      __$$MoneygramFeeRequestDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String amount, RampTypeDto type});
}

/// @nodoc
class __$$MoneygramFeeRequestDtoImplCopyWithImpl<$Res>
    extends _$MoneygramFeeRequestDtoCopyWithImpl<$Res,
        _$MoneygramFeeRequestDtoImpl>
    implements _$$MoneygramFeeRequestDtoImplCopyWith<$Res> {
  __$$MoneygramFeeRequestDtoImplCopyWithImpl(
      _$MoneygramFeeRequestDtoImpl _value,
      $Res Function(_$MoneygramFeeRequestDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? type = null,
  }) {
    return _then(_$MoneygramFeeRequestDtoImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RampTypeDto,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramFeeRequestDtoImpl implements _MoneygramFeeRequestDto {
  const _$MoneygramFeeRequestDtoImpl(
      {required this.amount, required this.type});

  factory _$MoneygramFeeRequestDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoneygramFeeRequestDtoImplFromJson(json);

  @override
  final String amount;
  @override
  final RampTypeDto type;

  @override
  String toString() {
    return 'MoneygramFeeRequestDto(amount: $amount, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramFeeRequestDtoImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramFeeRequestDtoImplCopyWith<_$MoneygramFeeRequestDtoImpl>
      get copyWith => __$$MoneygramFeeRequestDtoImplCopyWithImpl<
          _$MoneygramFeeRequestDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramFeeRequestDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramFeeRequestDto implements MoneygramFeeRequestDto {
  const factory _MoneygramFeeRequestDto(
      {required final String amount,
      required final RampTypeDto type}) = _$MoneygramFeeRequestDtoImpl;

  factory _MoneygramFeeRequestDto.fromJson(Map<String, dynamic> json) =
      _$MoneygramFeeRequestDtoImpl.fromJson;

  @override
  String get amount;
  @override
  RampTypeDto get type;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramFeeRequestDtoImplCopyWith<_$MoneygramFeeRequestDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MoneygramFeeResponseDto _$MoneygramFeeResponseDtoFromJson(
    Map<String, dynamic> json) {
  return _MoneygramFeeResponseDto.fromJson(json);
}

/// @nodoc
mixin _$MoneygramFeeResponseDto {
  String get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoneygramFeeResponseDtoCopyWith<MoneygramFeeResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoneygramFeeResponseDtoCopyWith<$Res> {
  factory $MoneygramFeeResponseDtoCopyWith(MoneygramFeeResponseDto value,
          $Res Function(MoneygramFeeResponseDto) then) =
      _$MoneygramFeeResponseDtoCopyWithImpl<$Res, MoneygramFeeResponseDto>;
  @useResult
  $Res call({String amount});
}

/// @nodoc
class _$MoneygramFeeResponseDtoCopyWithImpl<$Res,
        $Val extends MoneygramFeeResponseDto>
    implements $MoneygramFeeResponseDtoCopyWith<$Res> {
  _$MoneygramFeeResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoneygramFeeResponseDtoImplCopyWith<$Res>
    implements $MoneygramFeeResponseDtoCopyWith<$Res> {
  factory _$$MoneygramFeeResponseDtoImplCopyWith(
          _$MoneygramFeeResponseDtoImpl value,
          $Res Function(_$MoneygramFeeResponseDtoImpl) then) =
      __$$MoneygramFeeResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String amount});
}

/// @nodoc
class __$$MoneygramFeeResponseDtoImplCopyWithImpl<$Res>
    extends _$MoneygramFeeResponseDtoCopyWithImpl<$Res,
        _$MoneygramFeeResponseDtoImpl>
    implements _$$MoneygramFeeResponseDtoImplCopyWith<$Res> {
  __$$MoneygramFeeResponseDtoImplCopyWithImpl(
      _$MoneygramFeeResponseDtoImpl _value,
      $Res Function(_$MoneygramFeeResponseDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_$MoneygramFeeResponseDtoImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoneygramFeeResponseDtoImpl implements _MoneygramFeeResponseDto {
  const _$MoneygramFeeResponseDtoImpl({required this.amount});

  factory _$MoneygramFeeResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoneygramFeeResponseDtoImplFromJson(json);

  @override
  final String amount;

  @override
  String toString() {
    return 'MoneygramFeeResponseDto(amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoneygramFeeResponseDtoImpl &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoneygramFeeResponseDtoImplCopyWith<_$MoneygramFeeResponseDtoImpl>
      get copyWith => __$$MoneygramFeeResponseDtoImplCopyWithImpl<
          _$MoneygramFeeResponseDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoneygramFeeResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _MoneygramFeeResponseDto implements MoneygramFeeResponseDto {
  const factory _MoneygramFeeResponseDto({required final String amount}) =
      _$MoneygramFeeResponseDtoImpl;

  factory _MoneygramFeeResponseDto.fromJson(Map<String, dynamic> json) =
      _$MoneygramFeeResponseDtoImpl.fromJson;

  @override
  String get amount;
  @override
  @JsonKey(ignore: true)
  _$$MoneygramFeeResponseDtoImplCopyWith<_$MoneygramFeeResponseDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
