abstract class RelativeStates {}

class RelativeInitState extends RelativeStates {}

class GetMyPatientsDone extends RelativeStates {}

class GetMyPatientsError extends RelativeStates {
  final String error;
  GetMyPatientsError(this.error);
}

class ChangeRelativeBottomNavBar extends RelativeStates {}

class GetMyPatientReminderDone extends RelativeStates {}

class GetPatientDataDone extends RelativeStates {}

class AcceptRequestDone extends RelativeStates {}

class AcceptRequestError extends RelativeStates {
  final String error;
  AcceptRequestError(this.error);
}

class FetchedPatientLocationDone extends RelativeStates {}

class FetchedPatientLocationError extends RelativeStates {
  final String error;
  FetchedPatientLocationError(this.error);
}

class UpdatedMyPatientIntakeDone extends RelativeStates {}

class UpdatedMyPatientIntakeError extends RelativeStates {
  final String error;
  UpdatedMyPatientIntakeError(this.error);
}

class SetUpdateMedicineData extends RelativeStates {}

class SoundModeDetected extends RelativeStates {}

class AddIntakeForPatient extends RelativeStates {}

class RemoveIntakeForPatient extends RelativeStates {}

class SendUpdateNotfictDone extends RelativeStates {}

class SendUpdateNotfictError extends RelativeStates {
  final String error;
  SendUpdateNotfictError(this.error);
}

class SendUpdateNotfictLoading extends RelativeStates {}

class GetPatientReportDone extends RelativeStates {}
