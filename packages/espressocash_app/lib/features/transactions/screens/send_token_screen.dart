import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../activities/data/transaction_repository.dart';
import '../../activities/models/transaction.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/token_fiat_balance_service.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../outgoing_direct_payments/data/repository.dart';
import '../../outgoing_direct_payments/models/outgoing_direct_payment.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import '../../tokens/token.dart';
import '../services/tx_sender.dart';
import '../widgets/loader_wrapper.dart';

class SendTokenScreen extends StatefulWidget {
  const SendTokenScreen({super.key, required this.token});

  static void push(BuildContext context, {required Token token}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => SendTokenScreen(token: token),
        ),
      );

  final Token token;

  @override
  State<SendTokenScreen> createState() => _SendTokenScreenState();
}

class _SendTokenScreenState extends State<SendTokenScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  double inputAmount = 0;
  double textHeight = 1.2;
  bool visibility = false;

  late Decimal rate;
  @override
  void initState() {
    super.initState();
    rate = sl<ConversionRatesRepository>().readRate(
          CryptoCurrency(token: widget.token),
          to: defaultFiatCurrency,
        ) ??
        Decimal.zero;
  }

  Future<void> _handleOnQrScan() async {
    final code = await context.launchQrForAddress();

    if (code == null) return;
    if (!mounted) return;

    setState(() {
      _recipientController.text = code;
    });
  }

  @override
  Widget build(BuildContext context) => LoadBalancesWrapper(
        builder: (context, onRefresh) {
          onRefresh();
          return ValueStreamBuilder<CryptoFiatAmount>(
            create: () => (
              sl<TokenFiatBalanceService>().readInvestmentBalance(widget.token),
              (
                Amount.zero(currency: Currency.usdc) as CryptoAmount,
                Amount.zero(currency: Currency.usd) as FiatAmount
              )
            ),
            builder: (context, value) {
              final crypto = value.$1;

              final fiatRate =
                  Amount.fromDecimal(value: rate, currency: Currency.usd);

              return Provider<Token>.value(
                value: widget.token,
                child: CpTheme.dark(
                  child: Scaffold(
                    appBar: CpAppBar(
                      title: Text(
                        'Send ${widget.token.symbol}',
                      ),
                    ),
                    backgroundColor: CpColors.dashboardBackgroundColor,
                    body: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.all(23.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            _TokenQuantityInput(
                              quantityController: _quantityController,
                              crypto: crypto,
                              symbol: widget.token.symbol,
                              fiatRate: fiatRate,
                            ),
                            const SizedBox(height: 32),
                            const Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Text(
                                'Recipient',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            CpTextField(
                              padding: const EdgeInsets.only(
                                top: 16,
                                bottom: 16,
                                left: 24,
                                right: 24,
                              ),
                              height: 72,
                              controller: _recipientController,
                              inputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.none,
                              backgroundColor: CpColors.darkBackgroundColor,
                              placeholder: 'Enter a wallet address',
                              placeholderColor: CpColors.secondaryTextColor,
                              textColor: Colors.white,
                              fontSize: 16,
                              multiLine: true,
                              suffix: Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: CpIconButton(
                                  onPressed: _handleOnQrScan,
                                  icon: Assets.icons.qrScanner
                                      .svg(color: Colors.white),
                                  variant: CpIconButtonVariant.inverted,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 100.0,
                                left: 25,
                                right: 25,
                              ),
                              child: CpButton(
                                width: MediaQuery.sizeOf(context).width,
                                alignment: CpButtonAlignment.center,
                                size: CpButtonSize.big,
                                onPressed: () async {
                                  unawaited(
                                    ODPConfirmationScreen.push(
                                      context,
                                      token: widget.token,
                                      initialAmount: _quantityController.text,
                                      isEnabled: false,
                                      recipient: Ed25519HDPublicKey.fromBase58(
                                        _recipientController.text,
                                      ),
                                    ).then((_) async {
                                      Navigator.pop(context);
                                      late String id;
                                      //wip: tx should me mounted first and then sent
                                      widget.token == Token.sol
                                          ? id = (await _sendSolana()).$1.id
                                          : id = (await _sendToken()).$1.id;

                                      if (mounted) {
                                        ODPDetailsScreen.push(context, id: id);
                                      }
                                    }),
                                  );
                                },
                                //  widget.token == Token.sol
                                //     ? _sendSolana
                                //     : _sendToken,
                                text: 'Next',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );

  Future<(SignedTx, BigInt)> _sendToken() async {
    final aReceiver = Ed25519HDPublicKey.fromBase58(_recipientController.text);
    final aSender = sl<ECWallet>().publicKey;
    final amount = (double.parse(_quantityController.text) *
            math.pow(10, widget.token.decimals))
        .toInt();
    final mint = widget.token.publicKey;
    const commitment = Commitment.finalized;

    final shouldCreateAta = !await sl<SolanaClient>().hasAssociatedTokenAccount(
      owner: aReceiver,
      mint: mint,
      commitment: commitment,
    );

    final instructions = <Instruction>[];

    final ataSender = await findAssociatedTokenAddress(
      owner: aSender,
      mint: mint,
    );

    final ataReceiver = await findAssociatedTokenAddress(
      owner: aReceiver,
      mint: mint,
    );

    if (shouldCreateAta) {
      final iCreateATA = AssociatedTokenAccountInstruction.createAccount(
        funder: sl<ECWallet>().publicKey,
        address: ataReceiver,
        owner: aReceiver,
        mint: mint,
      );
      instructions.add(iCreateATA);
    }

    final iTransfer = TokenInstruction.transfer(
      amount: amount,
      source: ataSender,
      destination: ataReceiver,
      owner: aSender,
    );

    instructions.add(iTransfer);

    final message = Message(instructions: instructions);

    final recentBlockhash =
        await sl<SolanaClient>().rpcClient.getLatestBlockhash();

    final compiledMessage = message.compile(
      recentBlockhash: recentBlockhash.value.blockhash,
      feePayer: sl<ECWallet>().publicKey,
    );

    final payloads = [compiledMessage].map(
      (it) => Uint8List.fromList(
        it.toByteArray().toList(),
      ),
    );

    final signatures = await sl<ECWallet>().sign(
      payloads,
    );

    final signedTx = SignedTx(
      signatures: signatures,
      compiledMessage: compiledMessage,
    );

    unawaited(
      sl<ODPRepository>().save(
        OutgoingDirectPayment(
          id: signedTx.id,
          receiver: Ed25519HDPublicKey.fromBase58(
            _recipientController.text,
          ),
          amount: CryptoAmount(
            value: amount,
            cryptoCurrency: CryptoCurrency(token: widget.token),
          ),
          created: DateTime.now(),
          status: ODPStatus.txCreated(
            signedTx,
            slot: recentBlockhash.context.slot,
          ),
        ),
      ),
    );

    unawaited(
      TxSender(client: sl<SolanaClient>())
          .wait(
        signedTx,
        minContextSlot: recentBlockhash.context.slot,
        txType: 'OutgoingDirectPayment',
      )
          .then((_) async {
        unawaited(
          sl<ODPRepository>().save(
            OutgoingDirectPayment(
              id: signedTx.id,
              receiver: Ed25519HDPublicKey.fromBase58(
                _recipientController.text,
              ),
              amount: CryptoAmount(
                value: amount,
                cryptoCurrency: CryptoCurrency(token: widget.token),
              ),
              created: DateTime.now(),
              status: ODPStatus.success(
                txId: signedTx.id,
              ),
            ),
          ),
        );

        unawaited(
          sl<TransactionRepository>().saveAll(
            [
              TxCommon(
                signedTx,
                status: TxCommonStatus.success,
                created: DateTime.now(),
                amount: CryptoAmount(
                  value: -amount,
                  cryptoCurrency: CryptoCurrency(token: widget.token),
                ),
              ),
            ],
            clear: false,
          ),
        );
      }),
    );

    return (signedTx, recentBlockhash.context.slot);
  }

  Future<(SignedTx, BigInt)> _sendSolana() async {
    final amount = (double.parse(_quantityController.text) *
            math.pow(10, widget.token.decimals))
        .toInt();

    final Message message = Message(
      instructions: [
        SystemInstruction.transfer(
          fundingAccount: sl<ECWallet>().publicKey,
          lamports: amount,
          recipientAccount: Ed25519HDPublicKey.fromBase58(
            _recipientController.text,
          ),
        ),
      ],
    );

    final blockhash = await sl<SolanaClient>().rpcClient.getLatestBlockhash();
    final compiledMessage = message.compile(
      recentBlockhash: blockhash.value.blockhash,
      feePayer: sl<ECWallet>().publicKey,
    );

    final payloads = [compiledMessage].map(
      (it) => Uint8List.fromList(
        it.toByteArray().toList(),
      ),
    );

    final signatures = await sl<ECWallet>().sign(
      payloads,
    );

    final signedTx = SignedTx(
      signatures: signatures,
      compiledMessage: compiledMessage,
    );

    unawaited(
      sl<ODPRepository>().save(
        OutgoingDirectPayment(
          id: signedTx.id,
          receiver: Ed25519HDPublicKey.fromBase58(
            _recipientController.text,
          ),
          amount: CryptoAmount(
            value: amount,
            cryptoCurrency: CryptoCurrency(token: widget.token),
          ),
          created: DateTime.now(),
          status: ODPStatus.txCreated(
            signedTx,
            slot: blockhash.context.slot,
          ),
        ),
      ),
    );

    unawaited(
      TxSender(client: sl<SolanaClient>())
          .wait(
        signedTx,
        minContextSlot: blockhash.context.slot,
        txType: 'OutgoingDirectPayment',
      )
          .then((_) async {
        unawaited(
          sl<ODPRepository>().save(
            OutgoingDirectPayment(
              id: signedTx.id,
              receiver: Ed25519HDPublicKey.fromBase58(
                _recipientController.text,
              ),
              amount: CryptoAmount(
                value: amount,
                cryptoCurrency: CryptoCurrency(token: widget.token),
              ),
              created: DateTime.now(),
              status: ODPStatus.success(
                txId: signedTx.id,
              ),
            ),
          ),
        );

        unawaited(
          sl<TransactionRepository>().saveAll(
            [
              TxCommon(
                signedTx,
                status: TxCommonStatus.success,
                created: DateTime.now(),
                amount: CryptoAmount(
                  value: -amount,
                  cryptoCurrency: CryptoCurrency(token: widget.token),
                ),
              ),
            ],
            clear: false,
          ),
        );
      }),
    );

    return (signedTx, blockhash.context.slot);
  }
}

class _TokenQuantityInput extends StatefulWidget {
  const _TokenQuantityInput({
    required TextEditingController quantityController,
    required this.crypto,
    required this.fiatRate,
    required this.symbol,
  }) : _quantityController = quantityController;

  final TextEditingController _quantityController;
  final CryptoAmount crypto;
  final String symbol;
  final Amount fiatRate;

  @override
  State<_TokenQuantityInput> createState() => __TokenQuantityInputState();
}

class __TokenQuantityInputState extends State<_TokenQuantityInput> {
  bool _visibility = false;
  double _textHeight = 1.2;
  final double _fontSize = 34.0;

  @override
  void initState() {
    super.initState();
    widget._quantityController.addListener(_quantityListener);
  }

  void _quantityListener() {
    final isValueValid = widget._quantityController.text.isNotEmpty;

    setState(() {
      if (isValueValid) {
        _textHeight = 0.9;
        _visibility = true;
      } else {
        _textHeight = 1.2;
        _visibility = false;
      }

      //_fontSize = _calculateFontSize(widget._quantityController.text);
    });
  }

  // double _calculateFontSize(String text) {
  //   double fontSize = 34;

  //   final double textWidth = _calculateTextWidth(text, fontSize);

  //   if (textWidth > 245) {
  //     fontSize *= 245 / textWidth;
  //   }

  //   return fontSize;
  // }

  // double _calculateTextWidth(String text, double fontSize) {
  //   final textSpan = TextSpan(
  //     text: text,
  //     style: TextStyle(fontSize: fontSize),
  //   );

  //   final textPainter = TextPainter(
  //     text: textSpan,
  //     maxLines: 1,
  //     textDirection: TextDirection.ltr,
  //   )..layout(minWidth: 0, maxWidth: double.infinity);

  //   return textPainter.size.width;
  // }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          CpTextField(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
            height: 72,
            controller: widget._quantityController,
            inputType: TextInputType.number,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            backgroundColor: CpColors.darkBackgroundColor,
            placeholder: '0 ${widget.symbol}',
            placeholderColor: Colors.white,
            textColor: Colors.white,
            fontSize: _fontSize,
            fontWeight: FontWeight.w700,
            maxLength: 29,
            textHeight: _textHeight,
            suffix: Padding(
              padding: const EdgeInsets.only(right: 14),
              child: CpButton(
                onPressed: _isMax()
                    ? () => widget._quantityController.text = ''
                    : () => widget._quantityController.text =
                        '${widget.crypto.decimal}',
                text: _isMax() ? 'Clear' : 'Max',
                fontSize: 12,
                minWidth: 54,
                size: CpButtonSize.small,
                variant: CpButtonVariant.inverted,
              ),
            ),
          ),
          Visibility(
            visible: _visibility,
            child: Positioned(
              left: 26,
              bottom: 7,
              child: Text(
                r'≈ $' + buildUsdcAmountText,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      );

  String get buildUsdcAmountText =>
      ((num.tryParse(widget._quantityController.text.split(' ')[0]) ?? 1) *
              widget.fiatRate.decimal.toDouble())
          .toStringAsFixed(2);

  bool _isMax() =>
      (num.tryParse(
            widget._quantityController.text,
          ) ??
          -1) ==
      widget.crypto.decimal.toDouble();
}
