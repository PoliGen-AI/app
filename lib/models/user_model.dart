/// Represents a user profile with basic information
class User {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? bio;
  final DateTime? joinDate;
  final int imagesGenerated;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.bio,
    this.joinDate,
    this.imagesGenerated = 0,
  });

  /// Create a mock user for demonstration purposes
  factory User.mock() {
    return User(
      id: 'user-001',
      name: 'João Silva',
      email: 'joao.silva@email.com',
      avatarUrl: null, // Will use default avatar
      bio:
          'Designer apaixonado por IA e arte digital. Sempre explorando novas possibilidades criativas.',
      joinDate: DateTime(2024, 3, 15), // March 15, 2024
      imagesGenerated: 24,
    );
  }

  /// Create a copy of the user with updated fields
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
    DateTime? joinDate,
    int? imagesGenerated,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      joinDate: joinDate ?? this.joinDate,
      imagesGenerated: imagesGenerated ?? this.imagesGenerated,
    );
  }
}
