import 'package:pigeon/pigeon.dart';

class AccountDto {
  const AccountDto({
    required this.id,
    required this.name,
    required this.derivationPath,
    required this.publicKeyEncoded,
    required this.isUserWallet,
    required this.isValid,
  });

  final int id;
  final String name;
  final String derivationPath;
  final String publicKeyEncoded;
  final bool isUserWallet;
  final bool isValid;
}

class SeedDto {
  const SeedDto({
    required this.authToken,
    required this.name,
    required this.purpose,
    required this.accounts,
  });

  final int authToken;
  final String name;
  final int purpose;
  final List<AccountDto?> accounts;
}

class ImplementationLimitsDto {
  const ImplementationLimitsDto({
    required this.maxBip32PathDepth,
    required this.maxSigningRequests,
    required this.maxRequestedSignatures,
    required this.maxRequestedPublicKeys,
  });

  final int maxBip32PathDepth;
  final int? maxSigningRequests;
  final int? maxRequestedSignatures;
  final int? maxRequestedPublicKeys;
}

class BipLevelDto {
  const BipLevelDto({
    required this.index,
    required this.hardened,
  });

  final int index;
  final bool hardened;
}

class Bip44DerivationDto {
  const Bip44DerivationDto({
    required this.account,
    required this.change,
    required this.addressIndex,
  });

  final BipLevelDto? account;
  final BipLevelDto? change;
  final BipLevelDto? addressIndex;
}

class SigningRequestDto {
  SigningRequestDto({
    required this.payload,
    required this.requestedSignatures,
  });

  final Uint8List payload;
  final List<String?> requestedSignatures;
}

class SigningResponseDto {
  SigningResponseDto({
    required this.signatures,
    required this.resolvedDerivationPaths,
  });

  final List<Uint8List?> signatures;
  final List<String?> resolvedDerivationPaths;
}

@HostApi()
abstract class WalletApiHost {
  @async
  int authorizeSeed(int purpose);

  @async
  int createSeed(int purpose);

  @async
  int importSeed(int purpose);

  @async
  List<SigningResponseDto> signMessages(
    int authToken,
    List<SigningRequestDto> signingRequests,
  );

  @async
  List<SigningResponseDto> signTransactions(
    int authToken,
    List<SigningRequestDto> signingRequests,
  );

  ImplementationLimitsDto getImplementationLimitsForPurpose(int purpose);

  bool hasUnauthorizedSeedsForPurpose(int purpose);

  List<SeedDto> getAuthorizedSeeds();

  List<AccountDto> getAccounts(int authToken, bool isUserWalletOnly);

  String resolveDerivationPath(String derivationPath, int purpose);

  void deauthorizeSeed(int authToken);

  void updateAccountName(int authToken, int accountId, String? name);

  void updateAccountIsUserWallet(
    int authToken,
    int accountId,
    bool isUserWallet,
  );

  void updateAccountIsValid(
    int authToken,
    int accountId,
    bool isValid,
  );
}

@HostApi()
abstract class Bip32ApiHost {
  List<BipLevelDto> fromUri(String uri);

  String toUri(List<BipLevelDto> levels);
}

@HostApi()
abstract class Bip44ApiHost {
  Bip44DerivationDto fromUri(String uri);

  String toUri(Bip44DerivationDto levels);
}

@HostApi()
abstract class SeedVaultApiHost {
  bool isAvailable(bool allowSimulated);

  @async
  bool checkPermission();
}
