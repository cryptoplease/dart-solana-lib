import 'package:solana/src/base58/base58.dart';
import 'package:solana/src/edwards25519/edwards_25519.dart';

/// Returns true if [address] is a valid ed25519 point encoded
/// to base58
bool isValidAddress(String address) {
  try {
    final List<int> data = decode(address);
    if (data.length != 32) {
      return false;
    }
    final CompressedEdwardsY compressedEdwardsY = CompressedEdwardsY(data);
    final EdwardsPoint edwardsPoint = compressedEdwardsY.decompress();
    return !edwardsPoint.isSmallOrder();
  } on Exception {
    return false;
  }
}
