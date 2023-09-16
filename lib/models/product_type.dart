enum ProductType { small, medium, large }


extension ProductTypeExtension on ProductType {
  String get productName {
    switch (this) {
      case ProductType.small :
        return 'Small Pizza';
      case ProductType.medium:
        return 'Medium Pizza';
      case ProductType.large:
        return 'Large Pizza';
      default:
        return 'Small Pizza';
    }
  }
}