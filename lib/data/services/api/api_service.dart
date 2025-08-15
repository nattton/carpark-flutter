import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/models.dart';
import 'model/login_response/login_response.dart';
import 'model/login_response/user_model.dart';

part 'api_service.g.dart';

@module
abstract class ApiServiceModule {
  @singleton
  ApiService create(Dio dio) => ApiService(dio);
}

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @POST("/api/login")
  Future<LoginResponse> login(
    @Field() String username,
    @Field() String password,
  );

  @GET("/api/admin/users")
  Future<List<UserModel>> getUserList(@Header('Authorization') String token);

  @PATCH("/api/admin/users/{id}")
  Future<ResponseModel> updateUser(
    @Header('Authorization') String token,
    @Path() int id,
    @Body() SaveUserModel user,
  );

  @GET("/api/open_door/{name}")
  Future<void> openDoor(
    @Header('Authorization') String token,
    @Path() String name,
  );

  @GET("/api/manualCapture/{name}")
  Future<void> manualCapture(
    @Header('Authorization') String token,
    @Path() String name,
  );

  // Gate Log
  @GET("/api/gate_logs/last")
  Future<LastGate> getLastGate(@Header('Authorization') String token);

  @GET("/api/gate_logs/in")
  Future<GateInModel> getGateIn(@Header('Authorization') String token);

  @GET("/api/gate_logs/out")
  Future<GateInModel> getGateOut(@Header('Authorization') String token);

  @GET("/api/gate_logs")
  Future<List<GateLogResult>> searchGateLog(
    @Header('Authorization') String token,
    @Query("date") String date,
    @Query("dateTo") String dateTo,
  );

  // Camera
  @GET("/api/cameras")
  Future<List<CameraModel>> getCameraList(
    @Header('Authorization') String token,
  );

  @PATCH("/api/admin/cameras/{id}")
  Future<CameraModel> updateCamera(
    @Header('Authorization') String token,
    @Path() int id,
    @Body() CameraModel camera,
  );

  // Member
  @POST("/api/members")
  Future<MemberModel> createMember(
    @Header('Authorization') String token,
    @Body() MemberModel member,
  );

  @PATCH("/api/members/{id}")
  Future<ResponseModel> updateMember(
    @Header('Authorization') String token,
    @Path() int id,
    @Body() MemberModel member,
  );

  @DELETE("/api/members/{id}")
  Future<ResponseModel> deleteMember(
    @Header('Authorization') String token,
    @Path() int id,
    @Body() MemberModel member,
  );

  @GET("/api/members/{id}")
  Future<MemberModel> getMember(
    @Header('Authorization') String token,
    @Path() int id,
  );

  @GET("/api/members")
  Future<List<MemberModel>> getMemberList(
    @Header('Authorization') String token,
  );

  // Vehicle
  @POST("/api/members/{memberId}/vehicles")
  Future<ResponseModel> createVehicle(
    @Header('Authorization') String token,
    @Path() int memberId,
    @Body() VehicleModel vehicle,
  );

  @PATCH("/api/vehicles/{id}")
  Future<ResponseModel> updateVehicle(
    @Header('Authorization') String token,
    @Path() int id,
    @Body() VehicleModel member,
  );

  @DELETE("/api/vehicles/{id}")
  Future<void> deleteVehicle(
    @Header('Authorization') String token,
    @Path() int id,
  );

  // Visitor
  @POST("/api/visitors")
  Future<VisitorModel> createVisitor(
    @Header('Authorization') String token,
    @Body() VisitorModel visitor,
  );

  @GET("/api/visitors")
  Future<List<VisitorModel>> listVisitor(
    @Header('Authorization') String token,
    @Query("date") String date,
    @Query("dateTo") String dateTo,
  );

  @GET("/api/visitors/{id}")
  Future<VisitorModel> getVisitor(
    @Header('Authorization') String token,
    @Path() int id,
  );

  @POST("/api/visitors/{id}/photo")
  Future<VisitorModel> addPhotoVisitor(
    @Header('Authorization') String token,
    @Path() int id,
    @Part() File photo,
  );

  @POST("/api/visitors/{id}/images/{type}")
  Future<VisitorModel> addImageToVisitor(
    @Header('Authorization') String token,
    @Path() int id,
    @Path() String type,
    @Part() File file,
  );

  @PATCH("/api/visitors/checkout")
  Future<VisitorModel> checkoutVisitor(
    @Header('Authorization') String token,
    @Body() CheckoutModel checkout,
  );

  @GET("/api/report/{type}")
  Future<List<ReportTrafficModel>> reportTraffic(
    @Header('Authorization') String token,
    @Path() String type,
    @Query("date") String date,
    @Query("dateTo") String dateTo,
  );
}
