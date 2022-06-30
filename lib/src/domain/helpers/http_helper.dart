enum HttpResponse {
  ok(value: ''),
  success(value: ''),
  notFound(value: 'httpNotFound'),
  forbidden(value: 'httpForbidden'),
  badRequest(value: 'httpBadRequest'),
  serverError(value: 'httpServerError'),
  unauthorized(value: 'httpUnauthorized');

  final String value;

  const HttpResponse({required this.value});

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
  get(value: 'get'),
  put(value: 'put'),
  post(value: 'post'),
  patch(value: 'patch'),
  delete(value: 'delete');

  final String value;

  const HttpMethod({required this.value});
}
