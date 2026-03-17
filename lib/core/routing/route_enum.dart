enum AppRoute {
  home(name: 'home', path: '/'),
  register(name: 'register', path: '/register'),
  profil(name: 'profile', path: '/profile'),
  details(name: 'details', path: '/details'),
  invitation(name: 'invitation', path: '/invitation'),
  notification(name: 'notification', path: '/notification'),
  addEvent(name: 'addEvent', path: '/add-event');

  final String name;
  final String path;

  const AppRoute({required this.name, required this.path});
}
