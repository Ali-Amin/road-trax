enum AuthState {
  Initial,
  SmsSent,
  UserDoesNotExist,
  Authenticated,
  PhoneLoginLoading,
  SmsVerificationLoading,
  PhoneLoginError,
  SmsVerificationError,
}
