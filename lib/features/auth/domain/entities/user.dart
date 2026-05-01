class User {
  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.avatarUrl = '',
    this.isEmailVerified = false,
    this.isPro = false,
  });
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final bool? isEmailVerified;
  final bool? isPro;
}
