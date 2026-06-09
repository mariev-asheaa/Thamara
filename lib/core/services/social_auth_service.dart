import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialAuthResult {
  final String token;
  final String provider;

  SocialAuthResult({
    required this.token,
    required this.provider,
  });
}

class SocialAuthService {
  SocialAuthService._();

  static final SocialAuthService instance =
  SocialAuthService._();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<SocialAuthResult?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId:
        '1039880044021-4r8nt0i5fl5dniq3aa182r1706sb3h86.apps.googleusercontent.com',
      );

      final GoogleSignInAccount user = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication auth = await user.authentication;
      final token = auth.idToken;

      if (token == null) return null;

      return SocialAuthResult(token: token, provider: "google");
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }

  Future<SocialAuthResult?> signInWithFacebook() async {
    try {
      final LoginResult result =
      await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final token = result.accessToken?.tokenString;

        if (token == null) return null;

        return SocialAuthResult(
          token: token,
          provider: "facebook",
        );
      }

      if (result.status == LoginStatus.cancelled) {
        return null;
      }

      throw Exception(result.message ?? "Facebook login failed");
    } catch (e) {
      throw Exception("Facebook Sign-In failed: $e");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
  }
}