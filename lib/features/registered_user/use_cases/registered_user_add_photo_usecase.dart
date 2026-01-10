import 'package:carpark/shared/repositories/registered_user/registered_user_service_repository.dart';
import 'package:carpark/shared/services/api/model/registered_user/add_photo_registered_user_params.dart';
import 'package:carpark/shared/services/api/model/registered_user/registered_user_response.dart';
import 'package:carpark/shared/utils/failures.dart';
import 'package:carpark/shared/utils/usecase.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserAddPhotoUsecase
    extends UseCase<RegisteredUserResponse, AddPhotoRegisteredUserParam> {
  RegisteredUserAddPhotoUsecase(this.repository);
  final RegisteredUserServiceRepository repository;

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(
    AddPhotoRegisteredUserParam params,
  ) async {
    final result = await repository.addPhotoToRegisteredUser(
      params.id,
      params.photo,
    );
    return result.fold(Left.new, (r) => Right(r.data!));
  }
}
