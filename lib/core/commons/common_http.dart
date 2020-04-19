class HttpCommon {
  static Map<String, String> getHeaders() {
    final Map<String, String> headers = <String, String>{};
    headers['Content-Type'] = 'application/json';
    return headers;
  }

  static Map<String, String> getAuthorizedHeaders(String token) {
    final Map<String, String> headers = getHeaders();
    headers['Authorization'] = '$token';
    return headers;
  }
}
