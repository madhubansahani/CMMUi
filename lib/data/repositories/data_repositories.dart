import 'dart:typed_data';

import 'package:cmms/data/data.dart';
import 'package:cmms/domain/domain.dart';
import 'package:cmms/domain/models/create_sop_model.dart';

import '../../domain/models/add_user_model.dart';

/// Repositories (retrieve data, heavy processing etc..)
class DataRepository extends DomainRepository {
  /// [connectHelper] : A connection helper which will connect to the
  /// remote to get the data.
  DataRepository(this.connectHelper);

  final ConnectHelper connectHelper;

  @override
  void clearData(dynamic key) {
    throw UnimplementedError();
  }

  /// Delete the box
  @override
  void deleteBox() {
    throw UnimplementedError();
  }

  /// returns stored string value
  @override
  String getStringValue(String key) {
    throw UnimplementedError();
  }

  /// store the data
  @override
  void saveValue(dynamic key, dynamic value) {
    throw UnimplementedError();
  }

  /// return bool value
  @override
  bool getBoolValue(String key) => throw UnimplementedError();

  /// Get data from secure storage
  @override
  Future<String> getSecuredValue(String key) async {
    //return generateToken();
    throw UnimplementedError();
  }

  Future<String> getUserAccessData(String key) async {
    //return generateToken();
    throw UnimplementedError();
  }

  @override
  Future<String> getNewPermitAccessData(String key) async {
    //return generateToken();
    throw UnimplementedError();
  }

  /// Save data in secure storage
  @override
  void saveValueSecurely(String key, String value) {
    throw UnimplementedError();
  }

  void saveUserAcessData(String key, String value) {
    throw UnimplementedError();
  }

  /// Delete data from secure storage
  @override
  void deleteSecuredValue(String key) {
    throw UnimplementedError();
  }

  /// Delete all data from secure storage
  @override
  void deleteAllSecuredValues() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel> getStateList(int countryCode) async =>
      await connectHelper.getStateList(countryCode);

  @override
  Future<ResponseModel> generateToken({
    auth,
    bool? isLoading,
  }) async {
    var response =
        await connectHelper.generateToken(auth: auth, isLoading: isLoading);
    return response;
  }

  @override
  Future<ResponseModel> getInventoryList({
    int? facilityId,
    int? blockId,
    String? categoryIds,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getInventoryList(
      isLoading: isLoading,
      auth: auth,
      facilityId: facilityId,
      blockId: blockId,
      categoryIds: categoryIds,
    );
  }

  @override
  Future<ResponseModel> getAffectedPartList({
    int? facilityId,
    int? blockId,
    String? categoryIds,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getAffectedPartList(
      isLoading: isLoading,
      auth: auth,
      facilityId: facilityId,
      // blockId: blockId,
      // categoryIds: categoryIds,
    );
  }

  @override
  Future<ResponseModel> getBusinessList({
    int? businessType,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getBusinessList(
      isLoading: isLoading,
      auth: auth,
      businessType: businessType,
    );
  }

  Future<ResponseModel> getmanufacturerList({
    int? BusinessType,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getmanufacturerList(
      isLoading: isLoading,
      auth: auth,
      BusinessType: BusinessType,
    );
  }

  Future<ResponseModel> getSupplierList({
    int? BusinessType,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getSupplierList(
      isLoading: isLoading,
      auth: auth,
      BusinessType: BusinessType,
    );
  }

  @override
  Future<ResponseModel> getUnitCurrencyList({
    int? facilityId,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getUnitCurrencyList(
      isLoading: isLoading,
      auth: auth,
      facilityId: facilityId,
    );
  }

  @override
  Future<ResponseModel> getEmployeeList({
    int? facility_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getEmployeeList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
    );
  }

  @override
  Future<ResponseModel> getEmployeesList({
    int? facility_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getEmployeesList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
    );
  }

  @override
  Future<ResponseModel> getEmployeePermitList({
    int? facility_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getEmployeePermitList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
    );
  }

  @override
  Future<ResponseModel> getPermitIssuerList({
    int? facility_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getPermitIssuerList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
    );
  }

  @override
  Future<ResponseModel> getPermitApproverList({
    int? facility_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getPermitApproverList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
    );
  }

  @override
  Future<ResponseModel> getJobTypePermitList({
    int? facility_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getJobTypePermitList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
    );
  }

  @override
  Future<ResponseModel> getSopPermitList({
    int? job_type_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getSopPermitList(
      isLoading: isLoading,
      auth: auth,
      job_type_id: job_type_id,
      // businessType: businessType,
      // blockId: blockId,
      // categoryIds: categoryIds,
    );
  }

  @override
  Future<ResponseModel> getAssetTypeList({
    int? job_type_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getAssetTypeList(
      isLoading: isLoading,
      auth: auth,
      job_type_id: job_type_id,
      // businessType: businessType,
      // blockId: blockId,
      // categoryIds: categoryIds,
    );
  }

  Future<ResponseModel> getFacilityTypeList({
    int? job_type_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getFacilityTypeList(
      isLoading: isLoading,
      auth: auth,
      job_type_id: job_type_id,
      // businessType: businessType,
      // blockId: blockId,
      // categoryIds: categoryIds,
    );
  }

  Future<ResponseModel> getSPVList({
    int? job_type_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getSPVList(
      isLoading: isLoading,
      auth: auth,
      job_type_id: job_type_id,
      // businessType: businessType,
      // blockId: blockId,
      // categoryIds: categoryIds,
    );
  }

  Future<ResponseModel> getBlockTypeList({
    int? job_type_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getBlockTypeList(
      isLoading: isLoading,
      auth: auth,
      job_type_id: job_type_id,
      // businessType: businessType,
      // blockId: blockId,
      // categoryIds: categoryIds,
    );
  }

  @override
  Future<ResponseModel> getSafetyMeasureList({
    int? permit_type_id,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getSafetyMeasureList(
      isLoading: isLoading,
      auth: auth,
      permit_type_id: permit_type_id,
      // businessType: businessType,
      // blockId: blockId,
      // categoryIds: categoryIds,
    );
  }

  @override
  Future<ResponseModel> getWarrantyClaimList({
    int? facilityId,
    int? blockId,
    required String categoryIds,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getWarrantyClaimList(
      isLoading: isLoading,
      auth: auth,
      facilityId: facilityId,
      blockId: blockId,
      categoryIds: categoryIds,
    );
  }

  ///Incident Report List
  @override
  Future<ResponseModel> getIncidentReportList({
    int? facility_id,
    String? start_date,
    required String end_date,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getIncidentReportList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
      start_date: start_date,
      end_date: end_date,
    );
  }

  @override
  Future<ResponseModel> getWorkTypeList({
    String? categoryIds,
    bool? isLoading,
    String? auth,
  }) async {
    return await connectHelper.getWorkTypeList(
      isLoading: isLoading,
      auth: auth,
      categoryIds: categoryIds,
    );
  }

  @override
  Future<ResponseModel> getBlockList({
    required bool isLoading,
    required String facilityId,
    required String auth,
  }) async {
    return await connectHelper.getBlockList(
      isLoading: isLoading,
      facilityId: facilityId,
      auth: auth,
    );
  }

  @override
  Future<ResponseModel> getEquipmentList(
          {required bool isLoading,
          required String facilityId,
          required String auth}) async =>
      await connectHelper.getEquipmentList(
        isLoading: isLoading,
        facilityId: facilityId,
        auth: auth,
      );

  Future<ResponseModel> getJobList({
    required String auth,
    int? facilityId,
    int? userId,
    bool? isLoading,
  }) async =>
      await connectHelper.getJobList(
        auth: auth,
        facilityId: facilityId ?? 0,
        userId: userId,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> getGoodsOrdersList({
    int? facility_id,
    String? start_date,
    required String end_date,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getGoodsOrdersList(
      isLoading: isLoading,
      auth: auth,
      facility_id: facility_id,
      start_date: start_date,
      end_date: end_date,
    );
  }

  Future<ResponseModel> getNewPermitList({
    required String auth,
    int? facilityId,
    int? userId,
    bool? isLoading,
  }) async =>
      await connectHelper.getNewPermitList(
        auth: auth,
        facilityId: facilityId,
        // facilityId: facilityId ?? 0,
        // userId: 33,
        userId: userId,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitIssueButton({
    required String auth,
    String? comment,
    String? id,
    bool? isLoading,
  }) async =>
      await connectHelper.permitIssueButton(
        auth: auth,
        comment: comment,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitApprovedButton({
    required String auth,
    String? comment,
    String? id,
    String? ptwStatus,
    bool? isLoading,
  }) async =>
      await connectHelper.permitApprovedButton(
        auth: auth,
        comment: comment,
        id: id,
        ptwStatus: ptwStatus,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitCancelByIssuerButton({
    required String auth,
    String? comment,
    String? id,
    bool? isLoading,
  }) async =>
      await connectHelper.permitCancelByIssuerButton(
        auth: auth,
        comment: comment,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitCancelRequestButton({
    required String auth,
    String? comment,
    String? id,
    bool? isLoading,
  }) async =>
      await connectHelper.permitCancelRequestButton(
        auth: auth,
        comment: comment,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitCancelByApproverButton({
    required String auth,
    String? comment,
    String? id,
    String? ptwStatus,
    bool? isLoading,
  }) async =>
      await connectHelper.permitCancelByApproverButton(
        auth: auth,
        comment: comment,
        id: id,
        ptwStatus: ptwStatus,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitExtendButton({
    required String auth,
    String? comment,
    String? Time,
    String? id,
    bool? isLoading,
  }) async =>
      await connectHelper.permitExtendButton(
        auth: auth,
        comment: comment,
        Time: Time,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitCloseButton({
    required String auth,
    String? comment,
    String? id,
    bool? isLoading,
  }) async =>
      await connectHelper.permitCloseButton(
        auth: auth,
        comment: comment,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> permitRejectButton({
    required String auth,
    String? comment,
    String? id,
    bool? isLoading,
  }) async =>
      await connectHelper.permitRejectButton(
        auth: auth,
        comment: comment,
        id: id,
        isLoading: isLoading ?? false,
      );

  //  @override
  // Future<ResponseModel> getNewPermitList({
  //   int? facilityId,
  //   required int? userId,
  //   // int? blockId,
  //   // required String categoryIds,
  //   required bool isLoading,
  //   required String auth,
  // }) async {
  //   return await connectHelper.getNewPermitList(
  //     isLoading: isLoading,
  //     auth: auth,
  //     facilityId: facilityId,
  //     userId: 33,
  //     // blockId: blockId,
  //     // categoryIds: categoryIds,
  //   );
  // }

  Future<ResponseModel> getInventoryDetailList({
    required String auth,
    // int? facilityId,
    int? id,
    bool? isLoading,
  }) async =>
      await connectHelper.getInventoryDetailList(
        auth: auth,
        // facilityId: 45,
        // facilityId: facilityId ?? 0,
        // userId: userId,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getPreventiveCheckList({
    required String auth,
    int? facilityId,
    int? type,
    bool? isLoading,
  }) async =>
      await connectHelper.getPreventiveCheckList(
        auth: auth,
        facilityId: facilityId ?? 0,
        type: type,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getModuleList({
    required String auth,
    int? facilityId,
    int? type,
    bool? isLoading,
  }) async =>
      await connectHelper.getModuleList(
        auth: auth,
        facilityId: facilityId ?? 0,
        type: type,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getInventoryTypeList({
    required String auth,
    int? facilityId,
    int? type,
    bool? isLoading,
  }) async =>
      await connectHelper.getInventoryTypeList(
        auth: auth,
        facilityId: facilityId ?? 0,
        type: type,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> getInventoryStatusList({
    required String auth,
    int? facilityId,
    bool? isLoading,
  }) async =>
      await connectHelper.getInventoryStatusList(
        auth: auth,
        facilityId: facilityId ?? 0,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getCheckPointlist({
    required String auth,
    int? selectedchecklistId,
    bool? isLoading,
  }) async =>
      await connectHelper.getCheckPointlist(
        auth: auth,
        selectedchecklistId: selectedchecklistId ?? 0,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getFacilityList({
    String? auth,
    bool? isLoading,
  }) async =>
      await connectHelper.getFacilityList(
        auth: auth,
        isLoading: isLoading,
      );

  Future<ResponseModel> getBlocksList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async {
    return await connectHelper.getBlocksList(
      auth: auth,
      isLoading: isLoading,
      facilityId: facilityId,
    );
  }

  Future<ResponseModel> getAssetList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async {
    return await connectHelper.getAssetList(
      auth: auth,
      isLoading: isLoading,
      facilityId: facilityId,
    );
  }

  Future<ResponseModel> getInventoryCategoryList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async {
    return await connectHelper.getInventoryCategoryList(
      auth: auth,
      isLoading: isLoading,
      facilityId: facilityId,
    );
  }

  //  Future<ResponseModel> getAffectedPartList({
  //   String? auth,
  //   bool? isLoading,
  //   int? facilityId,
  // }) async {
  //   return await connectHelper.getAffectedPartList(
  //     auth: auth,
  //     isLoading: isLoading,
  //     facilityId: facilityId,
  //   );
  // }

  Future<ResponseModel> getInventoryIsolationList({
    String? auth,
    bool? isLoading,
    int? facilityId,
  }) async {
    return await connectHelper.getInventoryIsolationList(
      auth: auth,
      isLoading: isLoading,
      facilityId: facilityId,
    );
  }

  Future<ResponseModel> getInventoryEquipmentNameList({
    int? facilityId,
    int? blockId,
    required String categoryIds,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getInventoryEquipmentNameList(
      isLoading: isLoading,
      auth: auth,
      facilityId: facilityId,
      blockId: blockId,
      categoryIds: categoryIds,
    );
  }

  Future<ResponseModel> getJobDetails({
    required String auth,
    int? jobId,
    int? userId,
    bool? isLoading,
  }) async =>
      await connectHelper.getJobDetails(
        auth: auth,
        jobId: jobId ?? 0,
        userId: userId,
        isLoading: isLoading,
      );

  ///
  Future<ResponseModel> getPermitList({
    required String auth,
    int? facilityId,
    bool? selfView,
    bool? isLoading,
  }) async =>
      await connectHelper.getPermitList(
        auth: auth,
        facilityId: facilityId,
        selfView: selfView,
        isLoading: isLoading,
      );

  ///
  Future<ResponseModel> getAssignedToList({
    required String auth,
    int? facilityId,
    int? userId,
    bool? isLoading,
  }) async =>
      await connectHelper.getAssignedToList(
        auth: auth,
        facilityId: facilityId,
        userId: userId,
        isLoading: isLoading,
      );

  Future<ResponseModel> getToolsRequiredToWorkTypeList({
    required String auth,
    String? workTypeIds,
    bool? isLoading,
  }) async =>
      await connectHelper.getToolsRequiredToWorkTypeList(
        auth: auth,
        workTypeIds: workTypeIds,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> saveJob({
    required String auth,
    job,
    bool? isLoading,
  }) async =>
      await connectHelper.saveJob(
        auth: auth,
        job: job,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> updateJob({
    required String auth,
    job,
    bool? isLoading,
  }) async =>
      await connectHelper.updateJob(
        auth: auth,
        job: job,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> assignReAssignJob({
    required String auth,
    jobId,
    assignedToId,
    bool? isLoading,
  }) async =>
      await connectHelper.assignReAssignJob(
        auth: auth,
        jobId: jobId,
        assignedToId: assignedToId,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> linkToPermit({
    required String auth,
    jobId,
    permitId,
    bool? isLoading,
  }) async =>
      await connectHelper.linkToPermit(
        auth: auth,
        jobId: jobId,
        permitId: permitId,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> createCheckList({
    auth,
    bool? isLoading,
    checklistJsonString,
  }) async {
    var response = await connectHelper.createCheckList(
        auth: auth,
        isLoading: isLoading,
        checklistJsonString: checklistJsonString);
    return response;
  }

  Future<ResponseModel> createModuleList({
    auth,
    bool? isLoading,
    modulelistJsonString,
  }) async {
    var response = await connectHelper.createModuleList(
        auth: auth,
        isLoading: isLoading,
        modulelistJsonString: modulelistJsonString);
    return response;
  }

  Future<ResponseModel> createCheckpoint({
    auth,
    bool? isLoading,
    checkpointJsonString,
  }) async {
    var response = await connectHelper.createCheckpoint(
        auth: auth,
        isLoading: isLoading,
        checkpointJsonString: checkpointJsonString);
    return response;
  }

  Future<ResponseModel> createNewPermit({
    required String auth,
    newPermit,
    bool? isLoading,
  }) async =>
      await connectHelper.createNewPermit(
        auth: auth,
        newPermit: newPermit,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> updateNewPermit({
    required String auth,
    newPermit,
    bool? isLoading,
  }) async =>
      await connectHelper.updateNewPermit(
        auth: auth,
        newPermit: newPermit,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> createSOP({
    required String auth,
    createSop,
    bool? isLoading,
  }) async =>
      await connectHelper.createSOP(
        auth: auth,
        createSop: createSop,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> createWarrantyClaim({
    required String auth,
    createWarrantyClaim,
    bool? isLoading,
  }) async =>
      await connectHelper.createWarrantyClaim(
        auth: auth,
        createWarrantyClaim: createWarrantyClaim,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> createGoodsOrder({
    required String auth,
    createGo,
    bool? isLoading,
  }) async =>
      await connectHelper.createGoodsOrder(
        auth: auth,
        createGo: createGo,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> updateWarrantyClaim({
    required String auth,
    updateWarrantyClaim,
    bool? isLoading,
  }) async =>
      await connectHelper.updateWarrantyClaim(
        auth: auth,
        updateWarrantyClaim: updateWarrantyClaim,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getNewPermitDetail({
    required String auth,
    bool? isLoading,
    int? permitId,
  }) async =>
      await connectHelper.getNewPermitDetail(
        auth: auth,
        permitId: permitId,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getViewPermitDetail({
    required String auth,
    bool? isLoading,
    int? permitId,
  }) async =>
      await connectHelper.getViewPermitDetail(
        auth: auth,
        permitId: permitId,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getViewWarrantyClaimDetail({
    required String auth,
    bool? isLoading,
    int? wc_id,
  }) async =>
      await connectHelper.getViewWarrantyClaimDetail(
        auth: auth,
        wc_id: wc_id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getInventoryDetail({
    required String auth,
    bool? isLoading,
    int? id,
  }) async =>
      await connectHelper.getInventoryDetail(
        auth: auth,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getAddInventoryDetail({
    required String auth,
    bool? isLoading,
    int? id,
  }) async =>
      await connectHelper.getAddInventoryDetail(
        auth: auth,
        id: id,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getHistory({
    String? auth,
    int? moduleType,
    int? id,
    bool? isLoading,
  }) async {
    return await connectHelper.getHistory(
      auth: auth,
      moduleType: moduleType,
      id: id,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> deleteCkeckpoint({
    auth,
    bool? isLoading,
    check_point_id,
  }) async {
    var response = await connectHelper.deleteCkeckpoint(
        auth: auth, isLoading: isLoading, check_point_id: check_point_id);
    return response;
  }

  Future<ResponseModel> getPermitDetails({
    String? auth,
    int? permitId,
    bool? isLoading,
  }) async {
    return await connectHelper.getPermitDetails(
      auth: auth,
      permitId: permitId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getJobCardHistory({
    String? auth,
    int? jobCardId,
    int? moduleType,
    bool? isLoading,
  }) async {
    return await connectHelper.getJobCardHistory(
      auth: auth,
      moduleType: moduleType,
      jobCardId: jobCardId,
      isLoading: isLoading,
    );
  }

  ///Permit History
  Future<ResponseModel> getPermitHistory({
    String? auth,
    int? permitId,
    int? moduleType,
    bool? isLoading,
  }) async {
    return await connectHelper.getPermitHistory(
      auth: auth,
      moduleType: moduleType,
      permitId: permitId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> updateJobCard({
    String? auth,
    jobCard,
    bool? isLoading,
  }) async {
    return await connectHelper.updateJobCard(
      auth: auth,
      jobCard: jobCard,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> approveJobCard({
    String? auth,
    jobCardId,
    comment,
    bool? isLoading,
  }) async {
    return await connectHelper.approveJobCard(
      auth: auth,
      jobCardId: jobCardId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> rejectJobCard({
    String? auth,
    jobCardId,
    comment,
    bool? isLoading,
  }) async {
    return await connectHelper.rejectJobCard(
      auth: auth,
      jobCardId: jobCardId,
      isLoading: isLoading,
    );
  }

  // Future<ResponseModel> getPreventiveCheckList({
  //   required String auth,
  //   int? facilityId,
  //   int? type,
  //   bool? isLoading,
  // }) async =>
  //     await connectHelper.getPreventiveCheckList(
  //       auth: auth,
  //       facilityId: facilityId ?? 0,
  //       type: type,
  //       isLoading: isLoading ?? false,
  //     );

  // Future<ResponseModel> getCheckPointlist({
  //   required String auth,
  //   int? selectedchecklistId,
  //   bool? isLoading,
  // }) async =>
  //     await connectHelper.getCheckPointlist(
  //       auth: auth,
  //       selectedchecklistId: selectedchecklistId ?? 0,
  //       isLoading: isLoading ?? false,
  //     );

  Future<ResponseModel> getTypePermitList({
    String? auth,
    bool? isLoading,
    int? facility_id,
  }) async =>
      await connectHelper.getTypePermitList(
          auth: auth, isLoading: isLoading, facility_id: facility_id);

  Future<ResponseModel> getUserAccessList({
    required String auth,
    String? userId,
    bool? isLoading,
  }) async =>
      await connectHelper.getUserAccessList(
        auth: auth,
        userId: userId,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> uploadFiles({
    required String auth,
    fileUploadModel,
    bool? isLoading,
  }) async =>
      await connectHelper.uploadFiles(
        auth: auth,
        fileUploadModel: fileUploadModel,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> createJobCard({
    String? auth,
    jobId,
    bool? isLoading,
  }) async =>
      await connectHelper.createJobCard(
        auth: auth,
        jobId: jobId,
        isLoading: isLoading ?? false,
      );

  ///
  Future<ResponseModel> getJobCardDetails({
    String? auth,
    int? jobCardId,
    bool? isLoading,
  }) async {
    return await connectHelper.getJobCardDetails(
      auth: auth,
      jobCardId: jobCardId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getFrequencyList({
    String? auth,
    bool? isLoading,
  }) async {
    return await connectHelper.getFrequencyList(
      auth: auth,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getPmMappingList({
    required String auth,
    int? facilityId,
    bool? isLoading,
  }) async =>
      await connectHelper.getPmMappingList(
        auth: auth,
        facilityId: facilityId ?? 0,
        isLoading: isLoading,
      );
  Future<ResponseModel> savePmMapping({
    required String auth,
    pmJsonString,
    bool? isLoading,
  }) async =>
      await connectHelper.savePmMapping(
        auth: auth,
        pmJsonString: pmJsonString,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> getCalibrationList({
    required String auth,
    int? facilityId,
    bool? isLoading,
  }) async =>
      await connectHelper.getCalibrationList(
        auth: auth,
        facilityId: facilityId ?? 0,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> requestCalibration({
    auth,
    bool? isLoading,
    requestCalibration,
  }) async {
    var response = await connectHelper.requestCalibration(
        auth: auth,
        isLoading: isLoading,
        requestCalibration: requestCalibration);
    return response;
  }

  Future<ResponseModel> rejectRequestCalibration({
    auth,
    bool? isLoading,
    rejectCalibrationtoJsonString,
  }) async {
    var response = await connectHelper.rejectRequestCalibration(
        auth: auth,
        isLoading: isLoading,
        rejectCalibrationtoJsonString: rejectCalibrationtoJsonString);
    return response;
  }

  Future<ResponseModel> approveRequestCalibration({
    auth,
    bool? isLoading,
    approveCalibrationtoJsonString,
  }) async {
    var response = await connectHelper.approveRequestCalibration(
        auth: auth,
        isLoading: isLoading,
        approveCalibrationtoJsonString: approveCalibrationtoJsonString);
    return response;
  }

  Future<ResponseModel> approveCloseCalibration({
    auth,
    bool? isLoading,
    approveCalibrationtoJsonString,
  }) async {
    var response = await connectHelper.approveCloseCalibration(
        auth: auth,
        isLoading: isLoading,
        approveCalibrationtoJsonString: approveCalibrationtoJsonString);
    return response;
  }

  Future<ResponseModel> rejectCloseCalibration({
    auth,
    bool? isLoading,
    rejectCalibrationtoJsonString,
  }) async {
    var response = await connectHelper.rejectCloseCalibration(
        auth: auth,
        isLoading: isLoading,
        rejectCalibrationtoJsonString: rejectCalibrationtoJsonString);
    return response;
  }

  Future<ResponseModel> closeCalibration({
    auth,
    bool? isLoading,
    closeCalibrationtoJsonString,
  }) async {
    var response = await connectHelper.closeCalibration(
        auth: auth,
        isLoading: isLoading,
        closeCalibrationtoJsonString: closeCalibrationtoJsonString);
    return response;
  }

  Future<ResponseModel> completeCalibration({
    auth,
    bool? isLoading,
    completeCalibrationtoJsonString,
  }) async {
    var response = await connectHelper.completeCalibration(
        auth: auth,
        isLoading: isLoading,
        completeCalibrationtoJsonString: completeCalibrationtoJsonString);
    return response;
  }

  Future<ResponseModel> getPMScheduleData({
    required String auth,
    int? facilityId,
    int? selectedEquipmentId,
    bool? isLoading,
  }) async =>
      await connectHelper.getPMScheduleData(
        auth: auth,
        facilityId: facilityId ?? 0,
        selectedEquipmentId: selectedEquipmentId,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> savePmSchedule({
    required String auth,
    pmScheduleJsonString,
    bool? isLoading,
  }) async =>
      await connectHelper.savePmSchedule(
        auth: auth,
        pmScheduleJsonString: pmScheduleJsonString,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> getPmTaskList(
          {required String auth,
          int? facilityId,
          bool? isLoading,
          dynamic startDate,
          dynamic endDate}) async =>
      await connectHelper.getPmTaskList(
          auth: auth,
          facilityId: facilityId ?? 0,
          isLoading: isLoading ?? false,
          startDate: startDate,
          endDate: endDate);
  Future<ResponseModel> getPmtaskViewList({
    String? auth,
    int? scheduleId,
    bool? isLoading,
  }) async {
    return await connectHelper.getPmtaskViewList(
      auth: auth,
      scheduleId: scheduleId,
      isLoading: isLoading,
    );
  }

  Future<CreateSOPModel> browseFiles(
      {required String auth,
      Uint8List? fileBytes,
      required String fileName,
      required bool isLoading}) async {
    return await connectHelper.browseFiles(
      auth: auth,
      fileBytes: fileBytes,
      fileName: fileName,
      isLoading: true,
    );
    // return true;
  }

  Future<ResponseModel> deleteCkecklist({
    auth,
    bool? isLoading,
    checklist_id,
  }) async {
    var response = await connectHelper.deleteCkecklist(
        auth: auth, isLoading: isLoading, checklist_id: checklist_id);
    return response;
  }

  Future<ResponseModel> deleteModulelist({
    auth,
    bool? isLoading,
    module_id,
  }) async {
    var response = await connectHelper.deleteModulelist(
        auth: auth, isLoading: isLoading, module_id: module_id);
    return response;
  }

  Future<ResponseModel> updateChecklistNumber({
    auth,
    bool? isLoading,
    checklistJsonString,
  }) async {
    var response = await connectHelper.updateChecklistNumber(
      auth: auth,
      isLoading: isLoading,
      checklistJsonString: checklistJsonString,
    );
    return response;
  }

  Future<ResponseModel> updateModulelistNumber({
    auth,
    bool? isLoading,
    modulelistJsonString,
  }) async {
    var response = await connectHelper.updateModulelistNumber(
      auth: auth,
      isLoading: isLoading,
      modulelistJsonString: modulelistJsonString,
    );
    return response;
  }

  Future<ResponseModel> updateCheckPoint({
    auth,
    bool? isLoading,
    checkpointJsonString,
  }) async {
    var response = await connectHelper.updateCheckPoint(
        auth: auth,
        isLoading: isLoading,
        checkpointJsonString: checkpointJsonString);
    return response;
  }

  Future<ResponseModel> getCountryList({
    required String auth,
    bool? isLoading,
  }) async {
    return await connectHelper.getCountryList(
      auth: auth,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getBloodList({
    required String auth,
    bool? isLoading,
  }) async {
    return await connectHelper.getBloodList(
      auth: auth,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getStateListnew({
    required String auth,
    bool? isLoading,
    int? selectedCountryId,
  }) async {
    return await connectHelper.getStateListnew(
        auth: auth, isLoading: isLoading, selectedCountryId: selectedCountryId);
  }

  Future<ResponseModel> getCityList({
    required String auth,
    bool? isLoading,
    int? selectedStateId,
  }) async {
    return await connectHelper.getCityList(
        auth: auth, isLoading: isLoading, selectedStateId: selectedStateId);
  }

  Future<ResponseModel> getRoleAccessList({
    String? auth,
    int? roleId,
    bool? isLoading,
  }) async {
    return await connectHelper.getRoleAccessList(
      auth: auth,
      roleId: roleId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getRoleNotificationList({
    String? auth,
    int? roleId,
    bool? isLoading,
  }) async {
    return await connectHelper.getRoleNotificationList(
      auth: auth,
      roleId: roleId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getUserAccessListById({
    String? auth,
    int? userId,
    bool? isLoading,
  }) async {
    return await connectHelper.getUserAccessListById(
      auth: auth,
      userId: userId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getUserNotificationListById({
    String? auth,
    int? userId,
    bool? isLoading,
  }) async {
    return await connectHelper.getUserNotificationListById(
      auth: auth,
      userId: userId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getRoleList({
    required String auth,
    bool? isLoading,
  }) async {
    return await connectHelper.getRoleList(
      auth: auth,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> getUserList({
    required String auth,
    int? facilityId,
    bool? isLoading,
  }) async =>
      await connectHelper.getUserList(
        auth: auth,
        facilityId: facilityId ?? 0,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> getUserDetails({
    String? auth,
    int? userId,
    bool? isLoading,
  }) async {
    return await connectHelper.getUserDetails(
      auth: auth,
      userId: userId,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> saveAccessLevel({
    required String auth,
    accessLevelJsonString,
    bool? isLoading,
  }) async =>
      await connectHelper.saveAccessLevel(
        auth: auth,
        accessLevelJsonString: accessLevelJsonString,
        isLoading: isLoading ?? false,
      );
  Future<ResponseModel> addUser({
    auth,
    bool? isLoading,
    adduserJsonString,
  }) async {
    var response = await connectHelper.addUser(
        auth: auth, isLoading: isLoading, adduserJsonString: adduserJsonString);
    return response;
  }

  Future<ResponseModel> updateUser({
    auth,
    bool? isLoading,
    adduserJsonString,
  }) async {
    var response = await connectHelper.updateUser(
        auth: auth, isLoading: isLoading, adduserJsonString: adduserJsonString);
    return response;
  }

  Future<ResponseModel> getWarrantyTypeList({
    String? auth,
    bool? isLoading,
  }) async {
    return await connectHelper.getWarrantyTypeList(
      auth: auth,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> updatePmExecution({
    required String auth,
    pmExecutionJsonString,
    bool? isLoading,
  }) async =>
      await connectHelper.updatePmExecution(
        auth: auth,
        pmExecutionJsonString: pmExecutionJsonString,
        isLoading: isLoading ?? false,
      );
  Future<AddUserModel> uploadImge(
      {required String auth,
      Uint8List? fileBytes,
      required String fileName,
      required bool isLoading}) async {
    return await connectHelper.uploadImge(
      auth: auth,
      fileBytes: fileBytes,
      fileName: fileName,
      isLoading: true,
    );
    // return true;
  }

  ///
  Future<ResponseModel> getWarrantyUsageTermList({
    String? auth,
    bool? isLoading,
  }) async {
    return await connectHelper.getWarrantyUsageTermList(
      auth: auth,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> createBusinessList({
    auth,
    bool? isLoading,
    businesslistJsonString,
  }) async {
    var response = await connectHelper.createBusinessList(
        auth: auth,
        isLoading: isLoading,
        businesslistJsonString: businesslistJsonString);
    return response;
  }

  Future<ResponseModel> getBusinessTypeList({
    int? businessType,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.getBusinessTypeList(
      isLoading: isLoading,
      auth: auth,
      businessType: businessType,
    );
  }

  Future<ResponseModel> getWarrantyList({
    required String auth,
    int? facilityId,
    int? type,
    bool? isLoading,
  }) async =>
      await connectHelper.getWarrantyList(
        auth: auth,
        facilityId: facilityId ?? 0,
        type: type,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> saveNotification({
    required String auth,
    saveNotificationJsonString,
    bool? isLoading,
  }) async =>
      await connectHelper.saveNotification(
        auth: auth,
        saveNotificationJsonString: saveNotificationJsonString,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> AddInventory({
    auth,
    bool? isLoading,
    addInventoryJsonString,
  }) async {
    var response = await connectHelper.AddInventory(
        auth: auth,
        isLoading: isLoading,
        addInventoryJsonString: addInventoryJsonString);
    return response;
  }

  Future<ResponseModel> updateInventory({
    auth,
    bool? isLoading,
    addInventoryJsonString,
  }) async {
    var response = await connectHelper.updateInventory(
        auth: auth,
        isLoading: isLoading,
        addInventoryJsonString: addInventoryJsonString);
    return response;
  }

  Future<ResponseModel> inventoryList({
    int? facilityId,
    required bool isLoading,
    required String auth,
  }) async {
    return await connectHelper.inventoryList(
      isLoading: isLoading,
      auth: auth,
      facilityId: facilityId,
    );
  }

  Future<ResponseModel> startCalibration({
    auth,
    bool? isLoading,
    calibrationId,
  }) async {
    var response = await connectHelper.startCalibration(
        auth: auth, isLoading: isLoading, calibrationId: calibrationId);
    return response;
  }

  Future<ResponseModel> createFacilityType({
    auth,
    bool? isLoading,
    facilitylistJsonString,
  }) async {
    var response = await connectHelper.createFacilityType(
        auth: auth,
        isLoading: isLoading,
        facilitylistJsonString: facilitylistJsonString);
    return response;
  }

  Future<ResponseModel> createBlockType({
    auth,
    bool? isLoading,
    facilitylistJsonString,
  }) async {
    var response = await connectHelper.createBlockType(
        auth: auth,
        isLoading: isLoading,
        blockTypeJsonString: facilitylistJsonString);
    return response;
  }

  ///
  Future<ResponseModel> getCalibrationView({
    String? auth,
    int? calibrationId,
    bool? isLoading,
  }) async {
    return await connectHelper.getCalibrationView(
      auth: auth,
      calibrationId: calibrationId,
      isLoading: isLoading,
    );
  }

  //end
  Future<ResponseModel> getAssetMasterList({
    required String auth,
    int? facilityId,
    int? type,
    bool? isLoading,
  }) async =>
      await connectHelper.getAssetMasterList(
        auth: auth,
        facilityId: facilityId ?? 0,
        type: type,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> getDesignationList({
    required String auth,
    bool? isLoading,
  }) async {
    return await connectHelper.getDesignationList(
      auth: auth,
      isLoading: isLoading,
    );
  }

  Future<ResponseModel> deleteBusinessList({
    auth,
    bool? isLoading,
    business_id,
  }) async {
    var response = await connectHelper.deleteBusinessList(
        auth: auth, isLoading: isLoading, business_id: business_id);
    return response;
  }

  Future<ResponseModel> updateBusinesslist({
    auth,
    bool? isLoading,
    modulelistJsonString,
  }) async {
    var response = await connectHelper.updateBusinesslist(
      auth: auth,
      isLoading: isLoading,
      modulelistJsonString: modulelistJsonString,
    );
    return response;
  }

  Future<ResponseModel> getCompetencyList({
    required String auth,
    bool? isLoading,
  }) async =>
      await connectHelper.getCompetencyList(
        auth: auth,
        isLoading: isLoading ?? false,
      );

  Future<ResponseModel> createCompetency({
    auth,
    bool? isLoading,
    competencyJsonString,
  }) async {
    var response = await connectHelper.createCompetency(
        auth: auth,
        isLoading: isLoading,
        competencyJsonString: competencyJsonString);
    return response;
  }

  Future<ResponseModel> updateCompetency({
    auth,
    bool? isLoading,
    competencyJsonString,
  }) async {
    var response = await connectHelper.updateCompetency(
      auth: auth,
      isLoading: isLoading,
      competencyJsonString: competencyJsonString,
    );
    return response;
  }
  Future<ResponseModel> deleteCompetencyList({
    auth,
    bool? isLoading,
    checklist_id,
  }) async {
    var response = await connectHelper.deleteCompetencyList(
        auth: auth, isLoading: isLoading, checklist_id: checklist_id);
    return response;
  }

  Future<ResponseModel> createPermitType({
    auth,
    bool? isLoading,
    checklistJsonString,
  }) async {
    var response = await connectHelper.createPermitType(
        auth: auth,
        isLoading: isLoading,
        checklistJsonString: checklistJsonString);
    return response;
  }

  Future<ResponseModel> deletePermitType({
    auth,
    bool? isLoading,
    checklist_id,
  }) async {
    var response = await connectHelper.deletePermitType(
        auth: auth, isLoading: isLoading, checklist_id: checklist_id);
    return response;
  }

  Future<ResponseModel> updatePermitType({
    auth,
    bool? isLoading,
    checklistJsonString,
  }) async {
    var response = await connectHelper.updatePermitType(
      auth: auth,
      isLoading: isLoading,
      checklistJsonString: checklistJsonString,
    );
    return response;
  }
  Future<ResponseModel> createRoleList({
    auth,
    bool? isLoading,
    modulelistJsonString,
  }) async {
    var response = await connectHelper.createRoleList(
        auth: auth,
        isLoading: isLoading,
        modulelistJsonString: modulelistJsonString);
    return response;
  }

  Future<ResponseModel> updateRoleList({
    auth,
    bool? isLoading,
    modulelistJsonString,
  }) async {
    var response = await connectHelper.updateRoleList(
      auth: auth,
      isLoading: isLoading,
      modulelistJsonString: modulelistJsonString,
    );
    return response;
  }

  Future<ResponseModel> deleteRole({
    auth,
    bool? isLoading,
    module_id,
  }) async {
    var response = await connectHelper.deleteRole(
        auth: auth, isLoading: isLoading, module_id: module_id);
    return response;
  }
//end
}
