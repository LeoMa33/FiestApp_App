Uri? pendingDeepLinkUri;

String? mapDeepLinkToRoute(Uri uri) {
  String path = uri.path;

  if (uri.host == 'invitation') {
    path = '/invitation';
  }

  if (!path.startsWith('/')) {
    path = '/$path';
  }

  final query = uri.hasQuery ? '?${uri.query}' : '';
  final fullPath = '$path$query';

  if (path == '/invitation') {
    return fullPath;
  }

  return null;
}
