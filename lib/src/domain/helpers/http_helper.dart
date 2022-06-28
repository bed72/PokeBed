enum HttpResponse {
  ok,
  success,
  notFound,
  forbidden,
  badRequest,
  serverError,
  unauthorized,
}

/// Devolvemos neste caso, a key do arquivo de 'localization'
extension HttpResponseExtension on HttpResponse {
  String get value {
    switch (this) {
      case HttpResponse.notFound:
        return 'httpNotFound';
      case HttpResponse.forbidden:
        return 'httpForbidden';
      case HttpResponse.badRequest:
        return 'httpBadRequest';
      case HttpResponse.serverError:
        return 'httpServerError';
      case HttpResponse.unauthorized:
        return 'httpUnauthorized';
      default:
        return 'httpGeneric';
    }
  }

  int get code {
    switch (this) {
      case HttpResponse.ok:
        return 200;
      case HttpResponse.success:
        return 204;
      case HttpResponse.notFound:
        return 404;
      case HttpResponse.forbidden:
        return 403;
      case HttpResponse.badRequest:
        return 400;
      case HttpResponse.serverError:
        return 500;
      case HttpResponse.unauthorized:
        return 401;
      default:
        return 500;
    }
  }
}

enum HttpMethod {
  get,
  put,
  post,
  patch,
  delete,
}

extension HttpMethodExtension on HttpMethod {
  String get value {
    switch (this) {
      case HttpMethod.get:
        return 'get';
      case HttpMethod.put:
        return 'put';
      case HttpMethod.post:
        return 'post';
      case HttpMethod.patch:
        return 'patch';
      case HttpMethod.delete:
        return 'delete';
      default:
        return 'get';
    }
  }
}
