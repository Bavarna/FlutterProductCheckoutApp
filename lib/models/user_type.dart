enum UserType {
  defaultUser,
  microsoft,
  amazon,
  facebook,
}

extension UserTypeExtension on UserType {
  String get name {
    switch (this) {
      case UserType.defaultUser :
        return 'Default';
      case UserType.amazon:
        return 'Amazon';
      case UserType.facebook:
        return 'Facebook';
      case UserType.microsoft:
        return 'Microsoft';
      default:
        return 'Default';
    }
  }
}

