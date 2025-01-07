import 'package:carpark/core/error/failures.dart';
import 'package:carpark/core/utils/usecases/usecase.dart';
import 'package:carpark/features/registered_user/domain/models/add_photo_registered_user_params.dart';
import 'package:carpark/features/registered_user/domain/models/registered_user_response.dart';
import 'package:carpark/features/registered_user/domain/repositories/registered_user_service_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RegisteredUserAddPhotoUsecase
    extends UseCase<RegisteredUserResponse, AddPhotoRegisteredUserParam> {
  final RegisteredUserServiceRepository repository;

  RegisteredUserAddPhotoUsecase(this.repository);

  @override
  Future<Either<Failure, RegisteredUserResponse>> call(
      AddPhotoRegisteredUserParam params) async {
    final result =
        await repository.addPhotoToRegisteredUser(params.id, params.photo);
    return result.fold((l) => Left(l), (r) => Right(r.data!));
  }
}
