import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_db_store/dio_cache_interceptor_db_store.dart';
import 'package:path_provider/path_provider.dart';

class CoingeckoClient {
  CoingeckoClient() {
    init();
  }

  late final Dio dio;
  late final CacheOptions options;

  Future<void> init() async {
    dio = Dio();

    final directory = await getTemporaryDirectory();

    options = CacheOptions(
      store: DbCacheStore(databasePath: directory.path),
      policy: CachePolicy.refreshForceCache,
    );

    dio.interceptors.add(
      DioCacheInterceptor(options: options),
    );
  }

  Dio setMaxAge(Duration maxAge) => dio
    ..interceptors
        .insert(0, CacheInterceptor(options: options, maxAge: maxAge));
}

class CacheInterceptor extends Interceptor {
  CacheInterceptor({
    required this.options,
    this.maxAge = const Duration(seconds: 60),
  });

  final CacheOptions options;
  final Duration maxAge;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // ignore: avoid-non-null-assertion, we know its not null
    final store = this.options.store!;

    final key = this.options.keyBuilder(options);

    final cache = await store.get(key);

    if (cache != null &&
        DateTime.now().difference(cache.responseDate).compareTo(maxAge) < 0) {
      return handler.resolve(cache.toResponse(options, fromNetwork: false));
    }

    return handler.next(options);
  }
}
