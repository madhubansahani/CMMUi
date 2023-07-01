// coverage:ignore-file

import 'dart:convert';
import 'dart:typed_data';

import 'package:cmms/app/widgets/create_permit_dialog.dart';
import 'package:cmms/app/widgets/create_sop_dialog.dart';
import 'package:cmms/app/widgets/new_warranty_claim_dialog.dart';
import 'package:cmms/app/widgets/permit_approve_message_dialog.dart';
import 'package:cmms/app/widgets/permit_cancel_by_approver_message_dialog.dart';
import 'package:cmms/app/widgets/permit_cancel_message_dialog.dart';
import 'package:cmms/app/widgets/permit_cancel_request_message_dialog.dart';
import 'package:cmms/app/widgets/permit_close_message_dialog.dart';
import 'package:cmms/app/widgets/permit_extend_message_dialog.dart';
import 'package:cmms/app/widgets/permit_issue_message_dialog.dart';
import 'package:cmms/app/widgets/permit_reject_message_dialog.dart';
import 'package:cmms/app/widgets/update_permit_dialog.dart';
import 'package:cmms/app/widgets/warranty_claim_error_dialog.dart';
import 'package:cmms/app/widgets/warranty_claim_updated_message_dialog.dart';
import 'package:cmms/data/data.dart';
import 'package:cmms/domain/domain.dart';
import 'package:cmms/domain/models/add_user_model.dart';
import 'package:cmms/domain/models/create_sop_model.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

/// The helper class which will connect to the world to get the data.
class ConnectHelper {
  ConnectHelper() {
    _init();
  }

  // late Dio _dio;

  /// Api wrapper initialization
  final apiWrapper = ApiWrapper();

  // /// Device info plugin initialization
  // final deviceinfo = DeviceInfoPlugin();

  // /// To get android device info
  // AndroidDeviceInfo? androidDeviceInfo;

  // /// To get iOS device info
  // IosDeviceInfo? iosDeviceInfo;

  // IosDeviceInfo? iosDeviceInfo;

  // coverage:ignore-start
  /// initialize the andorid device information
  void _init() async {
    // if (GetPlatform.isAndroid) {
    //   androidDeviceInfo = await deviceinfo.androidInfo;
    // } else {
    //   iosDeviceInfo = await deviceinfo.iosInfo;
    // }
    // _dio = Dio();
  }

  // coverage:ignore-end

  /// Device id
  // String? get deviceId => GetPlatform.isAndroid
  //     ? androidDeviceInfo?.id
  //     : iosDeviceInfo?.identifierForVendor;

  // /// Device make brand
  // String? get deviceMake =>
  //     GetPlatform.isAndroid ? androidDeviceInfo?.brand : 'Apple';

  // /// Device Model
  // String? get deviceModel => GetPlatform.isAndroid
  //     ? androidDeviceInfo?.model
  //     : iosDeviceInfo?.utsname.machine;

  /// Device is a type of 1 for Android and 2 for iOS
  String get deviceTypeCode => GetPlatform.isAndroid ? '1' : '2';

  // /// Device OS
  // String get deviceOs => GetPlatform.isAndroid
  //     ? '${androidDeviceInfo?.version.codename}'
  //     : '${iosDeviceInfo?.systemVersion}';

  Future<ResponseModel> getStateList(int countryCode) async =>
      await apiWrapper.makeRequest(
        'Utils/GetStateList?country_id=$countryCode',
        Request.get,
        null,
        true,
        {
          'Content-Type': 'application/json',
        },
      );

  Future<ResponseModel> generateToken({
    auth,
    bool? isLoading,
  }) async {
    ResponseModel response = ResponseModel(data: '', hasError: true);
    try {
      response = await apiWrapper.makeRequest(
        'User/Authenticate',
        Request.postMultiparts,
        // {'user_name': 'sujit@softeltech.in', 'password': 'Sujit123'},
        auth, true,
        {
          'Content-Type': 'application/json',
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
        },
      );
    } catch (error) {
      print(error);
    } finally {
      return response;
    }
  }

  Future<ResponseModel> getInventoryList({
    required bool isLoading,
    required String auth,
    int? facilityId,
    int? blockId,
    String? categoryIds,
  }) async {
    var blockIdParam = (blockId != null) ? 'linkedToBlockId=$blockId&' : '';
    var categoryIdsParam =
        (categoryIds != '') ? 'categoryIds=$categoryIds&' : '';

    var statusParam = 'status=1';
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryList?' +
          blockIdParam +
          categoryIdsParam +
          statusParam,
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  //  Future<ResponseModel> getAffectedPartList({
  //   required bool isLoading,
  //   required String auth,
  //   int? facilityId,
  //   int? blockId,
  //   String? categoryIds,
  // }) async {
  //   var blockIdParam = (blockId != null) ? 'linkedToBlockId=$blockId&' : '';
  //   var categoryIdsParam =
  //       (categoryIds != '') ? 'categoryIds=$categoryIds&' : '';

  //   var statusParam = 'status=1';
  //   ResponseModel responseModel = await apiWrapper.makeRequest(
  //     'Inventory/GetInventoryList?' +
  //         blockIdParam +
  //         categoryIdsParam +
  //         statusParam,
  //     Request.getMultiparts,
  //     null,
  //     isLoading,
  //     {
  //       'Authorization': 'Bearer $auth',
  //     },
  //   );
  //   return responseModel;
  // }

  Future<ResponseModel> getBusinessList({
    required bool isLoading,
    required String auth,
    int? businessType,
  }) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetBusinessList?businessType=$businessType',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getmanufacturerList({
    required bool isLoading,
    required String auth,
    int? BusinessType,
  }) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetBusinessList?BusinessType=$BusinessType',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getSupplierList({
    required bool isLoading,
    required String auth,
    int? BusinessType,
  }) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetBusinessList?BusinessType=$BusinessType',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getUnitCurrencyList(
      {required bool isLoading, required String auth, int? facilityId}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Utils/GetCurrencyList',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getEmployeeList(
      {required bool isLoading, required String auth, int? facility_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetEmployeeList?facility_id=$facility_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getEmployeesList(
      {required bool isLoading, required String auth, int? facility_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetEmployeeList?facility_id=$facility_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getEmployeePermitList(
      {required bool isLoading, required String auth, int? facility_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetEmployeeList?facility_id=$facility_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getPermitIssuerList(
      {required bool isLoading, required String auth, int? facility_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetEmployeeList?facility_id=$facility_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getPermitApproverList(
      {required bool isLoading, required String auth, int? facility_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      // 'CMMS/GetBusinessList?businessType=$businessType' +
      //     blockIdParam +
      //     categoryIdsParam,
      // statusParam,
      'CMMS/GetEmployeeList?facility_id=$facility_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getJobTypePermitList(
      {required bool isLoading, required String auth, int? facility_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Permit/GetJobTypeList?facility_id=$facility_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getSopPermitList(
      {required bool isLoading, required String auth, int? job_type_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Permit/GetSOPList?job_type_id=$job_type_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getAssetTypeList(
      {required bool isLoading, required String auth, int? job_type_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetAssetCategoryList',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getFacilityTypeList(
      {required bool isLoading, required String auth, int? job_type_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Facility/GetFacilityList',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getSPVList(
      {required bool isLoading, required String auth, int? job_type_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetSPVList',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getBlockTypeList(
      {required bool isLoading, required String auth, int? job_type_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Facility/GetBlockList?parent_id=$job_type_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getSafetyMeasureList(
      {required bool isLoading,
      required String auth,
      int? permit_type_id}) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Permit/GetSafetyMeasurementQuestionList?permit_type_id=$permit_type_id',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getWarrantyClaimList({
    required bool isLoading,
    required String auth,
    int? facilityId,
    int? blockId,
    required String categoryIds,
  }) async {
    var blockIdParam = (blockId != null) ? 'linkedToBlockId=$blockId&' : '';
    var categoryIdsParam =
        (categoryIds != '') ? 'categoryIds=$categoryIds&' : '';
//var statusParam = (status!=null status!='')?'status=1':'';
    // var statusParam = 'status=1';
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'WC/GetWCList?facilityId=$facilityId' + blockIdParam + categoryIdsParam,
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getIncidentReportList({
    required bool isLoading,
    required String auth,
    int? facility_id,
    String? start_date,
    required String end_date,
  }) async {
    var startDateParam = (start_date != null) ? 'start_date=$start_date&' : '';
    var endDateParam = (end_date != '') ? 'end_date=$end_date' : '';
//var statusParam = (status!=null status!='')?'status=1':'';
    // var statusParam = 'status=1';
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'IncidentReport/GetIncidentList?facility_id=$facility_id&' +
          startDateParam +
          endDateParam,
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getBlockList({
    required bool isLoading,
    required String facilityId,
    required String auth,
  }) async =>
      await apiWrapper.makeRequest(
        'CMMS/GetBlockList?facility_id=$facilityId',
        Request.getMultiparts,
        null,
        isLoading,
        {
          'Authorization': 'Bearer $auth',
        },
      );
  Future<ResponseModel> getEquipmentList({
    required bool isLoading,
    required String facilityId,
    required String auth,
  }) async =>
      await apiWrapper.makeRequest(
        'CMMS/GetAssetsList?facility_id=$facilityId',
        Request.getMultiparts,
        null,
        isLoading,
        {
          'Authorization': 'Bearer $auth',
        },
      );

  ///

  Future<ResponseModel> getJobList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? userId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Job/GetJobList?facility_id=$facilityId&userId=$userId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getNewPermitList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? userId,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Permit/GetPermitList?facility_id=$facilityId&userId=$userId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('NewPermitResponse: ${responseModel.data}');

    return responseModel;
  }

  Future<ResponseModel> getGoodsOrdersList({
    required bool isLoading,
    required String auth,
    int? facility_id,
    String? start_date,
    required String end_date,
  }) async {
    var startDateParam = (start_date != null) ? 'start_date=$start_date&' : '';
    var endDateParam = (end_date != '') ? 'end_date=$end_date' : '';

    ResponseModel responseModel = await apiWrapper.makeRequest(
      'GO/GetGOList?plantID=$facility_id&fromDate=2001-01-01&toDate=2023-05-14',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> permitIssueButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? id,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Permit/PermitIssue',
      Request.put,
      {'comment': "$comment", 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    print('PermitIssueResponse: ${res}');
    Get.dialog<void>(PermitMessageIssueDialog(data: parsedJson['message']));

    return responseModel;
  }

  Future<ResponseModel> permitApprovedButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? id,
    String? employee_id,
    String? ptwStatus,
  }) async {
    // facilityId = 45;
    // ptwStatus = 123;
    var responseModel = await apiWrapper.makeRequest(
      ptwStatus == '123'
          ? 'Permit/PermitApprove'
          : 'Permit/PermitExtendApprove',
      Request.put,
      {'comment': "$comment", 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('PermitApprovedResponse: ${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(PermitMessageApproveDialog(data: parsedJson['message']));

    return responseModel;
  }

  Future<ResponseModel> permitCancelByIssuerButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? id,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Permit/PermitCancelByIssuer',
      Request.put,
      {'comment': "$comment", 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('PermitCancelByIssuerResponse: ${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(
        PermitMessageCancelByIssuerDialog(data: parsedJson['message']));

    return responseModel;
  }

  Future<ResponseModel> permitCancelRequestButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? id,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Permit/PermitCancelRequest',
      Request.put,
      {'comment': "$comment", 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('PermitCancelRequestResponse: ${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(
        PermitMessageCancelRequestDialog(data: parsedJson['message']));

    return responseModel;
  }

  Future<ResponseModel> permitCancelByApproverButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? id,
    String? ptwStatus,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      ptwStatus == '123'
          ? 'Permit/PermitCancelByApprover'
          : 'Permit/PermitCancelRequest',
      Request.put,
      {'comment': "$comment", 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print(
        'PermitCancelByApprover&CancelRequestResponse: ${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(
        PermitMessageCancelByApproverDialog(data: parsedJson['message']));

    return responseModel;
  }

  Future<ResponseModel> permitExtendButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? Time,
    String? id,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Permit/PermitExtend',
      Request.put,
      {'comment': "$comment", 'Time': '$Time', 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('PermitExtendResponse: ${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(PermitMessageExtendDialog(data: parsedJson['message']));

    return responseModel;
  }

  Future<ResponseModel> permitCloseButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? id,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Permit/PermitClose',
      Request.put,
      {'comment': "$comment", 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('PermitCloseResponse: ${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(PermitMessageCloseDialog(data: parsedJson['message']));

    return responseModel;
  }

  Future<ResponseModel> permitRejectButton({
    required String auth,
    bool? isLoading,
    String? comment,
    String? id,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Permit/PermitReject',
      Request.put,
      {'comment': "$comment", 'id': id},
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('PermitRejectResponse: ${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(PermitMessageRejectDialog(data: parsedJson['message']));

    return responseModel;
  }

//   Future<ResponseModel> getNewPermitList({
//     required bool isLoading,
//     required String auth,
//     int? facilityId,
//     int? userId,
//     // int? blockId,
//     // required String categoryIds,
//   }) async {
//     // var blockIdParam = (blockId != null) ? 'linkedToBlockId=$blockId&' : '';
//     // var categoryIdsParam =
//     //     (categoryIds != '') ? 'categoryIds=$categoryIds&' : '';
// //var statusParam = (status!=null status!='')?'status=1':'';
//     // var statusParam = 'status=1';
//     ResponseModel responseModel = await apiWrapper.makeRequest(
//       'Permit/GetPermitList?facility_id=$facilityId&userId=$userId',
//           // blockIdParam +
//           // categoryIdsParam,
//       Request.getMultiparts,
//       null,
//       isLoading,
//       {
//         'Authorization': 'Bearer $auth',
//       },
//     );
//     print('New Permit Response5:${responseModel.data}');
//     return responseModel;
//   }

  Future<ResponseModel> getInventoryDetailList({
    required String auth,
    bool? isLoading,
    // int? facilityId,
    int? id,
  }) async {
    // facilityId = 45;
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryDetails?id=$id',
      Request.get,
      null,
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('InventoryDetailResponse: ${responseModel.data}');

    return responseModel;
  }

  Future<ResponseModel> getPreventiveCheckList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? type,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/GetCheckList?facility_id=$facilityId&type=$type',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getModuleList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? type,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CMMS/GetModuleList',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getInventoryTypeList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? type,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryTypeList',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getInventoryStatusList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? type,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryStatusList',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getCheckPointlist({
    required String auth,
    bool? isLoading,
    int? selectedchecklistId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/GetCheckPointList?checklist_id=$selectedchecklistId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getJobDetails({
    required String auth,
    bool? isLoading,
    int? jobId,
    int? userId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Job/GetJobDetails?job_id=$jobId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getPermitList({
    required String auth,
    int? facilityId,
    bool? selfView,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/GetPermitList?facility_id=$facilityId&self_view=$selfView',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getFacilityList({
    String? auth,
    bool? isLoading,
  }) async {
    ResponseModel response = ResponseModel(data: '', hasError: true);
    print('Facility List: ${response}');
    try {
      response = await apiWrapper.makeRequest(
        'CMMS/GetFacilityList',
        Request.get,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );
    } catch (error) {
      print(error);
    }

    return response;
  }

  Future<ResponseModel> getTypePermitList(
      {String? auth, bool? isLoading, int? facility_id}) async {
    ResponseModel response = ResponseModel(data: '', hasError: true);
    print('PermitTypeResponse: $response');
    try {
      response = await apiWrapper.makeRequest(
        'Permit/GetPermitTypeList?facility_id=$facility_id',
        Request.get,
        null,
        true,
        {
          'Authorization': 'Bearer $auth',
        },
      );
    } catch (error) {
      print(error);
    }

    return response;
  }

  Future<ResponseModel> getBlocksList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async =>
      await apiWrapper.makeRequest(
        'CMMS/GetBlockList?facility_id=$facilityId',
        Request.getMultiparts,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );
  Future<ResponseModel> getAssetList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async =>
      await apiWrapper.makeRequest(
        'SMMaster/GetAssetMasterList',
        Request.getMultiparts,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );

  Future<ResponseModel> getInventoryCategoryList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async =>
      await apiWrapper.makeRequest(
        'Inventory/GetInventoryCategoryList',
        Request.getMultiparts,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );

  Future<ResponseModel> getAffectedPartList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async =>
      await apiWrapper.makeRequest(
        'Inventory/GetInventoryCategoryList',
        Request.getMultiparts,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );

  Future<ResponseModel> getInventoryIsolationList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async =>
      await apiWrapper.makeRequest(
        'Inventory/GetInventoryCategoryList',
        Request.getMultiparts,
        null,
        isLoading ?? true,
        {
          'Authorization': 'Bearer $auth',
        },
      );

  Future<ResponseModel> getInventoryEquipmentNameList({
    required bool isLoading,
    required String auth,
    int? facilityId,
    int? blockId,
    required String categoryIds,
  }) async {
    var blockIdParam = (blockId != null) ? 'linkedToBlockId=$blockId&' : '';
    var categoryIdsParam =
        (categoryIds != '') ? 'categoryIds=$categoryIds&' : '';
    var facilityIdparam = (facilityId != null) ? 'facilityId=$facilityId&' : '';
//var statusParam = (status!=null status!='')?'status=1':'';
    var statusParam = 'status=1';
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryList?' +
          blockIdParam +
          categoryIdsParam +
          facilityIdparam,
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getFrequencyList({
    String? auth,
    bool? isLoading,
  }) async =>
      await apiWrapper.makeRequest(
        'CMMS/GetFrequencyList',
        Request.getMultiparts,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );

  Future<ResponseModel> getAssignedToList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? userId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CMMS/GetEmployeeList?facility_id=$facilityId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getWorkTypeList({
    String? categoryIds,
    bool? isLoading,
    String? auth,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'JobWorkType/GetJobWorkTypeList?categoryIds=$categoryIds',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getToolsRequiredToWorkTypeList({
    required String auth,
    String? workTypeIds,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'JobWorkType/GetMasterToolList?worktypeIds=$workTypeIds',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> saveJob({
    required String auth,
    job,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Job/CreateNewJob?job=$job',
      Request.post,
      job,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> updateJob({
    required String auth,
    job,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Job/UpdateJob?job=$job',
      Request.patch,
      job,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> assignReAssignJob({
    required String auth,
    jobId,
    assignedToId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Job/ReAssignJob?job_id=$jobId&assignedTo=$assignedToId',
      Request.put,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  ///
  Future<ResponseModel> linkToPermit({
    required String auth,
    jobId,
    permitId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Job/LinkToPTW?job_id=$jobId&ptw_id=$permitId',
      Request.put,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  ///
  Future<ResponseModel> createJobCard({
    String? auth,
    int? jobId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'JC/CreateJC?job_id=$jobId',
      Request.post,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> uploadFiles({
    required String auth,
    fileUploadModel,
    int? facilityId,
    int? moduleId,
    int? id,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'FileUpload/UploadFile',
      Request.post,
      fileUploadModel,
      isLoading ?? false,
      {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  //Create New Permit
  Future<ResponseModel> createNewPermit({
    required String auth,
    newPermit,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/CreatePermit',
      Request.post,
      newPermit,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    print('CreateNewPermitResponse5:${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(CreateNewPermitDialog(
      data: parsedJson['message'],
      PtwId: parsedJson['id'],
    ));

    return responseModel;
  }

  //Update New Permit
  Future<ResponseModel> updateNewPermit({
    required String auth,
    newPermit,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/UpdatePermit',
      Request.patch,
      newPermit,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    print('UpdateNewPermitResponse5:${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(UpdateNewPermitDialog(
      data: parsedJson['message'],
      PtwId: parsedJson['id'],
    ));

    return responseModel;
  }

  //Create SOP
  Future<ResponseModel> createSOP({
    required String auth,
    createSop,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/createSOP',
      Request.post,
      createSop,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    print('Create SOP Response:${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    Get.dialog<void>(CreateSopDialog(
      data: parsedJson['message'],
      SopId: parsedJson['id'],
    ));

    return responseModel;
  }

  //Create Warranty Claim
  Future<ResponseModel> createWarrantyClaim({
    required String auth,
    createWarrantyClaim,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'WC/CreateWC',
      Request.post,
      createWarrantyClaim,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    print('Create Warranty Claim Response:${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    // if (res.e != null) {
    //   Get.dialog<void>(WarrantyClaimErrorDialog());
    // } else {

    Get.dialog<void>(NewWarrantyClaimDialog(
      data: parsedJson['message'],
      warrantyClaimId: parsedJson['id'],
    ));
    // }

    return responseModel;
  }

  //Create WarraGoods order

  Future<ResponseModel> createGoodsOrder({
    required String auth,
    createGo,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'GO/CreateGO',
      Request.post,
      createGo,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    print('Create Goods Orders Response:${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    // if (res.e != null) {
    //   Get.dialog<void>(WarrantyClaimErrorDialog());
    // } else {

    return responseModel;
  }

  //Update Warranty Claim
  Future<ResponseModel> updateWarrantyClaim({
    required String auth,
    updateWarrantyClaim,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'WC/UpdateWC',
      Request.patch,
      updateWarrantyClaim,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    print('Update Warranty Claim Response:${responseModel.data}');
    var res = responseModel.data;
    var parsedJson = json.decode(res);
    // if (res.e != null) {
    //   Get.dialog<void>(WarrantyClaimErrorDialog());
    // } else {

    Get.dialog<void>(WarrantyClaimUpdatedMessageDialog(
      data: parsedJson['message'],
      warrantyClaimId: parsedJson['id'],
    ));
    // }

    return responseModel;
  }

  Future<ResponseModel> getUserAccessList({
    required String auth,
    bool? isLoading,
    String? userId,
  }) async {
    userId = userId;
    var responseModel = await apiWrapper.makeRequest(
      'User/GetUserAccess?user_id=$userId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getNewPermitDetail({
    required String auth,
    bool? isLoading,
    int? permitId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/GetPermitDetails?permit_id=$permitId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getViewPermitDetail({
    required String auth,
    bool? isLoading,
    int? permitId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/GetPermitDetails?permit_id=$permitId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('ViewResponseModel${responseModel.data}');
    return responseModel;
  }

  Future<ResponseModel> getViewWarrantyClaimDetail({
    required String auth,
    bool? isLoading,
    int? wc_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'wc/GetWCDetails?wc_id=$wc_id',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('ViewWarrantyClaimResponseModel${responseModel.data}');
    return responseModel;
  }

  Future<ResponseModel> getInventoryDetail({
    required String auth,
    bool? isLoading,
    int? id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryDetails?id=$id',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('InventoryResponseModel${responseModel.data}');
    return responseModel;
  }

  Future<ResponseModel> getAddInventoryDetail({
    required String auth,
    bool? isLoading,
    int? id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryDetails?id=$id',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    print('AddInventoryResponseModel${responseModel.data}');
    return responseModel;
  }

  Future<ResponseModel> getHistory({
    String? auth,
    int? moduleType,
    int? id,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Utils/GetHistoryLog?module_type=$moduleType&id=$id',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> createModuleList({
    required String auth,
    bool? isLoading,
    required modulelistJsonString,
  }) async {
    var responseModel =
        // responseModel =
        await apiWrapper.makeRequest(
      'CMMS/AddModule',
      Request.post,
      modulelistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> createCheckList({
    required String auth,
    bool? isLoading,
    required checklistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/CreateCheckList',
      Request.post,
      checklistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> createCheckpoint({
    required String auth,
    bool? isLoading,
    required checkpointJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/CreateCheckPoint',
      Request.post,
      checkpointJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> deleteCkeckpoint({
    required String auth,
    bool? isLoading,
    required check_point_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/DeleteCheckPoint?id=$check_point_id',
      Request.delete,
      check_point_id,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> deleteModulelist({
    required String auth,
    bool? isLoading,
    required module_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CMMS/DeleteModule?id=$module_id',
      Request.delete,
      module_id,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getJobCardHistory({
    required String? auth,
    int? moduleType,
    int? jobCardId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Utils/GetHistoryLog?module_type=$moduleType&id=$jobCardId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  ///Permit History
  Future<ResponseModel> getPermitHistory({
    required String? auth,
    int? moduleType,
    int? permitId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Utils/GetHistoryLog?module_type=$moduleType&id=$permitId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    print('PermitHistory Response:${responseModel}');
    return responseModel;
  }

  Future<ResponseModel> updateJobCard({
    String? auth,
    jobCard,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'JC/UpdateJC',
      Request.put,
      jobCard,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> approveJobCard({
    String? auth,
    jobCardId,
    comment,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'JC/ApproveJC',
      Request.put,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> rejectJobCard({
    String? auth,
    jobCardId,
    comment,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'JC/RejectJC',
      Request.put,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getPermitDetails({
    required String? auth,
    int? permitId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/GetPermitDetails?permit_id=$permitId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getJobCardDetails({
    String? auth,
    int? jobCardId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'JC/GetJCDetail?jc_id=$jobCardId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getPmMappingList({
    required String auth,
    bool? isLoading,
    int? facilityId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/GetCheckListMap?facility_id=$facilityId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> savePmMapping({
    required String auth,
    pmJsonString,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/CreateCheckListMap',
      Request.post,
      pmJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getCalibrationList({
    required String auth,
    bool? isLoading,
    int? facilityId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/GetCalibrationList?facility_id=$facilityId',
      Request.get,
      null,
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> requestCalibration({
    required String auth,
    bool? isLoading,
    required requestCalibration,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/RequestCalibration',
      Request.post,
      requestCalibration,
      isLoading ?? true,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> rejectRequestCalibration({
    required String auth,
    bool? isLoading,
    required rejectCalibrationtoJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/RejectRequestCalibration',
      Request.put,
      rejectCalibrationtoJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> approveRequestCalibration({
    required String auth,
    bool? isLoading,
    required approveCalibrationtoJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/ApproveRequestCalibration',
      Request.put,
      approveCalibrationtoJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> rejectCloseCalibration({
    required String auth,
    bool? isLoading,
    required rejectCalibrationtoJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/RejectCalibration',
      Request.put,
      rejectCalibrationtoJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> approveCloseCalibration({
    required String auth,
    bool? isLoading,
    required approveCalibrationtoJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/ApproveCalibration',
      Request.put,
      approveCalibrationtoJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> closeCalibration({
    required String auth,
    bool? isLoading,
    required closeCalibrationtoJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/CloseCalibration',
      Request.put,
      closeCalibrationtoJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> completeCalibration({
    required String auth,
    bool? isLoading,
    required completeCalibrationtoJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/CompleteCalibration',
      Request.put,
      completeCalibrationtoJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getPMScheduleData({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? selectedEquipmentId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'PM/GetScheduleData?facility_id=$facilityId&category_id=$selectedEquipmentId',
      Request.get,
      null,
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> savePmSchedule({
    required String auth,
    pmScheduleJsonString,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'PM/SetScheduleData',
      Request.post,
      pmScheduleJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getPmTaskList(
      {required String auth,
      bool? isLoading,
      int? facilityId,
      dynamic startDate,
      dynamic endDate}) async {
    var responseModel = await apiWrapper.makeRequest(
      'PMScheduleView/GetPMTaskList?facility_id=${facilityId}&start_date=${startDate}&end_date=${endDate}',
      Request.get,
      null,
      isLoading ?? true,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getPmtaskViewList({
    required String? auth,
    int? scheduleId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'PMScheduleView/GetPMTaskDetail?schedule_id=$scheduleId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<CreateSOPModel> browseFiles({
    required String auth,
    Uint8List? fileBytes,
    required String fileName,
    bool? isLoading,
  }) async {
    final request = http.MultipartRequest('POST',
        Uri.parse('http://3.111.196.218/CMMS_API/api/FileUpload/UploadFile'));
    request.files.add(
        http.MultipartFile.fromBytes('files', fileBytes!, filename: fileName));
    request.headers.addAll({'Authorization': 'Bearer $auth'});

    // Send the request and wait for the response
    final response = await request.send();
    var respStr = await response.stream.bytesToString();
    var jsonResponse = json.decode(respStr);

    // Check if the upload was successful
    if (response.statusCode == 200) {
      importInventory(
          auth: auth,
          fileId: jsonResponse["id"][0].toString(),
          isLoading: true);
    }

    CreateSOPModel createSOPModel = CreateSOPModel(
        jsa_fileId: int.parse(jsonResponse["id"][0].toString()),
        sop_fileId: int.parse(jsonResponse["id"][0].toString()));
    print('JsaDataId${createSOPModel.jsa_fileId}');
    print('SOPDataId${createSOPModel.sop_fileId}');

    return createSOPModel;
  }

  Future<ResponseModel> importInventory({
    required String auth,
    required String fileId,
    required bool isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/ImportInventories?file_id=$fileId',
      Request.post,
      null,
      false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> deleteCkecklist({
    required String auth,
    bool? isLoading,
    required checklist_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/DeleteCheckList?id=$checklist_id',
      Request.delete,
      checklist_id,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateChecklistNumber({
    required String auth,
    bool? isLoading,
    required checklistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/UpdateCheckList',
      Request.patch,
      checklistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateModulelistNumber({
    required String auth,
    bool? isLoading,
    required modulelistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CMMS/UpdateModule',
      Request.patch,
      modulelistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateCheckPoint({
    required String auth,
    bool? isLoading,
    required checkpointJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CheckList/UpdateCheckPoint',
      Request.patch,
      checkpointJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getCountryList({
    String? auth,
    bool? isLoading,
  }) async =>
      await apiWrapper.makeRequest(
        'Utils/GetCountryList',
        Request.get,
        null,
        true,
        {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $auth',
        },
      );
  Future<ResponseModel> getBloodList({
    String? auth,
    bool? isLoading,
  }) async =>
      await apiWrapper.makeRequest(
        'CMMS/GetBloodGroupList',
        Request.get,
        null,
        true,
        {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $auth',
        },
      );
  Future<ResponseModel> getStateListnew(
          {String? auth, bool? isLoading, int? selectedCountryId}) async =>
      await apiWrapper.makeRequest(
        'Utils/GetStateList?country_id=$selectedCountryId',
        Request.get,
        null,
        true,
        {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $auth',
        },
      );
  Future<ResponseModel> getCityList(
          {String? auth, bool? isLoading, int? selectedStateId}) async =>
      await apiWrapper.makeRequest(
        'Utils/GetCityList?state_id=$selectedStateId',
        Request.get,
        null,
        true,
        {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $auth',
        },
      );
  Future<ResponseModel> getRoleAccessList({
    required String? auth,
    int? roleId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'RoleAccess/GetRoleAccess?role_id=$roleId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getRoleNotificationList({
    required String? auth,
    int? roleId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'RoleAccess/GetRoleNotifications?role_id=$roleId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getUserAccessListById({
    required String? auth,
    int? userId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/GetUserAccess?user_id=$userId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getUserNotificationListById({
    required String? auth,
    int? userId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/GetUserNotifications?user_id=$userId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getRoleList({
    String? auth,
    bool? isLoading,
  }) async =>
      await apiWrapper.makeRequest(
        'RoleAccess/GetRoleList',
        Request.get,
        null,
        true,
        {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $auth',
        },
      );
  Future<ResponseModel> getUserList({
    required String auth,
    bool? isLoading,
    int? facilityId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/GetUserList?facility_id=$facilityId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
        'Content-Type': 'application/json',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getUserDetails({
    required String? auth,
    int? userId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/GetUserDetail?user_id=$userId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> saveAccessLevel({
    required String auth,
    accessLevelJsonString,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/SetUserAccess',
      Request.post,
      accessLevelJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> addUser({
    required String auth,
    bool? isLoading,
    required adduserJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/CreateUser',
      Request.post,
      adduserJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateUser({
    required String auth,
    bool? isLoading,
    required adduserJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/UpdateUser',
      Request.patch,
      adduserJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updatePmExecution({
    required String auth,
    pmExecutionJsonString,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'PMScheduleView/UpdatePMTaskExecution',
      Request.patch,
      pmExecutionJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getWarrantyTypeList({
    String? auth,
    bool? isLoading,
  }) async =>
      await apiWrapper.makeRequest(
        'Inventory/GetWarrantyTypeList',
        Request.getMultiparts,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );
  Future<AddUserModel> uploadImge({
    required String auth,
    Uint8List? fileBytes,
    required String fileName,
    bool? isLoading,
  }) async {
    final request = http.MultipartRequest('POST',
        Uri.parse('http://3.111.196.218/CMMS_API/api/FileUpload/UploadFile'));
    request.files.add(
        http.MultipartFile.fromBytes('files', fileBytes!, filename: fileName));
    request.headers.addAll({'Authorization': 'Bearer $auth'});

    // Send the request and wait for the response
    final response = await request.send();
    var respStr = await response.stream.bytesToString();
    var jsonResponse = json.decode(respStr);

    // Check if the upload was successful
    // if (response.statusCode == 200) {
    AddUserModel addUserModel = AddUserModel(
      photo_id: int.parse(jsonResponse["id"][0].toString()),
    );
    print('photo_id${addUserModel.photo_id}');

    return addUserModel;
  }

  ///

  Future<ResponseModel> getWarrantyUsageTermList({
    String? auth,
    bool? isLoading,
  }) async =>
      await apiWrapper.makeRequest(
        'Inventory/GetWarrantyUsageTermList',
        Request.getMultiparts,
        null,
        isLoading ?? false,
        {
          'Authorization': 'Bearer $auth',
        },
      );

  Future<ResponseModel> getBusinessTypeList({
    required bool isLoading,
    required String auth,
    int? businessType,
  }) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'CMMS/GetBusinessTypeList',
      Request.getMultiparts,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> createBusinessList({
    required String auth,
    bool? isLoading,
    required businesslistJsonString,
  }) async {
    var responseModel =
        // responseModel =
        await apiWrapper.makeRequest(
      'CMMS/AddBusiness', //AddBusiness
      Request.post,
      businesslistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> saveNotification({
    required String auth,
    saveNotificationJsonString,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/SetUserNotifications',
      Request.post,
      saveNotificationJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getWarrantyList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? type,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/GetWarrantyTypeList',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> AddInventory({
    required String auth,
    bool? isLoading,
    required addInventoryJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/AddInventory',
      Request.post,
      addInventoryJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateInventory({
    required String auth,
    bool? isLoading,
    required addInventoryJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Inventory/UpdateInventory',
      Request.put,
      addInventoryJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> inventoryList({
    required bool isLoading,
    required String auth,
    int? facilityId,
  }) async {
    ResponseModel responseModel = await apiWrapper.makeRequest(
      'Inventory/GetInventoryList?facility_id=$facilityId',
      Request.get,
      null,
      isLoading,
      {
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> startCalibration({
    required String auth,
    bool? isLoading,
    required calibrationId,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/StartCalibration?calibration_id=$calibrationId',
      Request.put,
      calibrationId,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> createFacilityType({
    required String auth,
    bool? isLoading,
    required facilitylistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Facility/CreateNewFacility',
      Request.post,
      facilitylistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> createBlockType({
    required String auth,
    bool? isLoading,
    required blockTypeJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Facility/CreateNewBlock',
      Request.post,
      blockTypeJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  ///
  Future<ResponseModel> getCalibrationView({
    required String? auth,
    int? calibrationId,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Calibration/GetCalibrationDetails?id=$calibrationId',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getAssetMasterList({
    required String auth,
    bool? isLoading,
    int? facilityId,
    int? type,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'SMMaster/GetAssetMasterList',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );
    return responseModel;
  }

  Future<ResponseModel> getDesignationList({
    String? auth,
    bool? isLoading,
  }) async =>
      await apiWrapper.makeRequest(
        'RoleAccess/GetDesignationList',
        Request.get,
        null,
        true,
        {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $auth',
        },
      );

  Future<ResponseModel> deleteBusinessList({
    required String auth,
    bool? isLoading,
    required business_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CMMS/DeleteBusiness?id=$business_id',
      Request.delete,
      business_id,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateBusinesslist({
    required String auth,
    bool? isLoading,
    required modulelistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'CMMS/UpdateBusiness',
      Request.patch,
      modulelistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> getCompetencyList({
    required String auth,
    bool? isLoading,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/GetCompetencyList',
      Request.get,
      null,
      isLoading ?? false,
      {
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> createCompetency({
    required String auth,
    bool? isLoading,
    required competencyJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/AddCompetency',
      Request.post,
      competencyJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateCompetency({
    required String auth,
    bool? isLoading,
    required competencyJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/UpdateCompetency',
      Request.patch,
      competencyJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> deleteCompetencyList({
    required String auth,
    bool? isLoading,
    required checklist_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'User/DeleteCompetency?id=$checklist_id',
      Request.delete,
      checklist_id,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> createPermitType({
    required String auth,
    bool? isLoading,
    required checklistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/CreatePermitType',
      Request.post,
      checklistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> deletePermitType({
    required String auth,
    bool? isLoading,
    required checklist_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/DeletePermitType?id=$checklist_id',
      Request.delete,
      checklist_id,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updatePermitType({
    required String auth,
    bool? isLoading,
    required checklistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'Permit/UpdatePermitType',
      Request.patch,
      checklistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> createRoleList({
    required String auth,
    bool? isLoading,
    required modulelistJsonString,
  }) async {
    var responseModel =
    // responseModel =
    await apiWrapper.makeRequest(
      'RoleAccess/AddRole',
      Request.post,
      modulelistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> updateRoleList({
    required String auth,
    bool? isLoading,
    required modulelistJsonString,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'RoleAccess/UpdateRole',
      Request.patch,
      modulelistJsonString,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }

  Future<ResponseModel> deleteRole({
    required String auth,
    bool? isLoading,
    required module_id,
  }) async {
    var responseModel = await apiWrapper.makeRequest(
      'RoleAccess/DeleteRole?id=$module_id',
      Request.delete,
      module_id,
      isLoading ?? false,
      {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $auth',
      },
    );

    return responseModel;
  }
}
