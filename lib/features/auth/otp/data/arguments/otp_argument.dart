class OTPArgument {
  final int? userId;
  final String email;
  final bool isRegisterOTP;
  OTPArgument({required this.email, required this.isRegisterOTP, this.userId});
}
