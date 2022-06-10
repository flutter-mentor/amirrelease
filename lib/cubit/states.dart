import 'package:medicine_tracker/cubit/cubit.dart';

abstract class MedStates {}

class MedInitialState extends MedStates {}

///

class ChangePasswordBehavior extends MedStates {}

class ChangeAuthBehavior extends MedStates {}

class LoginLoading extends MedStates {}

class LoginError extends MedStates {
  final String error;
  LoginError(this.error);
}

class LoginDone extends MedStates {
  final String uId;
  LoginDone(this.uId);
}

class CreateUserLoading extends MedStates {}

class CreateUserDone extends MedStates {
  final String uid;
  CreateUserDone(this.uid);
}

class SignupDoneState extends MedStates {
  final String uId;
  SignupDoneState(this.uId);
}

class CreateUserError extends MedStates {
  final String error;
  CreateUserError(this.error);
}

class GetUserLoading extends MedStates {}

class GetUserError extends MedStates {
  final String error;
  GetUserError(this.error);
}

class GetUserDone extends MedStates {}

class SignUpLoading extends MedStates {}

class SignUpError extends MedStates {
  final String error;
  SignUpError(this.error);
}

class GetParkerPosition extends MedStates {}

class CalculatedDistance extends MedStates {}

class ChangeBottomBar extends MedStates {}

class SignOutDone extends MedStates {}

class SignOutError extends MedStates {
  final String error;
  SignOutError(this.error);
}

class ChoosedDateTime extends MedStates {}

class InternetConenctionChanged extends MedStates {}

class GetAllPhoneNosLoadingState extends MedStates {}

class GetAllPhoneNosErrorState extends MedStates {
  final String error;
  GetAllPhoneNosErrorState(this.error);
}

class GetAllPhoneNosDone extends MedStates {}

class SendRecoveryLinkDone extends MedStates {}

class SendRecoveryLinkLoading extends MedStates {}

class SendRecoveryLinkError extends MedStates {
  final String error;
  SendRecoveryLinkError(this.error);
}

class AddMedDone extends MedStates {}

class AddMedLoading extends MedStates {}

class AddMedError extends MedStates {
  final String error;
  AddMedError(this.error);
}

class GetMedDone extends MedStates {}

class FoundMedicine extends MedStates {}

class ChangedPageViewIndex extends MedStates {}

class SetTakeTime extends MedStates {}

class AddReminderDone extends MedStates {}

class AddReminderError extends MedStates {
  final String error;
  AddReminderError(this.error);
}

class AddReminderLoading extends MedStates {}

class AddIntakesDone extends MedStates {}

class IntakeTimeSetDone extends MedStates {}

class RemovedIntakeDone extends MedStates {}

class GetMyRemindersDone extends MedStates {}

class GetMyRemindersError extends MedStates {
  final String error;
  GetMyRemindersError(this.error);
}

class GetMyRelativesError extends MedStates {
  final String error;
  GetMyRelativesError(this.error);
}

class GetMyRelativesDone extends MedStates {}

class GetDueReminderDone extends MedStates {}

class GetDueReminderError extends MedStates {
  final String error;
  GetDueReminderError(this.error);
}

class GetAllUsersDone extends MedStates {}

class GetAllUsersError extends MedStates {
  final String error;
  GetAllUsersError(this.error);
}

class FoundRelative extends MedStates {}

class SendRequestLoading extends MedStates {}

class SendRequestError extends MedStates {
  final String error;
  SendRequestError(this.error);
}

class SendRequestDone extends MedStates {}

class GetRequestsDone extends MedStates {}

class GetRequestsError extends MedStates {
  final String error;
  GetRequestsError(this.error);
}

class DeleteRelativeError extends MedStates {
  final String error;
  DeleteRelativeError(this.error);
}

class DeleteRelativeDone extends MedStates {}

class AcceptRequestDone extends MedStates {}

class AcceptRequestError extends MedStates {
  final String error;
  AcceptRequestError(this.error);
}

class UpdateRoutineError extends MedStates {
  final String error;
  UpdateRoutineError(this.error);
}

class UpdateRoutineDone extends MedStates {}

class IntakeUpdateDone extends MedStates {}

class IntakeUpdateError extends MedStates {
  final String error;
  IntakeUpdateError(this.error);
}

class ChangedAuthRules extends MedStates {}

class SelectMedColor extends MedStates {}

class GetRelativeDataError extends MedStates {
  final String error;
  GetRelativeDataError(this.error);
}

class GetRelativeDataDone extends MedStates {}

class ChangeRelativeBottomNavBar extends MedStates {}

class ListenToLocationUpdates extends MedStates {}

class UpdatedLocationDone extends MedStates {}

class UpdatedLocationError extends MedStates {
  final String error;
  UpdatedLocationError(this.error);
}

class DeviceLocationDisabled extends MedStates {}

class UserDeniedAppLocationAtTime extends MedStates {}

class USerDeniedAppLocationForever extends MedStates {}

class UpdateUserDataDone extends MedStates {}

class UpdateUserDataError extends MedStates {
  final String error;
  UpdateUserDataError(this.error);
}

class UpdateUserLoading extends MedStates {}

class ResetReminderError extends MedStates {
  final String error;
  ResetReminderError(this.error);
}

class ResetReminderDone extends MedStates {}

class DeleteReminderDone extends MedStates {}

class DeleteReminderError extends MedStates {
  final String error;
  DeleteReminderError(this.error);
}

class GetMyReminderUpdatesDone extends MedStates {}

class SwapReminderDone extends MedStates {}

class SwapReminderError extends MedStates {
  final String error;
  SwapReminderError(this.error);
}

class SaveNewReminderDone extends MedStates {}

class DeleteUpdateNotfictDone extends MedStates {}

class DeleteUpdateNotfictError extends MedStates {
  final String error;
  DeleteUpdateNotfictError(this.error);
}

class TextExpanded extends MedStates {}

class GetReportsError extends MedStates {
  final String error;
  GetReportsError(this.error);
}

class GetReporsDone extends MedStates {}

class AddFarmacyDone extends MedStates {}

class AddFarmacyError extends MedStates {
  final String error;
  AddFarmacyError(this.error);
}

class GetFarmaciesError extends MedStates {
  final String error;
  GetFarmaciesError(this.error);
}

class GetFarmaciesDone extends MedStates {}

class AddReportDone extends MedStates {}

class AddReportErrorr extends MedStates {
  final String error;
  AddReportErrorr(this.error);
}

class AddedToPdfDone extends MedStates {}

class ChangedProfilePic extends MedStates {}

class UploadPhotoDone extends MedStates {}

class UploadPhotoError extends MedStates {
  final String error;
  UploadPhotoError(this.error);
}

class SetAccountAuthDone extends MedStates {}

class SetAccountAuthError extends MedStates {
  final String error;
  SetAccountAuthError(this.error);
}

class AddMeetingDone extends MedStates {}

class AddMeetingError extends MedStates {
  final String error;
  AddMeetingError(this.error);
}

class GetMeetingsDone extends MedStates {}

class GetMeetingsError extends MedStates {
  final String error;
  GetMeetingsError(this.error);
}

class UploadPhotoLoading extends MedStates {}

class ColorTapped extends MedStates {}
