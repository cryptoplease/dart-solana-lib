import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/byte_array.dart';

part 'address_lookup_state.dart';

const int _lookupTableMetaSize = 56;

class AddressLookupTableAccount {
  AddressLookupTableAccount({
    required this.key,
    required this.state,
  });

  final Ed25519HDPublicKey key;
  final AddressLookupTableState state;

  bool isActive() {
    final BigInt u64Max = BigInt.parse('0xffffffffffffffff');

    return state.deactivationSlot == u64Max;
  }

  static AddressLookupTableState deserialize(ByteArray accountData) {
    final input = Uint8List.fromList(accountData.toList());
    final reader = BinaryReader(input.buffer.asByteData());

    final typeIndex = reader.readU32();

    if (typeIndex != 1) {
      throw Exception(
        'invalid account data; account type mismatch $typeIndex != 1',
      );
    }

    final deactivationSlot = reader.readU64();
    final lastExtendedSlot = reader.readU64();
    final lastExtendedStartIndex = reader.readU8();
    final authority = reader
        .readFixedArray(
          1,
          () => reader.readFixedArray(32, reader.readU8),
        )
        .map(Ed25519HDPublicKey.new)
        .toList();

    final int serializedAddressesLen =
        accountData.length - _lookupTableMetaSize;
    assert(serializedAddressesLen >= 0, 'lookup table is invalid');
    assert(serializedAddressesLen % 32 == 0, 'lookup table is invalid');

    final int numSerializedAddresses = serializedAddressesLen ~/ 32;

    final r = BinaryReader(
      Uint8List.fromList(accountData.toList().sublist(_lookupTableMetaSize))
          .buffer
          .asByteData(),
    );

    final addresses = r
        .readFixedArray(
          numSerializedAddresses,
          () => reader.readFixedArray(32, reader.readU8),
        )
        .map(Ed25519HDPublicKey.new)
        .toList();

    return AddressLookupTableState(
      deactivationSlot: deactivationSlot,
      lastExtendedSlot: lastExtendedSlot.toInt(),
      lastExtendedSlotStartIndex: lastExtendedStartIndex,
      authority: authority.isNotEmpty ? authority.first : null,
      addresses: addresses,
    );
  }
}
