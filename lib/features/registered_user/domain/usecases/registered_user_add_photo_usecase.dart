import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../models/add_photo_registered_user_params.dart';
import '../models/registered_user_response.dart';
import '../repositories/registered_user_service_repository.dart';

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
