import 'package:equatable/equatable.dart';

class PaymentMethod extends Equatable {
  final String id;
  final String name;
  final String iconName;
  final String colorHex;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.iconName,
    required this.colorHex,
  });

  PaymentMethod copyWith({
    String? id,
    String? name,
    String? iconName,
    String? colorHex,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  @override
  List<Object?> get props => [id, name, iconName, colorHex];
}
