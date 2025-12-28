// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registered_user_service.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main

class _RegisteredUserService implements RegisteredUserService {
  _RegisteredUserService(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<GenericResponseData<List<RegisteredUserResponse>>> getRegisteredUsers(
    String searchText,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'search': searchText};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<GenericResponseData<List<RegisteredUserResponse>>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<List<RegisteredUserResponse>> _value;
    try {
      _value = GenericResponseData<List<RegisteredUserResponse>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<RegisteredUserResponse>(
                    (i) => RegisteredUserResponse.fromJson(
                      i as Map<String, dynamic>,
                    ),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> getRegisteredUser(
    int id,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<GenericResponseData<RegisteredUserResponse>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users/${id}',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<RegisteredUserResponse> _value;
    try {
      _value = GenericResponseData<RegisteredUserResponse>.fromJson(
        _result.data!,
        (json) => RegisteredUserResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> createRegisteredUser(
    CreateRegisteredUserRequest request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _options =
        _setStreamType<GenericResponseData<RegisteredUserResponse>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<RegisteredUserResponse> _value;
    try {
      _value = GenericResponseData<RegisteredUserResponse>.fromJson(
        _result.data!,
        (json) => RegisteredUserResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> addPhotoToRegisteredUser(
    int id,
    File photo,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(
      MapEntry(
        'photo',
        MultipartFile.fromFileSync(
          photo.path,
          filename: photo.path.split(Platform.pathSeparator).last,
        ),
      ),
    );
    final _options =
        _setStreamType<GenericResponseData<RegisteredUserResponse>>(
          Options(method: 'PATCH', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users/${id}/photo',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<RegisteredUserResponse> _value;
    try {
      _value = GenericResponseData<RegisteredUserResponse>.fromJson(
        _result.data!,
        (json) => RegisteredUserResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> updateRegisteredUser(
    int id,
    UpdateRegisteredUserRequest request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _options =
        _setStreamType<GenericResponseData<RegisteredUserResponse>>(
          Options(method: 'PATCH', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users/${id}',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<RegisteredUserResponse> _value;
    try {
      _value = GenericResponseData<RegisteredUserResponse>.fromJson(
        _result.data!,
        (json) => RegisteredUserResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkInRegisteredUser(
    RegisteredUserCheckInRequest request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _options =
        _setStreamType<GenericResponseData<RegisteredUserResponse>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users-logs/check-in',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<RegisteredUserResponse> _value;
    try {
      _value = GenericResponseData<RegisteredUserResponse>.fromJson(
        _result.data!,
        (json) => RegisteredUserResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<RegisteredUserResponse>> checkOutRegisteredUser(
    RegisteredUserCheckOutRequest request,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _options =
        _setStreamType<GenericResponseData<RegisteredUserResponse>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users-logs/check-out',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<RegisteredUserResponse> _value;
    try {
      _value = GenericResponseData<RegisteredUserResponse>.fromJson(
        _result.data!,
        (json) => RegisteredUserResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<RegisteredUserLogsResponse>> getRegisteredUserLogs(
    int id,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<GenericResponseData<RegisteredUserLogsResponse>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users-logs/${id}',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<RegisteredUserLogsResponse> _value;
    try {
      _value = GenericResponseData<RegisteredUserLogsResponse>.fromJson(
        _result.data!,
        (json) =>
            RegisteredUserLogsResponse.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>>
  getNotCheckOutRegisteredUser() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<
          GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>
        >(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/api/registered-users-logs/not-check-out',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GenericResponseData<GetRegisteredUserLogNotCheckOutResponse> _value;
    try {
      _value =
          GenericResponseData<GetRegisteredUserLogNotCheckOutResponse>.fromJson(
            _result.data!,
            (json) => GetRegisteredUserLogNotCheckOutResponse.fromJson(
              json as Map<String, dynamic>,
            ),
          );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
