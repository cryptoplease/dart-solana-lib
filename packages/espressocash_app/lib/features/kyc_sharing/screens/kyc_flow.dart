import 'package:flutter/material.dart';
import 'package:solana/dto.dart';

import '../../../di.dart';
import '../data/kyc_repository.dart';
import 'basic_information_screen.dart';
import 'email_verification_screen.dart';
import 'identity_verification_screen.dart';
import 'phone_verification_screen.dart';

class KycFlow {
  static void open(BuildContext context) {
    final kycRepository = sl<KycRepository>();

    IdentityVerificationScreen.push(context);

    // // if (!kycRepository.hasPassedKyc) {
    // //   BasicInformationScreen.push(context);
    // // } else 
    // if (!kycRepository.hasValidatedEmail) {
    //   EmailVerificationScreen.push(context);
    // } else if (!kycRepository.hasValidatedPhone) {
    //   PhoneVerificationScreen.push(context);
    // }
  }
}
