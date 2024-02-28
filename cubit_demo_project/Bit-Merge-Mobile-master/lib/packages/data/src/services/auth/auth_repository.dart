import 'package:bit_merge_mobile/packages/network/network.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthRepository extends BaseRepository {
  AuthRepository({required super.dio});
}
