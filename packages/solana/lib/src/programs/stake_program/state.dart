import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/encoder.dart';

abstract class StakeAuthorize {
  const factory StakeAuthorize.staker(Ed25519HDPublicKey pubKey) =
      StakerAuthority;

  const factory StakeAuthorize.withdrawer(Ed25519HDPublicKey pubKey) =
      WithdrawerAuthority;

  Ed25519HDPublicKey get pubKey;

  ByteArray serialize();
}

class StakerAuthority implements StakeAuthorize {
  const StakerAuthority(this.pubKey) : type = 0;

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        pubKey.toBuffer(),
        Buffer.fromUint32(type),
      ]);

  final Ed25519HDPublicKey pubKey;
  final int type;
}

class WithdrawerAuthority implements StakeAuthorize {
  const WithdrawerAuthority(this.pubKey) : type = 1;

  ByteArray serialize() => Buffer.fromConcatenatedByteArrays([
        pubKey.toBuffer(),
        Buffer.fromUint32(type),
      ]);

  final Ed25519HDPublicKey pubKey;
  final int type;
}

typedef Epoch = int;
typedef UnixTimestamp = int;
