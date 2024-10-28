import 'dart:io';

import 'package:carpark/constants.dart';
import 'package:carpark/features/auth/data/models/login_request_model.dart';
import 'package:carpark/features/auth/data/models/user_login_model.dart';
import 'package:carpark/features/auth/data/models/user_model.dart';
import 'package:carpark/features/people/data/models/person_model.dart';
import 'package:carpark/features/user/data/models/save_user_model.dart';
import 'package:carpark/models/camera_model.dart';
import 'package:carpark/models/checkout_model.dart';
import 'package:carpark/models/gate_in_model.dart';
import 'package:carpark/models/gate_log_result.dart';
import 'package:carpark/models/id_card_model.dart';
import 'package:carpark/models/last_gate.dart';
import 'package:carpark/models/member_model.dart';
import 'package:carpark/models/report_traffic_model.dart';
import 'package:carpark/models/update_person_model.dart';
import 'package:carpark/models/vehicle_model.dart';
import 'package:carpark/models/visitor_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: kHostUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("/api/login")
  Future<UserLoginModel> login(@Body() LoginRequestModel login);

  @GET("/api/admin/users")
  Future<List<UserModel>> getUserList(@Header('Authorization') String token);

  @PATCH("/api/admin/users/{id}")
  Future<UserModel> updateUser(@Header('Authorization') String token,
      @Path() int id, @Body() SaveUserModel user);

  @GET("/api/open_door/{name}")
  Future<void> openDoor(
      @Header('Authorization') String token, @Path() String name);

  @GET("/api/manualCapture/{name}")
  Future<void> manualCapture(
      @Header('Authorization') String token, @Path() String name);

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
      @Query("dateTo") String dateTo);

  // Camera
  @GET("/api/cameras")
  Future<List<CameraModel>> getCameraList(
      @Header('Authorization') String token);

  @PATCH("/api/admin/cameras/{id}")
  Future<CameraModel> updateCamera(@Header('Authorization') String token,
      @Path() int id, @Body() CameraModel camera);

  // Member
  @POST("/api/members")
  Future<MemberModel> createMember(
      @Header('Authorization') String token, @Body() MemberModel member);

  @PATCH("/api/members/{id}")
  Future<void> updateMember(@Header('Authorization') String token,
      @Path() int id, @Body() MemberModel member);

  @DELETE("/api/members/{id}")
  Future<void> deleteMember(@Header('Authorization') String token,
      @Path() int id, @Body() MemberModel member);

  @GET("/api/members/{id}")
  Future<MemberModel> getMember(
      @Header('Authorization') String token, @Path() int id);

  @GET("/api/members")
  Future<List<MemberModel>> fetchMember(@Header('Authorization') String token);

  @GET("/api/export/members")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getExportMembers(@Header('Authorization') String token);

  // Vehicle
  @POST("/api/members/{memberId}/vehicles")
  Future<void> createVehicle(@Header('Authorization') String token,
      @Path() int memberId, @Body() VehicleModel vehicle);

  @GET("/api/vehicles")
  Future<List<VehicleModel>> fetchVehicle(
    @Header('Authorization') String token,
    @Query("offset") int offset,
    @Query("limit") int limit,
    @Query("term") String term,
    @Query("condition") String condition,
    @Query("is_member") String isMember,
  );

  @PATCH("/api/vehicles/{id}")
  Future<void> updateVehicle(@Header('Authorization') String token,
      @Path() int id, @Body() VehicleModel member);

  @DELETE("/api/vehicles/{id}")
  Future<void> deleteVehicle(
      @Header('Authorization') String token, @Path() int id);

  // Visitor
  @POST("/api/visitors")
  Future<VisitorModel> createVisitor(
      @Header('Authorization') String token, @Body() VisitorModel visitor);

  @GET("/api/visitors")
  Future<List<VisitorModel>> listVisitor(@Header('Authorization') String token,
      @Query("date") String date, @Query("dateTo") String dateTo);

  @GET("/api/visitors/{id}")
  Future<VisitorModel> getVisitor(
      @Header('Authorization') String token, @Path() int id);

  @POST("/api/visitors/{id}/photo")
  Future<VisitorModel> addPhotoVisitor(@Header('Authorization') String token,
      @Path() int id, @Part() File photo);

  @POST("/api/visitors/{id}/images/{type}")
  Future<void> addImageToVisitor(@Header('Authorization') String token,
      @Path() int id, @Path() String type, @Part() File file);

  @PATCH("/api/visitors/checkout")
  Future<VisitorModel> checkoutVisitor(
      @Header('Authorization') String token, @Body() CheckoutModel checkout);

// People
  @GET("/api/people")
  Future<List<PersonModel>> listPeople(
    @Header('Authorization') String token,
    @Query("offset") int offset,
    @Query("limit") int limit,
    @Query("term") String term,
    @Query("type") String type,
    @Query("active") String active,
  );

  @GET("/api/people/{id}")
  Future<PersonModel> getPerson(
      @Header('Authorization') String token, @Path() String id);

  @PATCH("/api/people/{id}")
  Future<PersonModel> updatePerson(@Header('Authorization') String token,
      @Path() String id, @Body() UpdatePersonModel person);

  @GET("/api/report/{type}")
  Future<List<ReportTrafficModel>> reportTraffic(
      @Header('Authorization') String token,
      @Path() String type,
      @Query("date") String date,
      @Query("dateTo") String dateTo);

  @GET("$kSmartCardReaderUrl/smartcardreader")
  Future<IDCardModel> smartCardReader();
}
