import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/models.dart';
import 'model/login_response/login_response.dart';
import 'model/login_response/user_model.dart';
import 'model/member/member.dart';
import 'model/vehicle/vehicle.dart';

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
  Future<List<UserModel>> getUserList();

  @PATCH("/api/admin/users/{id}")
  Future<ResponseModel> updateUser(@Path() int id, @Body() SaveUserModel user);

  @GET("/api/open_door/{name}")
  Future<void> openDoor(@Path() String name);

  @GET("/api/manualCapture/{name}")
  Future<void> manualCapture(@Path() String name);

  // Gate Log
  @GET("/api/gate_logs/last")
  Future<LastGate> getLastGate();

  @GET("/api/gate_logs/in")
  Future<GateInModel> getGateIn();

  @GET("/api/gate_logs/out")
  Future<GateInModel> getGateOut();

  @GET("/api/gate_logs")
  Future<List<GateLogResult>> searchGateLog(
    @Query("date") String date,
    @Query("dateTo") String dateTo,
  );

  // Camera
  @GET("/api/cameras")
  Future<List<CameraModel>> getCameraList();

  @PATCH("/api/admin/cameras/{id}")
  Future<CameraModel> updateCamera(@Path() int id, @Body() CameraModel camera);

  // Member
  @POST("/api/members")
  Future<MemberModel> createMember(@Body() CreateMemberRequest member);

  @PATCH("/api/members/{id}")
  Future<ResponseModel> updateMember(
    @Path() int id,
    @Body() UpdateMemberRequest member,
  );

  @DELETE("/api/members/{id}")
  Future<ResponseModel> deleteMember(@Path() int id);

  @GET("/api/members/{id}")
  Future<MemberModel> getMember(@Path() int id);

  @GET("/api/members")
  Future<List<MemberModel>> getMemberList();

  // Vehicle
  @POST("/api/members/{memberId}/vehicles")
  Future<ResponseModel> createVehicle(
    @Path() int memberId,
    @Body() CreateVehicleRequest vehicle,
  );

  @PATCH("/api/vehicles/{id}")
  Future<ResponseModel> updateVehicle(
    @Path() int id,
    @Body() UpdateVehicleRequest vehicle,
  );

  @DELETE("/api/vehicles/{id}")
  Future<void> deleteVehicle(@Path() int id);

  // Visitor
  @POST("/api/visitors")
  Future<VisitorModel> createVisitor(@Body() VisitorModel visitor);

  @GET("/api/visitors")
  Future<List<VisitorModel>> listVisitor(
    @Query("date") String date,
    @Query("dateTo") String dateTo,
  );

  @GET("/api/visitors/{id}")
  Future<VisitorModel> getVisitor(@Path() int id);

  @POST("/api/visitors/{id}/photo")
  Future<VisitorModel> addPhotoVisitor(@Path() int id, @Part() File photo);

  @POST("/api/visitors/{id}/images/{type}")
  Future<VisitorModel> addImageToVisitor(
    @Path() int id,
    @Path() String type,
    @Part() File file,
  );

  @PATCH("/api/visitors/checkout")
  Future<VisitorModel> checkoutVisitor(@Body() CheckoutModel checkout);

  @GET("/api/report/{type}")
  Future<List<ReportTrafficModel>> reportTraffic(
    @Path() String type,
    @Query("date") String date,
    @Query("dateTo") String dateTo,
  );
}
