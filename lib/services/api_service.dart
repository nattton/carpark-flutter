import 'dart:io';

import 'package:carpark/constants.dart';
import 'package:carpark/features/auth/data/models/login_request_model.dart';
import 'package:carpark/features/auth/data/models/user_login_model.dart';
import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:carpark/features/people/data/models/person_model.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:carpark/models/checkout_model.dart';
import 'package:carpark/models/gate_in_model.dart';
import 'package:carpark/models/gate_log_result.dart';
import 'package:carpark/models/id_card_model.dart';
import 'package:carpark/models/last_gate.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/report_traffic_model.dart';
import 'package:carpark/models/response_model.dart';
import 'package:carpark/models/save_user_model.dart';
import 'package:carpark/models/update_person_model.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/api/login")
  Future<UserLoginModel> login(@Body() LoginRequestModel login);

  @GET("/api/admin/users")
  Future<List<UserModel>> getUserList(@Header('authorization') String token);

  @PATCH("/api/admin/users/{id}")
  Future<ResponseModel> updateUser(@Header('authorization') String token,
      @Path() int id, @Body() SaveUserModel user);

  @GET("/api/open_door/{name}")
  Future<void> openDoor(
      @Header('authorization') String token, @Path() String name);

  @GET("/api/manualCapture/{name}")
  Future<void> manualCapture(
      @Header('authorization') String token, @Path() String name);

  // Gate Log
  @GET("/api/gate_logs/last")
  Future<LastGate> getLastGate(@Header('authorization') String token);

  @GET("/api/gate_logs/in")
  Future<GateInModel> getGateIn(@Header('authorization') String token);

  @GET("/api/gate_logs/out")
  Future<GateInModel> getGateOut(@Header('authorization') String token);

  @GET("/api/gate_logs")
  Future<List<GateLogResult>> searchGateLog(
      @Header('authorization') String token,
      @Query("date") String date,
      @Query("dateTo") String dateTo);

  // Camera
  @GET("/api/cameras")
  Future<List<CameraModel>> getCameraList(
      @Header('authorization') String token);

  @PATCH("/api/admin/cameras/{id}")
  Future<CameraModel> updateCamera(@Header('authorization') String token,
      @Path() int id, @Body() CameraModel camera);

  // Member
  @POST("/api/members")
  Future<MemberModel> createMember(
      @Header('authorization') String token, @Body() MemberModel member);

  @PATCH("/api/members/{id}")
  Future<void> updateMember(@Header('authorization') String token,
      @Path() int id, @Body() MemberModel member);

  @DELETE("/api/members/{id}")
  Future<void> deleteMember(@Header('authorization') String token,
      @Path() int id, @Body() MemberModel member);

  @GET("/api/members/{id}")
  Future<MemberModel> getMember(
      @Header('authorization') String token, @Path() int id);

  @GET("/api/members")
  Future<List<MemberModel>> fetchMember(@Header('authorization') String token);

  @GET("/api/export/members")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getExportMembers(@Header('authorization') String token);

  // Vehicle
  @POST("/api/members/{memberId}/vehicles")
  Future<void> createVehicle(@Header('authorization') String token,
      @Path() int memberId, @Body() VehicleModel vehicle);

  @GET("/api/vehicles")
  Future<List<VehicleModel>> fetchVehicle(
    @Header('authorization') String token,
    @Query("offset") int offset,
    @Query("limit") int limit,
    @Query("term") String term,
    @Query("condition") String condition,
    @Query("is_member") String isMember,
  );

  @PATCH("/api/vehicles/{id}")
  Future<void> updateVehicle(@Header('authorization') String token,
      @Path() int id, @Body() VehicleModel member);

  @DELETE("/api/vehicles/{id}")
  Future<void> deleteVehicle(
      @Header('authorization') String token, @Path() int id);

  // Visitor
  @POST("/api/visitors")
  Future<VisitorModel> createVisitor(
      @Header('authorization') String token, @Body() VisitorModel visitor);

  @GET("/api/visitors")
  Future<List<VisitorModel>> listVisitor(@Header('authorization') String token,
      @Query("date") String date, @Query("dateTo") String dateTo);

  @GET("/api/visitors/{id}")
  Future<VisitorModel> getVisitor(
      @Header('authorization') String token, @Path() int id);

  @POST("/api/visitors/{id}/photo")
  Future<VisitorModel> addPhotoVisitor(@Header('authorization') String token,
      @Path() int id, @Part() File photo);

  @POST("/api/visitors/{id}/images/{type}")
  Future<void> addImageToVisitor(@Header('authorization') String token,
      @Path() int id, @Path() String type, @Part() File file);

  @PATCH("/api/visitors/checkout")
  Future<VisitorModel> checkoutVisitor(
      @Header('authorization') String token, @Body() CheckoutModel checkout);

// People
  @GET("/api/people")
  Future<List<PersonModel>> listPeople(
    @Header('authorization') String token,
    @Query("offset") int offset,
    @Query("limit") int limit,
    @Query("term") String term,
    @Query("type") String type,
    @Query("active") String active,
  );

  @GET("/api/people/{id}")
  Future<PersonModel> getPerson(
      @Header('authorization') String token, @Path() String id);

  @PATCH("/api/people/{id}")
  Future<PersonModel> updatePerson(@Header('authorization') String token,
      @Path() String id, @Body() UpdatePersonModel person);

  @GET("/api/report/{type}")
  Future<List<ReportTrafficModel>> reportTraffic(
      @Header('authorization') String token,
      @Path() String type,
      @Query("date") String date,
      @Query("dateTo") String dateTo);

  @GET("$kSmartCardReaderUrl/smartcardreader")
  Future<IDCardModel> smartCardReader();
}
