part of 'token_program.dart';

class TokenInstruction extends Instruction {
  const TokenInstruction._({
    required List<AccountMeta> accounts,
    required Iterable<int> data,
  }) : super(
          programId: TokenProgram.programId,
          accounts: accounts,
          data: data,
        );

  factory TokenInstruction.initializeMint({
    required String mint,
    required String mintAuthority,
    required int decimals,
    String? freezeAuthority,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: Buffer.fromConcatenatedByteArrays([
          TokenProgram.initializeMintInstructionIndex,
          Buffer.fromUint8(decimals),
          Buffer.fromBase58(mintAuthority),
          Buffer.fromUint8(freezeAuthority != null ? 1 : 0),
          if (freezeAuthority != null)
            Buffer.fromBase58(freezeAuthority)
          else
            List<int>.filled(32, 0),
        ]),
      );

  factory TokenInstruction.initializeAccount({
    required String mint,
    required String address,
    required String owner,
  }) =>
      TokenInstruction._(
        accounts: [
          AccountMeta.writeable(pubKey: address, isSigner: true),
          AccountMeta.readonly(pubKey: mint, isSigner: false),
          AccountMeta.readonly(pubKey: owner, isSigner: false),
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: TokenProgram.initializeAccountInstructionIndex,
      );
}
