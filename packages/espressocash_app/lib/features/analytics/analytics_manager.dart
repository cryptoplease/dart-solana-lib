import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import '../ramp_partner/models/ramp_partner.dart';

@lazySingleton
class AnalyticsManager {
  const AnalyticsManager(this._analytics);

  final Mixpanel _analytics;

  void swapTransactionCreated({
    required String from,
    required String to,
    required int amount,
  }) =>
      _analytics.track(
        'swapTransactionCreated',
        properties: {
          'from': from,
          'to': to,
          'amount': amount,
        },
      );

  void setWalletAddress(String? address) {
    if (address == null) {
      _analytics.reset();
    } else {
      _analytics.identify(address);
      _analytics.getPeople().set('walletAddress', address);
    }
  }

  void setStellarAddress(String? address) {
    _analytics.getPeople().set('stellarWalletAddress', address);
  }

  void setUsdcBalance(Decimal value) {
    _analytics.getPeople().set('usdcBalance', value.toDouble());
  }

  void setTotalInvestmentsBalance(Decimal value) {
    _analytics.getPeople().set('investmentsBalance', value.toDouble());
  }

  void setProfileCountryCode(String countryCode) {
    _analytics.getPeople().set('profileCountryCode', countryCode);
  }

  void singleLinkCreated({
    required Decimal amount,
  }) =>
      _analytics.track(
        'singleLinkCreated',
        properties: {'amount': amount.toDouble()},
      );

  void singleLinkCanceled({
    required Decimal amount,
  }) =>
      _analytics.track(
        'singleLinkCanceled',
        properties: {'amount': amount.toDouble()},
      );

  void singleLinkReceived() => _analytics.track('singleLinkReceived');

  void directPaymentSent({
    required Decimal amount,
  }) =>
      _analytics.track(
        'directPaymentSent',
        properties: {'amount': amount.toDouble()},
      );

  void paymentRequestLinkCreated({
    required Decimal amount,
  }) =>
      _analytics.track(
        'paymentRequestLinkCreated',
        properties: {'amount': amount.toDouble()},
      );

  void paymentRequestLinkPaid({
    required Decimal amount,
  }) =>
      _analytics.track(
        'paymentRequestLinkPaid',
        properties: {'amount': amount.toDouble()},
      );

  void rampOpened({
    required RampPartner partner,
    required String rampType,
  }) =>
      _analytics.track(
        'rampOpened',
        properties: {
          'partner': partner.name,
          'type': rampType,
        },
      );

  void rampInitiated({
    required RampPartner partner,
    required String rampType,
    required String? amount,
    required String countryCode,
    required String id,
  }) =>
      _analytics.track(
        'rampStarted',
        properties: {
          'partner': partner.name,
          'type': rampType,
          'amount': amount,
          'countryCode': countryCode,
          'id': id,
        },
      );

  void rampCompleted({
    required RampPartner partner,
    required String rampType,
    required String id,
  }) =>
      _analytics.track(
        'rampCompleted',
        properties: {
          'partner': partner.name,
          'type': rampType,
          'id': id,
        },
      );

  void ataCreated() => _analytics.track('ataCreated');
}
