library memo_program;

import 'package:solana/src/encoder/encoder.dart';

part 'memo_instruction.dart';

class MemoProgram extends Message {
  /// Construct a [memo program][memo program] with [signers] and [memo].
  ///
  /// [memo program]: https://spl.solana.com/memo
  ///
  /// Please note that there's a limit on the length of the [memo] string, which
  /// otherwise is an arbitrary string of utf-8 data.
  ///
  /// The limit as [specified in this document][memo limit] is 566 bytes.
  ///
  /// [memo limit](https://spl.solana.com/memo#compute-limits)
  MemoProgram({
    required List<String> signers,
    required String memo,
  }) : super(
          instructions: [
            MemoInstruction(
              signers: signers,
              memo: memo,
            )
          ],
        );

  static const programId = 'MemoSq4gqABAXKb96qnH8TysNcWxMyWCqXgDLGmfcHr';
}
