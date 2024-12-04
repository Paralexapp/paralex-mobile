import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/navs.dart';
import '../services/api_service.dart';

class BailBondServiceController extends GetxController {
  final ApiService _apiService = ApiService(); // Instance of ApiService

  // TextEditingControllers for all fields
  var totalAmount = TextEditingController();
  var discountAmount = TextEditingController();
  var courtId = TextEditingController();
  var investigatingAgency = TextEditingController();
  var fullName = TextEditingController();
  var nickName = TextEditingController();
  var phoneNumber = TextEditingController();
  var workPhoneNumber = TextEditingController();
  var currentHomeAddress = TextEditingController();
  var residenceAddress = TextEditingController();
  var email = TextEditingController();
  var durationOfStay = TextEditingController();
  var nameOfLandlord = TextEditingController();
  var howLongInCurrentState = TextEditingController();
  var howLongInResidingCity = TextEditingController();
  var formerResidentAddress = TextEditingController();
  var dateOfBirth = TextEditingController();
  var placeOfBirth = TextEditingController();
  var gender = TextEditingController();
  var tribe = TextEditingController();
  var nationality = TextEditingController();
  var nin = TextEditingController();
  var internationalPassportNumber = TextEditingController();
  var height = TextEditingController();
  var weight = TextEditingController();
  var eyeColor = TextEditingController();
  var arrestingAgency = TextEditingController();
  var detentionFacilityLocation = TextEditingController();
  var charges = TextEditingController();
  var chargeAmount = TextEditingController();
  var lastArrestingAgency = TextEditingController();
  var lastArrestCharges = TextEditingController();
  var pendingChargesInJurisdiction = TextEditingController();
  var detailsOfBond = TextEditingController();
  var currentEmployerName = TextEditingController();
  var durationOfEmployment = TextEditingController();
  var position = TextEditingController();
  var supervisorName = TextEditingController();
  var supervisorWorkPhone = TextEditingController();
  var formerEmployerName = TextEditingController();
  var durationOfFormerEmployment = TextEditingController();
  var formerPosition = TextEditingController();
  var formerSupervisorName = TextEditingController();
  var formerSupervisorWorkPhone = TextEditingController();
  var maritalStatus = TextEditingController();
  var dateOfCurrentArrest = TextEditingController();
  var dateOfLastArrest = TextEditingController();
  var occupation1 = TextEditingController();
  var occupation2 = TextEditingController();
  var occupation3 = TextEditingController();
  var occupation4 = TextEditingController();
  var occupation5 = TextEditingController();
  var employerName = TextEditingController();
  var legalFirmName = TextEditingController();

  // Nested structure fields
  var spouseName = TextEditingController();
  var spouseDurationOfMarriage = TextEditingController();
  var spouseAddress = TextEditingController();
  var spouseHomePhone = TextEditingController();
  var spouseMobilePhone = TextEditingController();
  var spouseWorkPhone = TextEditingController();
  var spouseNin = TextEditingController();
  var spouseDriversLicense = TextEditingController();
  var spouseInternationalPassport = TextEditingController();
  var spouseOccupation = TextEditingController();
  var spouseEmployer = TextEditingController();
  var spouseDurationOfEmployment = TextEditingController();
  var spouseSupervisorName = TextEditingController();
  var memberOfAnyGroup = TextEditingController();
  var durationInYears = TextEditingController();

  //vehicleDetails not on the ui
  var vehicleYear = TextEditingController();
  var vehicleMake = TextEditingController();
  var vehicleModel = TextEditingController();
  var vehiclePlateNumber = TextEditingController();
  var vehicleState = TextEditingController();
  var vehicleInsurance = TextEditingController();
  var vehicleColor = TextEditingController();

  //landDetails not on the ui
  var landAddress = TextEditingController();
  var landState = TextEditingController();
  var dateOfPurchase = TextEditingController();
  var landCertificateNumber = TextEditingController();

  // TextEditingControllers for travelOutsideJurisdiction fields
  final travelLast = TextEditingController();
  final travelDuration = TextEditingController();
  final travelDestination = TextEditingController();
  final travelNextPlanned = TextEditingController();
  final travelNextDestination = TextEditingController();
  final travelNextOut = TextEditingController();
  final travelNextOutDestination = TextEditingController();

  // TextEditingControllers for thirdPartyBondGuarantor fields
  final guarantorName = TextEditingController();
  final guarantorAddress = TextEditingController();
  final guarantorCurrentEmployer = TextEditingController();
  final guarantorCurrentEmployerAddress = TextEditingController();
  final guarantorNationalIdentityNumber = TextEditingController();
  final guarantorInternationalPassport = TextEditingController();
  final guarantorDriversLicense = TextEditingController();
  final guarantorTaxIdentityNumber = TextEditingController();

  // Observables for toggles
  var hasBike = true.obs; // Example checkbox toggle
  var physicallyChallenged = true.obs;
  var memberOfSocialGroup = true.obs;
  var existingBailBond = true.obs;
  var failedToAppearInCourt = true.obs;
  var enjoyedSuretyBond = true.obs;
  var agreeToTermsAndConditions = true.obs;
  var changeFilColor = false.obs;

  @override
  void onInit() {
    super.onInit();
    chargeAmount.addListener(() {
      updateDiscountAmount();
    });
  }

  void updateDiscountAmount() {
    try {
      if (chargeAmount.text.isNotEmpty) {
        changeFilColor.value = true;
      } else {
        changeFilColor.value = false;
      }
      // Parse the total amount to double
      double total = double.tryParse(chargeAmount.text) ?? 0.0;

      // Calculate 10% discount
      double discount = total * 0.1;

      // Update the discountAmount text
      totalAmount.text = (total + discount).toInt().toString();
      discountAmount.text = totalAmount.text;
    } catch (e) {
      discountAmount.text = "0.00"; // Default value in case of error
    }
  }

  void navigateToBondStep2() {
    Get.toNamed(Nav.bondStepB);
  }

  void navigateToBondStep3() {
    Get.toNamed(Nav.bondStepC);
  }

  void navigateToBondStep4() {
    Get.toNamed(Nav.bondStepD);
  }

  void navigateToBondStep5() {
    Get.toNamed(Nav.bondStepE);
  }

  Future<void> summitBailBondDetails() async {
    var data = {
      "totalAmount": totalAmount.text,
      "courtId": legalFirmName.text,
      "investigatingAgency": investigatingAgency.text,
      "fullName": fullName.text,
      "nickName": nickName.text,
      "phoneNumber": phoneNumber.text,
      "workPhoneNumber": workPhoneNumber.text,
      "currentHomeAddress": currentHomeAddress.text,
      "residenceAddress": currentHomeAddress.text,
      "email": email.text,
      "durationOfStay": durationOfStay.text,
      "nameOfLandlord": nameOfLandlord.text,
      "howLongInCurrentState": howLongInCurrentState.text,
      "howLongInResidingCity": howLongInResidingCity.text,
      "formerResidentAddress": formerResidentAddress.text,
      "dateOfBirth": dateOfBirth.text,
      "placeOfBirth": placeOfBirth.text,
      "gender": gender.text,
      "tribe": tribe.text, //not on the ui
      "nationality": nationality.text,
      "nin": nin.text,
      "internationalPassportNumber": internationalPassportNumber.text,
      "height": height.text,
      "weight": weight.text,
      "eyeColor": eyeColor.text,
      "physicallyChallenged": physicallyChallenged.value,
      "memberOfSocialGroup": memberOfSocialGroup.value,
      "dateOfCurrentArrest": dateOfCurrentArrest.text,
      "arrestingAgency": arrestingAgency.text,
      "detentionFacilityLocation": detentionFacilityLocation.text,
      "charges": charges.text,
      "chargeAmount": int.tryParse(chargeAmount.text) ?? 0,
      "dateOfLastArrest": dateOfLastArrest.text,
      "lastArrestingAgency": lastArrestingAgency.text,
      "lastArrestCharges": lastArrestCharges.text,
      "existingBailBond": existingBailBond.value,
      "pendingChargesInJurisdiction": pendingChargesInJurisdiction.text,
      "failedToAppearInCourt": failedToAppearInCourt.value,
      "enjoyedSuretyBond": enjoyedSuretyBond.value,
      "detailsOfBond": detailsOfBond.text,
      "occupations": [
        {
          "employerName": employerName.text,
          "position": position.text,
          "durationInYears": durationInYears.text,
        },
      ],
      "currentEmployerName": currentEmployerName.text,
      "durationOfEmployment": durationOfEmployment.text,
      "position": position.text,
      "supervisorName": supervisorName.text,
      "supervisorWorkPhone": supervisorWorkPhone.text,
      "formerEmployerName": formerEmployerName.text,
      "durationOfFormerEmployment": durationOfFormerEmployment.text,
      "formerPosition": formerPosition.text,
      "formerSupervisorName": formerSupervisorName.text,
      "formerSupervisorWorkPhone": formerSupervisorWorkPhone.text,
//   "maritalStatus": maritalStatus.text,
      "spouseDetails": {
        "name": spouseName.text,
        "durationOfMarriage": spouseDurationOfMarriage.text,
        "address": spouseAddress.text,
        "homePhone": spouseHomePhone.text,
        "mobilePhone": spouseMobilePhone.text,
        "workPhone": spouseWorkPhone.text,
        "nin": spouseNin.text,
        "driversLicense": spouseDriversLicense.text,
        "internationalPassport": spouseInternationalPassport.text,
        "occupation": spouseOccupation.text,
        "employer": spouseEmployer.text,
        "durationOfEmployment": spouseDurationOfEmployment.text,
        "supervisorName": spouseSupervisorName.text,
      },
      "vehicleDetails": [
        {
          "year": vehicleYear.text,
          "make": vehicleMake.text,
          "model": vehicleModel.text,
          "color": vehicleColor.text,
          "plateNumber": vehiclePlateNumber.text,
          "state": vehicleState.text,
          "insuranceCompanyOrAgent": vehicleInsurance.text,
        }
      ],
      "landDetails": [
        {
          "address": landAddress.text,
          "state": landState.text,
          "dateOfPurchase": '2024-11-30', // Ensure the correct format is used
          "certificateNumber": landCertificateNumber.text,
        }
      ],
      "legalPractitioner": {
        "representativeName": fullName.text,
        "nameOfFirm": legalFirmName.text,
        "address": currentHomeAddress.text,
        "phoneNumber": workPhoneNumber.text,
      },
      "nextOfKinDetails": {
        "name": spouseName.text,
        "relationship": 'Brother',
        "homePhone": spouseMobilePhone.text,
        "workPhone": spouseWorkPhone.text,
        "email": email.text,
        "nationalIdentityNumber": spouseNin.text,
        "driversLicense": spouseDriversLicense.text,
        "internationalPassport": spouseInternationalPassport.text,
        "homeAddress": spouseAddress.text,
        "occupation": spouseOccupation.text,
        "currentEmployer": 'string',
        "currentEmployerAddress": 'ss',
        "supervisorsName": 'string',
        "supervisorsPhoneNumber": 'string',
      },
      "travelOutsideJurisdiction": {
        "lastTravelOutsideJurisdiction": travelLast.text,
        "durationOfTrip": travelDuration.text,
        "destination": travelDestination.text,
        "nextPlannedTripOutsideJurisdiction": travelNextPlanned.text,
        "destinationOfPlannedTrip": travelNextDestination.text,
        "nextOutOfCountryTrip": travelNextOut.text,
        "nextOutOfCountryDestination": travelNextOutDestination.text,
      },
      "thirdPartyBondGuarantor": {
        "name": guarantorName.text,
        "currentAddress": guarantorAddress.text,
        "currentEmployer": currentEmployerName.text,
        "currentEmployerAddress": guarantorCurrentEmployer.text,
        "nationalIdentityNumber": guarantorNationalIdentityNumber.text,
        "internationalPassport": guarantorInternationalPassport.text,
        "driversLicense": guarantorDriversLicense.text,
        "taxIdentityNumber": guarantorTaxIdentityNumber.text
      },
      "iagreeToTermsAndConditions": agreeToTermsAndConditions.value,
    };

    try {
      final response = await _apiService.postRequest('bail-bond/', data);

      Get.toNamed(Nav.bondSubmitted);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to register. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
      throw Exception('Failed to register: ${e}}');
    }
  }

  @override
  void dispose() {
    // Dispose of all controllers when the controller is removed
    totalAmount.dispose();
    courtId.dispose();
    investigatingAgency.dispose();
    fullName.dispose();
    nickName.dispose();
    phoneNumber.dispose();
    workPhoneNumber.dispose();
    currentHomeAddress.dispose();
    residenceAddress.dispose();
    email.dispose();
    durationOfStay.dispose();
    nameOfLandlord.dispose();
    howLongInCurrentState.dispose();
    howLongInResidingCity.dispose();
    formerResidentAddress.dispose();
    dateOfBirth.dispose();
    placeOfBirth.dispose();
    gender.dispose();
    tribe.dispose();
    nationality.dispose();
    nin.dispose();
    internationalPassportNumber.dispose();
    height.dispose();
    weight.dispose();
    eyeColor.dispose();
    arrestingAgency.dispose();
    detentionFacilityLocation.dispose();
    charges.dispose();
    chargeAmount.dispose();
    lastArrestingAgency.dispose();
    lastArrestCharges.dispose();
    pendingChargesInJurisdiction.dispose();
    detailsOfBond.dispose();
    currentEmployerName.dispose();
    durationOfEmployment.dispose();
    position.dispose();
    supervisorName.dispose();
    supervisorWorkPhone.dispose();
    formerEmployerName.dispose();
    durationOfFormerEmployment.dispose();
    formerPosition.dispose();
    formerSupervisorName.dispose();
    formerSupervisorWorkPhone.dispose();
    maritalStatus.dispose();
    spouseName.dispose();
    spouseDurationOfMarriage.dispose();
    spouseAddress.dispose();
    spouseHomePhone.dispose();
    spouseMobilePhone.dispose();
    spouseWorkPhone.dispose();
    spouseNin.dispose();
    spouseDriversLicense.dispose();
    spouseInternationalPassport.dispose();
    spouseOccupation.dispose();
    spouseEmployer.dispose();
    spouseDurationOfEmployment.dispose();
    spouseSupervisorName.dispose();
    super.dispose();
  }
}
