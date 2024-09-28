import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject with EquatableMixin {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? gender;

  @HiveField(3)
  String? phoneNumber;

  User({
    required this.id,
    this.name,
    this.gender,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [phoneNumber, id, name, gender];
}
