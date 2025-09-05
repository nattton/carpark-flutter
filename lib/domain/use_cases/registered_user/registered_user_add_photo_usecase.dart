import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/registered_user/registered_user_service_repository.dart';
import '../../../data/services/api/model/registered_user/add_photo_registered_user_params.dart';
import '../../../data/services/api/model/registered_user/registered_user_response.dart';
import '../../../utils/failures.dart';
import '../../../utils/usecase.dart';

@Injectable()
class RegisteredUserAddPhotoUsecase
    extends UseCase<RegisteredUserResponse, AddPhotoRegisteredUserParam> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserAddPhotoUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(
    AddPhotoRegisteredUserParam params,
  ) async {
    final result = await repository.addPhotoToRegisteredUser(
      params.id,
      params.photo,
    );
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
