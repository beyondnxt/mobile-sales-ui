import 'package:equatable/equatable.dart';

class CompanyInfoEntity extends Equatable {
  const CompanyInfoEntity({
    this.address,
    this.phoneNumber,
    this.name,
  });
  final String? address;
  final int? phoneNumber;
  final String? name;

  @override
  List<Object?> get props => <Object?>[
        address,
        phoneNumber,
        name,
      ];
}
