enum AppRoute {
  splash(name: 'splash', path: '/'),
  home(name: 'home', path: '/home'),
  register(name: 'register', path: '/register'),
  login(name: 'login', path: '/login'),
  profil(name: 'profile', path: '/profile'),
  createprofile(name: 'createprofile', path: '/createprofile'),
  details(name: 'details', path: '/details'),
  invitation(name: 'invitation', path: '/invitation'),
  notification(name: 'notification', path: '/notification'),
  askResetPassword(name: 'askResetPassword', path: '/ask-reset-password'),
  resetPassword(name: 'resetPassword', path: '/reset-password'),
  addEvent(name: 'addEvent', path: '/add-event');

  final String name;
  final String path;

  const AppRoute({required this.name, required this.path});
}
