import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tokenProvider = Provider(
  (ref) => TokenManager(ref),
);

class TokenManager {
  final ProviderRef ref;

  TokenManager(this.ref);

  Future<String?> getToken() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return null;
    }

    return await FirebaseAuth.instance.currentUser!.getIdToken();
  }
}
