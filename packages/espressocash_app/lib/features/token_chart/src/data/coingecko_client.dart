import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/coingecko_client.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

const _maxAge = Duration(hours: 1);

@injectable
@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class ChartCoingeckoClient {
  @factoryMethod
  factory ChartCoingeckoClient(CoingeckoClient client) =>
      _ChartCoingeckoClient(client.setMaxAge(_maxAge));

  @GET('/coins/{id}/market_chart')
  Future<TokenChartResponseDto> getCoinChart(
    @Path() String id,
    @Queries() TokenChartRequestDto request,
  );
}

@freezed
class TokenChartRequestDto with _$TokenChartRequestDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenChartRequestDto({
    @Default('usd') String vsCurrency,
    @Default('1') String days,
    String? interval,
  }) = _TokenChartRequestDto;

  factory TokenChartRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TokenChartRequestDtoFromJson(json);
}

@freezed
class TokenChartResponseDto with _$TokenChartResponseDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenChartResponseDto({
    List<List<num>>? prices,
  }) = _TokenChartResponseDto;

  factory TokenChartResponseDto.fromJson(Map<String, dynamic> data) =>
      _$TokenChartResponseDtoFromJson(data);
}
