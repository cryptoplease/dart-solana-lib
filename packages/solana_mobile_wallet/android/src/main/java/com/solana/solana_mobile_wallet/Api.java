package com.solana.solana_mobile_wallet;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression"})
public class Api {
  @NonNull
  private static ArrayList<Object> wrapError(@NonNull Throwable exception) {
    ArrayList<Object> errorList = new ArrayList<Object>(3);
    errorList.add(exception.toString());
    errorList.add(exception.getClass().getSimpleName());
    errorList.add(
      "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    return errorList;
  }

  public enum MobileWalletAdapterServerException {
    REQUEST_DECLINED(0),
    INVALID_PAYLOADS(1),
    TOO_MANY_PAYLOADS(2),
    AUTHORIZATION_NOT_VALID(3),
    NOT_SUBMITTED(4);

    private final int index;

    private MobileWalletAdapterServerException(final int index) {
      this.index = index;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class AuthorizeRequestDto {
    private @Nullable String identityName;

    public @Nullable String getIdentityName() {
      return identityName;
    }

    public void setIdentityName(@Nullable String setterArg) {
      this.identityName = setterArg;
    }

    private @Nullable String identityUri;

    public @Nullable String getIdentityUri() {
      return identityUri;
    }

    public void setIdentityUri(@Nullable String setterArg) {
      this.identityUri = setterArg;
    }

    private @Nullable String iconUri;

    public @Nullable String getIconUri() {
      return iconUri;
    }

    public void setIconUri(@Nullable String setterArg) {
      this.iconUri = setterArg;
    }

    public static final class Builder {

      private @Nullable String identityName;

      public @NonNull Builder setIdentityName(@Nullable String setterArg) {
        this.identityName = setterArg;
        return this;
      }

      private @Nullable String identityUri;

      public @NonNull Builder setIdentityUri(@Nullable String setterArg) {
        this.identityUri = setterArg;
        return this;
      }

      private @Nullable String iconUri;

      public @NonNull Builder setIconUri(@Nullable String setterArg) {
        this.iconUri = setterArg;
        return this;
      }

      public @NonNull AuthorizeRequestDto build() {
        AuthorizeRequestDto pigeonReturn = new AuthorizeRequestDto();
        pigeonReturn.setIdentityName(identityName);
        pigeonReturn.setIdentityUri(identityUri);
        pigeonReturn.setIconUri(iconUri);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(3);
      toListResult.add(identityName);
      toListResult.add(identityUri);
      toListResult.add(iconUri);
      return toListResult;
    }

    static @NonNull AuthorizeRequestDto fromList(@NonNull ArrayList<Object> list) {
      AuthorizeRequestDto pigeonResult = new AuthorizeRequestDto();
      Object identityName = list.get(0);
      pigeonResult.setIdentityName((String) identityName);
      Object identityUri = list.get(1);
      pigeonResult.setIdentityUri((String) identityUri);
      Object iconUri = list.get(2);
      pigeonResult.setIconUri((String) iconUri);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class AuthorizeResultDto {
    private @NonNull byte[] publicKey;

    public @NonNull byte[] getPublicKey() {
      return publicKey;
    }

    public void setPublicKey(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"publicKey\" is null.");
      }
      this.publicKey = setterArg;
    }

    private @Nullable String accountLabel;

    public @Nullable String getAccountLabel() {
      return accountLabel;
    }

    public void setAccountLabel(@Nullable String setterArg) {
      this.accountLabel = setterArg;
    }

    private @Nullable String walletUriBase;

    public @Nullable String getWalletUriBase() {
      return walletUriBase;
    }

    public void setWalletUriBase(@Nullable String setterArg) {
      this.walletUriBase = setterArg;
    }

    private @Nullable byte[] scope;

    public @Nullable byte[] getScope() {
      return scope;
    }

    public void setScope(@Nullable byte[] setterArg) {
      this.scope = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private AuthorizeResultDto() {}

    public static final class Builder {

      private @Nullable byte[] publicKey;

      public @NonNull Builder setPublicKey(@NonNull byte[] setterArg) {
        this.publicKey = setterArg;
        return this;
      }

      private @Nullable String accountLabel;

      public @NonNull Builder setAccountLabel(@Nullable String setterArg) {
        this.accountLabel = setterArg;
        return this;
      }

      private @Nullable String walletUriBase;

      public @NonNull Builder setWalletUriBase(@Nullable String setterArg) {
        this.walletUriBase = setterArg;
        return this;
      }

      private @Nullable byte[] scope;

      public @NonNull Builder setScope(@Nullable byte[] setterArg) {
        this.scope = setterArg;
        return this;
      }

      public @NonNull AuthorizeResultDto build() {
        AuthorizeResultDto pigeonReturn = new AuthorizeResultDto();
        pigeonReturn.setPublicKey(publicKey);
        pigeonReturn.setAccountLabel(accountLabel);
        pigeonReturn.setWalletUriBase(walletUriBase);
        pigeonReturn.setScope(scope);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(4);
      toListResult.add(publicKey);
      toListResult.add(accountLabel);
      toListResult.add(walletUriBase);
      toListResult.add(scope);
      return toListResult;
    }

    static @NonNull AuthorizeResultDto fromList(@NonNull ArrayList<Object> list) {
      AuthorizeResultDto pigeonResult = new AuthorizeResultDto();
      Object publicKey = list.get(0);
      pigeonResult.setPublicKey((byte[]) publicKey);
      Object accountLabel = list.get(1);
      pigeonResult.setAccountLabel((String) accountLabel);
      Object walletUriBase = list.get(2);
      pigeonResult.setWalletUriBase((String) walletUriBase);
      Object scope = list.get(3);
      pigeonResult.setScope((byte[]) scope);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class ReauthorizeRequestDto {
    private @Nullable String identityName;

    public @Nullable String getIdentityName() {
      return identityName;
    }

    public void setIdentityName(@Nullable String setterArg) {
      this.identityName = setterArg;
    }

    private @Nullable String identityUri;

    public @Nullable String getIdentityUri() {
      return identityUri;
    }

    public void setIdentityUri(@Nullable String setterArg) {
      this.identityUri = setterArg;
    }

    private @Nullable String iconRelativeUri;

    public @Nullable String getIconRelativeUri() {
      return iconRelativeUri;
    }

    public void setIconRelativeUri(@Nullable String setterArg) {
      this.iconRelativeUri = setterArg;
    }

    private @NonNull String cluster;

    public @NonNull String getCluster() {
      return cluster;
    }

    public void setCluster(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"cluster\" is null.");
      }
      this.cluster = setterArg;
    }

    private @NonNull byte[] authorizationScope;

    public @NonNull byte[] getAuthorizationScope() {
      return authorizationScope;
    }

    public void setAuthorizationScope(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"authorizationScope\" is null.");
      }
      this.authorizationScope = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private ReauthorizeRequestDto() {}

    public static final class Builder {

      private @Nullable String identityName;

      public @NonNull Builder setIdentityName(@Nullable String setterArg) {
        this.identityName = setterArg;
        return this;
      }

      private @Nullable String identityUri;

      public @NonNull Builder setIdentityUri(@Nullable String setterArg) {
        this.identityUri = setterArg;
        return this;
      }

      private @Nullable String iconRelativeUri;

      public @NonNull Builder setIconRelativeUri(@Nullable String setterArg) {
        this.iconRelativeUri = setterArg;
        return this;
      }

      private @Nullable String cluster;

      public @NonNull Builder setCluster(@NonNull String setterArg) {
        this.cluster = setterArg;
        return this;
      }

      private @Nullable byte[] authorizationScope;

      public @NonNull Builder setAuthorizationScope(@NonNull byte[] setterArg) {
        this.authorizationScope = setterArg;
        return this;
      }

      public @NonNull ReauthorizeRequestDto build() {
        ReauthorizeRequestDto pigeonReturn = new ReauthorizeRequestDto();
        pigeonReturn.setIdentityName(identityName);
        pigeonReturn.setIdentityUri(identityUri);
        pigeonReturn.setIconRelativeUri(iconRelativeUri);
        pigeonReturn.setCluster(cluster);
        pigeonReturn.setAuthorizationScope(authorizationScope);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(5);
      toListResult.add(identityName);
      toListResult.add(identityUri);
      toListResult.add(iconRelativeUri);
      toListResult.add(cluster);
      toListResult.add(authorizationScope);
      return toListResult;
    }

    static @NonNull ReauthorizeRequestDto fromList(@NonNull ArrayList<Object> list) {
      ReauthorizeRequestDto pigeonResult = new ReauthorizeRequestDto();
      Object identityName = list.get(0);
      pigeonResult.setIdentityName((String) identityName);
      Object identityUri = list.get(1);
      pigeonResult.setIdentityUri((String) identityUri);
      Object iconRelativeUri = list.get(2);
      pigeonResult.setIconRelativeUri((String) iconRelativeUri);
      Object cluster = list.get(3);
      pigeonResult.setCluster((String) cluster);
      Object authorizationScope = list.get(4);
      pigeonResult.setAuthorizationScope((byte[]) authorizationScope);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class SignedPayloadsResultDto {
    private @Nullable List<byte[]> payloads;

    public @Nullable List<byte[]> getPayloads() {
      return payloads;
    }

    public void setPayloads(@Nullable List<byte[]> setterArg) {
      this.payloads = setterArg;
    }

    private @Nullable MobileWalletAdapterServerException error;

    public @Nullable MobileWalletAdapterServerException getError() {
      return error;
    }

    public void setError(@Nullable MobileWalletAdapterServerException setterArg) {
      this.error = setterArg;
    }

    private @Nullable List<Boolean> validPayloads;

    public @Nullable List<Boolean> getValidPayloads() {
      return validPayloads;
    }

    public void setValidPayloads(@Nullable List<Boolean> setterArg) {
      this.validPayloads = setterArg;
    }

    public static final class Builder {

      private @Nullable List<byte[]> payloads;

      public @NonNull Builder setPayloads(@Nullable List<byte[]> setterArg) {
        this.payloads = setterArg;
        return this;
      }

      private @Nullable MobileWalletAdapterServerException error;

      public @NonNull Builder setError(@Nullable MobileWalletAdapterServerException setterArg) {
        this.error = setterArg;
        return this;
      }

      private @Nullable List<Boolean> validPayloads;

      public @NonNull Builder setValidPayloads(@Nullable List<Boolean> setterArg) {
        this.validPayloads = setterArg;
        return this;
      }

      public @NonNull SignedPayloadsResultDto build() {
        SignedPayloadsResultDto pigeonReturn = new SignedPayloadsResultDto();
        pigeonReturn.setPayloads(payloads);
        pigeonReturn.setError(error);
        pigeonReturn.setValidPayloads(validPayloads);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(3);
      toListResult.add(payloads);
      toListResult.add(error == null ? null : error.index);
      toListResult.add(validPayloads);
      return toListResult;
    }

    static @NonNull SignedPayloadsResultDto fromList(@NonNull ArrayList<Object> list) {
      SignedPayloadsResultDto pigeonResult = new SignedPayloadsResultDto();
      Object payloads = list.get(0);
      pigeonResult.setPayloads((List<byte[]>) payloads);
      Object error = list.get(1);
      pigeonResult.setError(error == null ? null : MobileWalletAdapterServerException.values()[(int) error]);
      Object validPayloads = list.get(2);
      pigeonResult.setValidPayloads((List<Boolean>) validPayloads);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class SignTransactionsRequestDto {
    private @NonNull List<byte[]> payloads;

    public @NonNull List<byte[]> getPayloads() {
      return payloads;
    }

    public void setPayloads(@NonNull List<byte[]> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"payloads\" is null.");
      }
      this.payloads = setterArg;
    }

    private @Nullable String identityName;

    public @Nullable String getIdentityName() {
      return identityName;
    }

    public void setIdentityName(@Nullable String setterArg) {
      this.identityName = setterArg;
    }

    private @Nullable String identityUri;

    public @Nullable String getIdentityUri() {
      return identityUri;
    }

    public void setIdentityUri(@Nullable String setterArg) {
      this.identityUri = setterArg;
    }

    private @Nullable String iconRelativeUri;

    public @Nullable String getIconRelativeUri() {
      return iconRelativeUri;
    }

    public void setIconRelativeUri(@Nullable String setterArg) {
      this.iconRelativeUri = setterArg;
    }

    private @NonNull String cluster;

    public @NonNull String getCluster() {
      return cluster;
    }

    public void setCluster(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"cluster\" is null.");
      }
      this.cluster = setterArg;
    }

    private @NonNull byte[] authorizationScope;

    public @NonNull byte[] getAuthorizationScope() {
      return authorizationScope;
    }

    public void setAuthorizationScope(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"authorizationScope\" is null.");
      }
      this.authorizationScope = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private SignTransactionsRequestDto() {}

    public static final class Builder {

      private @Nullable List<byte[]> payloads;

      public @NonNull Builder setPayloads(@NonNull List<byte[]> setterArg) {
        this.payloads = setterArg;
        return this;
      }

      private @Nullable String identityName;

      public @NonNull Builder setIdentityName(@Nullable String setterArg) {
        this.identityName = setterArg;
        return this;
      }

      private @Nullable String identityUri;

      public @NonNull Builder setIdentityUri(@Nullable String setterArg) {
        this.identityUri = setterArg;
        return this;
      }

      private @Nullable String iconRelativeUri;

      public @NonNull Builder setIconRelativeUri(@Nullable String setterArg) {
        this.iconRelativeUri = setterArg;
        return this;
      }

      private @Nullable String cluster;

      public @NonNull Builder setCluster(@NonNull String setterArg) {
        this.cluster = setterArg;
        return this;
      }

      private @Nullable byte[] authorizationScope;

      public @NonNull Builder setAuthorizationScope(@NonNull byte[] setterArg) {
        this.authorizationScope = setterArg;
        return this;
      }

      public @NonNull SignTransactionsRequestDto build() {
        SignTransactionsRequestDto pigeonReturn = new SignTransactionsRequestDto();
        pigeonReturn.setPayloads(payloads);
        pigeonReturn.setIdentityName(identityName);
        pigeonReturn.setIdentityUri(identityUri);
        pigeonReturn.setIconRelativeUri(iconRelativeUri);
        pigeonReturn.setCluster(cluster);
        pigeonReturn.setAuthorizationScope(authorizationScope);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(6);
      toListResult.add(payloads);
      toListResult.add(identityName);
      toListResult.add(identityUri);
      toListResult.add(iconRelativeUri);
      toListResult.add(cluster);
      toListResult.add(authorizationScope);
      return toListResult;
    }

    static @NonNull SignTransactionsRequestDto fromList(@NonNull ArrayList<Object> list) {
      SignTransactionsRequestDto pigeonResult = new SignTransactionsRequestDto();
      Object payloads = list.get(0);
      pigeonResult.setPayloads((List<byte[]>) payloads);
      Object identityName = list.get(1);
      pigeonResult.setIdentityName((String) identityName);
      Object identityUri = list.get(2);
      pigeonResult.setIdentityUri((String) identityUri);
      Object iconRelativeUri = list.get(3);
      pigeonResult.setIconRelativeUri((String) iconRelativeUri);
      Object cluster = list.get(4);
      pigeonResult.setCluster((String) cluster);
      Object authorizationScope = list.get(5);
      pigeonResult.setAuthorizationScope((byte[]) authorizationScope);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class SignMessagesRequestDto {
    private @NonNull List<byte[]> payloads;

    public @NonNull List<byte[]> getPayloads() {
      return payloads;
    }

    public void setPayloads(@NonNull List<byte[]> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"payloads\" is null.");
      }
      this.payloads = setterArg;
    }

    private @Nullable String identityName;

    public @Nullable String getIdentityName() {
      return identityName;
    }

    public void setIdentityName(@Nullable String setterArg) {
      this.identityName = setterArg;
    }

    private @Nullable String identityUri;

    public @Nullable String getIdentityUri() {
      return identityUri;
    }

    public void setIdentityUri(@Nullable String setterArg) {
      this.identityUri = setterArg;
    }

    private @Nullable String iconRelativeUri;

    public @Nullable String getIconRelativeUri() {
      return iconRelativeUri;
    }

    public void setIconRelativeUri(@Nullable String setterArg) {
      this.iconRelativeUri = setterArg;
    }

    private @NonNull String cluster;

    public @NonNull String getCluster() {
      return cluster;
    }

    public void setCluster(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"cluster\" is null.");
      }
      this.cluster = setterArg;
    }

    private @NonNull byte[] authorizationScope;

    public @NonNull byte[] getAuthorizationScope() {
      return authorizationScope;
    }

    public void setAuthorizationScope(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"authorizationScope\" is null.");
      }
      this.authorizationScope = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private SignMessagesRequestDto() {}

    public static final class Builder {

      private @Nullable List<byte[]> payloads;

      public @NonNull Builder setPayloads(@NonNull List<byte[]> setterArg) {
        this.payloads = setterArg;
        return this;
      }

      private @Nullable String identityName;

      public @NonNull Builder setIdentityName(@Nullable String setterArg) {
        this.identityName = setterArg;
        return this;
      }

      private @Nullable String identityUri;

      public @NonNull Builder setIdentityUri(@Nullable String setterArg) {
        this.identityUri = setterArg;
        return this;
      }

      private @Nullable String iconRelativeUri;

      public @NonNull Builder setIconRelativeUri(@Nullable String setterArg) {
        this.iconRelativeUri = setterArg;
        return this;
      }

      private @Nullable String cluster;

      public @NonNull Builder setCluster(@NonNull String setterArg) {
        this.cluster = setterArg;
        return this;
      }

      private @Nullable byte[] authorizationScope;

      public @NonNull Builder setAuthorizationScope(@NonNull byte[] setterArg) {
        this.authorizationScope = setterArg;
        return this;
      }

      public @NonNull SignMessagesRequestDto build() {
        SignMessagesRequestDto pigeonReturn = new SignMessagesRequestDto();
        pigeonReturn.setPayloads(payloads);
        pigeonReturn.setIdentityName(identityName);
        pigeonReturn.setIdentityUri(identityUri);
        pigeonReturn.setIconRelativeUri(iconRelativeUri);
        pigeonReturn.setCluster(cluster);
        pigeonReturn.setAuthorizationScope(authorizationScope);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(6);
      toListResult.add(payloads);
      toListResult.add(identityName);
      toListResult.add(identityUri);
      toListResult.add(iconRelativeUri);
      toListResult.add(cluster);
      toListResult.add(authorizationScope);
      return toListResult;
    }

    static @NonNull SignMessagesRequestDto fromList(@NonNull ArrayList<Object> list) {
      SignMessagesRequestDto pigeonResult = new SignMessagesRequestDto();
      Object payloads = list.get(0);
      pigeonResult.setPayloads((List<byte[]>) payloads);
      Object identityName = list.get(1);
      pigeonResult.setIdentityName((String) identityName);
      Object identityUri = list.get(2);
      pigeonResult.setIdentityUri((String) identityUri);
      Object iconRelativeUri = list.get(3);
      pigeonResult.setIconRelativeUri((String) iconRelativeUri);
      Object cluster = list.get(4);
      pigeonResult.setCluster((String) cluster);
      Object authorizationScope = list.get(5);
      pigeonResult.setAuthorizationScope((byte[]) authorizationScope);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class SignAndSendTransactionsRequestDto {
    private @Nullable Long minContextSlot;

    public @Nullable Long getMinContextSlot() {
      return minContextSlot;
    }

    public void setMinContextSlot(@Nullable Long setterArg) {
      this.minContextSlot = setterArg;
    }

    private @NonNull List<byte[]> transactions;

    public @NonNull List<byte[]> getTransactions() {
      return transactions;
    }

    public void setTransactions(@NonNull List<byte[]> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"transactions\" is null.");
      }
      this.transactions = setterArg;
    }

    private @NonNull byte[] publicKey;

    public @NonNull byte[] getPublicKey() {
      return publicKey;
    }

    public void setPublicKey(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"publicKey\" is null.");
      }
      this.publicKey = setterArg;
    }

    private @Nullable String identityName;

    public @Nullable String getIdentityName() {
      return identityName;
    }

    public void setIdentityName(@Nullable String setterArg) {
      this.identityName = setterArg;
    }

    private @Nullable String identityUri;

    public @Nullable String getIdentityUri() {
      return identityUri;
    }

    public void setIdentityUri(@Nullable String setterArg) {
      this.identityUri = setterArg;
    }

    private @Nullable String iconRelativeUri;

    public @Nullable String getIconRelativeUri() {
      return iconRelativeUri;
    }

    public void setIconRelativeUri(@Nullable String setterArg) {
      this.iconRelativeUri = setterArg;
    }

    private @NonNull String cluster;

    public @NonNull String getCluster() {
      return cluster;
    }

    public void setCluster(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"cluster\" is null.");
      }
      this.cluster = setterArg;
    }

    private @NonNull byte[] authorizationScope;

    public @NonNull byte[] getAuthorizationScope() {
      return authorizationScope;
    }

    public void setAuthorizationScope(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"authorizationScope\" is null.");
      }
      this.authorizationScope = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private SignAndSendTransactionsRequestDto() {}

    public static final class Builder {

      private @Nullable Long minContextSlot;

      public @NonNull Builder setMinContextSlot(@Nullable Long setterArg) {
        this.minContextSlot = setterArg;
        return this;
      }

      private @Nullable List<byte[]> transactions;

      public @NonNull Builder setTransactions(@NonNull List<byte[]> setterArg) {
        this.transactions = setterArg;
        return this;
      }

      private @Nullable byte[] publicKey;

      public @NonNull Builder setPublicKey(@NonNull byte[] setterArg) {
        this.publicKey = setterArg;
        return this;
      }

      private @Nullable String identityName;

      public @NonNull Builder setIdentityName(@Nullable String setterArg) {
        this.identityName = setterArg;
        return this;
      }

      private @Nullable String identityUri;

      public @NonNull Builder setIdentityUri(@Nullable String setterArg) {
        this.identityUri = setterArg;
        return this;
      }

      private @Nullable String iconRelativeUri;

      public @NonNull Builder setIconRelativeUri(@Nullable String setterArg) {
        this.iconRelativeUri = setterArg;
        return this;
      }

      private @Nullable String cluster;

      public @NonNull Builder setCluster(@NonNull String setterArg) {
        this.cluster = setterArg;
        return this;
      }

      private @Nullable byte[] authorizationScope;

      public @NonNull Builder setAuthorizationScope(@NonNull byte[] setterArg) {
        this.authorizationScope = setterArg;
        return this;
      }

      public @NonNull SignAndSendTransactionsRequestDto build() {
        SignAndSendTransactionsRequestDto pigeonReturn = new SignAndSendTransactionsRequestDto();
        pigeonReturn.setMinContextSlot(minContextSlot);
        pigeonReturn.setTransactions(transactions);
        pigeonReturn.setPublicKey(publicKey);
        pigeonReturn.setIdentityName(identityName);
        pigeonReturn.setIdentityUri(identityUri);
        pigeonReturn.setIconRelativeUri(iconRelativeUri);
        pigeonReturn.setCluster(cluster);
        pigeonReturn.setAuthorizationScope(authorizationScope);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(8);
      toListResult.add(minContextSlot);
      toListResult.add(transactions);
      toListResult.add(publicKey);
      toListResult.add(identityName);
      toListResult.add(identityUri);
      toListResult.add(iconRelativeUri);
      toListResult.add(cluster);
      toListResult.add(authorizationScope);
      return toListResult;
    }

    static @NonNull SignAndSendTransactionsRequestDto fromList(@NonNull ArrayList<Object> list) {
      SignAndSendTransactionsRequestDto pigeonResult = new SignAndSendTransactionsRequestDto();
      Object minContextSlot = list.get(0);
      pigeonResult.setMinContextSlot((minContextSlot == null) ? null : ((minContextSlot instanceof Integer) ? (Integer) minContextSlot : (Long) minContextSlot));
      Object transactions = list.get(1);
      pigeonResult.setTransactions((List<byte[]>) transactions);
      Object publicKey = list.get(2);
      pigeonResult.setPublicKey((byte[]) publicKey);
      Object identityName = list.get(3);
      pigeonResult.setIdentityName((String) identityName);
      Object identityUri = list.get(4);
      pigeonResult.setIdentityUri((String) identityUri);
      Object iconRelativeUri = list.get(5);
      pigeonResult.setIconRelativeUri((String) iconRelativeUri);
      Object cluster = list.get(6);
      pigeonResult.setCluster((String) cluster);
      Object authorizationScope = list.get(7);
      pigeonResult.setAuthorizationScope((byte[]) authorizationScope);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class SignaturesResultDto {
    private @Nullable List<byte[]> signatures;

    public @Nullable List<byte[]> getSignatures() {
      return signatures;
    }

    public void setSignatures(@Nullable List<byte[]> setterArg) {
      this.signatures = setterArg;
    }

    private @Nullable MobileWalletAdapterServerException error;

    public @Nullable MobileWalletAdapterServerException getError() {
      return error;
    }

    public void setError(@Nullable MobileWalletAdapterServerException setterArg) {
      this.error = setterArg;
    }

    private @Nullable List<Boolean> validSignatures;

    public @Nullable List<Boolean> getValidSignatures() {
      return validSignatures;
    }

    public void setValidSignatures(@Nullable List<Boolean> setterArg) {
      this.validSignatures = setterArg;
    }

    public static final class Builder {

      private @Nullable List<byte[]> signatures;

      public @NonNull Builder setSignatures(@Nullable List<byte[]> setterArg) {
        this.signatures = setterArg;
        return this;
      }

      private @Nullable MobileWalletAdapterServerException error;

      public @NonNull Builder setError(@Nullable MobileWalletAdapterServerException setterArg) {
        this.error = setterArg;
        return this;
      }

      private @Nullable List<Boolean> validSignatures;

      public @NonNull Builder setValidSignatures(@Nullable List<Boolean> setterArg) {
        this.validSignatures = setterArg;
        return this;
      }

      public @NonNull SignaturesResultDto build() {
        SignaturesResultDto pigeonReturn = new SignaturesResultDto();
        pigeonReturn.setSignatures(signatures);
        pigeonReturn.setError(error);
        pigeonReturn.setValidSignatures(validSignatures);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(3);
      toListResult.add(signatures);
      toListResult.add(error == null ? null : error.index);
      toListResult.add(validSignatures);
      return toListResult;
    }

    static @NonNull SignaturesResultDto fromList(@NonNull ArrayList<Object> list) {
      SignaturesResultDto pigeonResult = new SignaturesResultDto();
      Object signatures = list.get(0);
      pigeonResult.setSignatures((List<byte[]>) signatures);
      Object error = list.get(1);
      pigeonResult.setError(error == null ? null : MobileWalletAdapterServerException.values()[(int) error]);
      Object validSignatures = list.get(2);
      pigeonResult.setValidSignatures((List<Boolean>) validSignatures);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class DeauthorizeEventDto {
    private @Nullable String identityName;

    public @Nullable String getIdentityName() {
      return identityName;
    }

    public void setIdentityName(@Nullable String setterArg) {
      this.identityName = setterArg;
    }

    private @Nullable String identityUri;

    public @Nullable String getIdentityUri() {
      return identityUri;
    }

    public void setIdentityUri(@Nullable String setterArg) {
      this.identityUri = setterArg;
    }

    private @Nullable String iconRelativeUri;

    public @Nullable String getIconRelativeUri() {
      return iconRelativeUri;
    }

    public void setIconRelativeUri(@Nullable String setterArg) {
      this.iconRelativeUri = setterArg;
    }

    private @NonNull String cluster;

    public @NonNull String getCluster() {
      return cluster;
    }

    public void setCluster(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"cluster\" is null.");
      }
      this.cluster = setterArg;
    }

    private @NonNull byte[] authorizationScope;

    public @NonNull byte[] getAuthorizationScope() {
      return authorizationScope;
    }

    public void setAuthorizationScope(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"authorizationScope\" is null.");
      }
      this.authorizationScope = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private DeauthorizeEventDto() {}

    public static final class Builder {

      private @Nullable String identityName;

      public @NonNull Builder setIdentityName(@Nullable String setterArg) {
        this.identityName = setterArg;
        return this;
      }

      private @Nullable String identityUri;

      public @NonNull Builder setIdentityUri(@Nullable String setterArg) {
        this.identityUri = setterArg;
        return this;
      }

      private @Nullable String iconRelativeUri;

      public @NonNull Builder setIconRelativeUri(@Nullable String setterArg) {
        this.iconRelativeUri = setterArg;
        return this;
      }

      private @Nullable String cluster;

      public @NonNull Builder setCluster(@NonNull String setterArg) {
        this.cluster = setterArg;
        return this;
      }

      private @Nullable byte[] authorizationScope;

      public @NonNull Builder setAuthorizationScope(@NonNull byte[] setterArg) {
        this.authorizationScope = setterArg;
        return this;
      }

      public @NonNull DeauthorizeEventDto build() {
        DeauthorizeEventDto pigeonReturn = new DeauthorizeEventDto();
        pigeonReturn.setIdentityName(identityName);
        pigeonReturn.setIdentityUri(identityUri);
        pigeonReturn.setIconRelativeUri(iconRelativeUri);
        pigeonReturn.setCluster(cluster);
        pigeonReturn.setAuthorizationScope(authorizationScope);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(5);
      toListResult.add(identityName);
      toListResult.add(identityUri);
      toListResult.add(iconRelativeUri);
      toListResult.add(cluster);
      toListResult.add(authorizationScope);
      return toListResult;
    }

    static @NonNull DeauthorizeEventDto fromList(@NonNull ArrayList<Object> list) {
      DeauthorizeEventDto pigeonResult = new DeauthorizeEventDto();
      Object identityName = list.get(0);
      pigeonResult.setIdentityName((String) identityName);
      Object identityUri = list.get(1);
      pigeonResult.setIdentityUri((String) identityUri);
      Object iconRelativeUri = list.get(2);
      pigeonResult.setIconRelativeUri((String) iconRelativeUri);
      Object cluster = list.get(3);
      pigeonResult.setCluster((String) cluster);
      Object authorizationScope = list.get(4);
      pigeonResult.setAuthorizationScope((byte[]) authorizationScope);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class WalletConfigDto {
    private @NonNull Boolean supportsSignAndSendTransactions;

    public @NonNull Boolean getSupportsSignAndSendTransactions() {
      return supportsSignAndSendTransactions;
    }

    public void setSupportsSignAndSendTransactions(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"supportsSignAndSendTransactions\" is null.");
      }
      this.supportsSignAndSendTransactions = setterArg;
    }

    private @NonNull Long maxTransactionsPerSigningRequest;

    public @NonNull Long getMaxTransactionsPerSigningRequest() {
      return maxTransactionsPerSigningRequest;
    }

    public void setMaxTransactionsPerSigningRequest(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"maxTransactionsPerSigningRequest\" is null.");
      }
      this.maxTransactionsPerSigningRequest = setterArg;
    }

    private @NonNull Long maxMessagesPerSigningRequest;

    public @NonNull Long getMaxMessagesPerSigningRequest() {
      return maxMessagesPerSigningRequest;
    }

    public void setMaxMessagesPerSigningRequest(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"maxMessagesPerSigningRequest\" is null.");
      }
      this.maxMessagesPerSigningRequest = setterArg;
    }

    private @NonNull List<String> supportedTransactionVersions;

    public @NonNull List<String> getSupportedTransactionVersions() {
      return supportedTransactionVersions;
    }

    public void setSupportedTransactionVersions(@NonNull List<String> setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"supportedTransactionVersions\" is null.");
      }
      this.supportedTransactionVersions = setterArg;
    }

    private @NonNull Long noConnectionWarningTimeoutInMs;

    public @NonNull Long getNoConnectionWarningTimeoutInMs() {
      return noConnectionWarningTimeoutInMs;
    }

    public void setNoConnectionWarningTimeoutInMs(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"noConnectionWarningTimeoutInMs\" is null.");
      }
      this.noConnectionWarningTimeoutInMs = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private WalletConfigDto() {}

    public static final class Builder {

      private @Nullable Boolean supportsSignAndSendTransactions;

      public @NonNull Builder setSupportsSignAndSendTransactions(@NonNull Boolean setterArg) {
        this.supportsSignAndSendTransactions = setterArg;
        return this;
      }

      private @Nullable Long maxTransactionsPerSigningRequest;

      public @NonNull Builder setMaxTransactionsPerSigningRequest(@NonNull Long setterArg) {
        this.maxTransactionsPerSigningRequest = setterArg;
        return this;
      }

      private @Nullable Long maxMessagesPerSigningRequest;

      public @NonNull Builder setMaxMessagesPerSigningRequest(@NonNull Long setterArg) {
        this.maxMessagesPerSigningRequest = setterArg;
        return this;
      }

      private @Nullable List<String> supportedTransactionVersions;

      public @NonNull Builder setSupportedTransactionVersions(@NonNull List<String> setterArg) {
        this.supportedTransactionVersions = setterArg;
        return this;
      }

      private @Nullable Long noConnectionWarningTimeoutInMs;

      public @NonNull Builder setNoConnectionWarningTimeoutInMs(@NonNull Long setterArg) {
        this.noConnectionWarningTimeoutInMs = setterArg;
        return this;
      }

      public @NonNull WalletConfigDto build() {
        WalletConfigDto pigeonReturn = new WalletConfigDto();
        pigeonReturn.setSupportsSignAndSendTransactions(supportsSignAndSendTransactions);
        pigeonReturn.setMaxTransactionsPerSigningRequest(maxTransactionsPerSigningRequest);
        pigeonReturn.setMaxMessagesPerSigningRequest(maxMessagesPerSigningRequest);
        pigeonReturn.setSupportedTransactionVersions(supportedTransactionVersions);
        pigeonReturn.setNoConnectionWarningTimeoutInMs(noConnectionWarningTimeoutInMs);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(5);
      toListResult.add(supportsSignAndSendTransactions);
      toListResult.add(maxTransactionsPerSigningRequest);
      toListResult.add(maxMessagesPerSigningRequest);
      toListResult.add(supportedTransactionVersions);
      toListResult.add(noConnectionWarningTimeoutInMs);
      return toListResult;
    }

    static @NonNull WalletConfigDto fromList(@NonNull ArrayList<Object> list) {
      WalletConfigDto pigeonResult = new WalletConfigDto();
      Object supportsSignAndSendTransactions = list.get(0);
      pigeonResult.setSupportsSignAndSendTransactions((Boolean) supportsSignAndSendTransactions);
      Object maxTransactionsPerSigningRequest = list.get(1);
      pigeonResult.setMaxTransactionsPerSigningRequest((maxTransactionsPerSigningRequest == null) ? null : ((maxTransactionsPerSigningRequest instanceof Integer) ? (Integer) maxTransactionsPerSigningRequest : (Long) maxTransactionsPerSigningRequest));
      Object maxMessagesPerSigningRequest = list.get(2);
      pigeonResult.setMaxMessagesPerSigningRequest((maxMessagesPerSigningRequest == null) ? null : ((maxMessagesPerSigningRequest instanceof Integer) ? (Integer) maxMessagesPerSigningRequest : (Long) maxMessagesPerSigningRequest));
      Object supportedTransactionVersions = list.get(3);
      pigeonResult.setSupportedTransactionVersions((List<String>) supportedTransactionVersions);
      Object noConnectionWarningTimeoutInMs = list.get(4);
      pigeonResult.setNoConnectionWarningTimeoutInMs((noConnectionWarningTimeoutInMs == null) ? null : ((noConnectionWarningTimeoutInMs instanceof Integer) ? (Integer) noConnectionWarningTimeoutInMs : (Long) noConnectionWarningTimeoutInMs));
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class AuthIssuerConfigDto {
    private @NonNull String name;

    public @NonNull String getName() {
      return name;
    }

    public void setName(@NonNull String setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"name\" is null.");
      }
      this.name = setterArg;
    }

    private @NonNull Long maxOutstandingTokensPerIdentility;

    public @NonNull Long getMaxOutstandingTokensPerIdentility() {
      return maxOutstandingTokensPerIdentility;
    }

    public void setMaxOutstandingTokensPerIdentility(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"maxOutstandingTokensPerIdentility\" is null.");
      }
      this.maxOutstandingTokensPerIdentility = setterArg;
    }

    private @NonNull Long authorizationValidityInMs;

    public @NonNull Long getAuthorizationValidityInMs() {
      return authorizationValidityInMs;
    }

    public void setAuthorizationValidityInMs(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"authorizationValidityInMs\" is null.");
      }
      this.authorizationValidityInMs = setterArg;
    }

    private @NonNull Long reauthorizationValidityInMs;

    public @NonNull Long getReauthorizationValidityInMs() {
      return reauthorizationValidityInMs;
    }

    public void setReauthorizationValidityInMs(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"reauthorizationValidityInMs\" is null.");
      }
      this.reauthorizationValidityInMs = setterArg;
    }

    private @NonNull Long reauthorizationNopDurationInMs;

    public @NonNull Long getReauthorizationNopDurationInMs() {
      return reauthorizationNopDurationInMs;
    }

    public void setReauthorizationNopDurationInMs(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"reauthorizationNopDurationInMs\" is null.");
      }
      this.reauthorizationNopDurationInMs = setterArg;
    }

    /** Constructor is private to enforce null safety; use Builder. */
    private AuthIssuerConfigDto() {}

    public static final class Builder {

      private @Nullable String name;

      public @NonNull Builder setName(@NonNull String setterArg) {
        this.name = setterArg;
        return this;
      }

      private @Nullable Long maxOutstandingTokensPerIdentility;

      public @NonNull Builder setMaxOutstandingTokensPerIdentility(@NonNull Long setterArg) {
        this.maxOutstandingTokensPerIdentility = setterArg;
        return this;
      }

      private @Nullable Long authorizationValidityInMs;

      public @NonNull Builder setAuthorizationValidityInMs(@NonNull Long setterArg) {
        this.authorizationValidityInMs = setterArg;
        return this;
      }

      private @Nullable Long reauthorizationValidityInMs;

      public @NonNull Builder setReauthorizationValidityInMs(@NonNull Long setterArg) {
        this.reauthorizationValidityInMs = setterArg;
        return this;
      }

      private @Nullable Long reauthorizationNopDurationInMs;

      public @NonNull Builder setReauthorizationNopDurationInMs(@NonNull Long setterArg) {
        this.reauthorizationNopDurationInMs = setterArg;
        return this;
      }

      public @NonNull AuthIssuerConfigDto build() {
        AuthIssuerConfigDto pigeonReturn = new AuthIssuerConfigDto();
        pigeonReturn.setName(name);
        pigeonReturn.setMaxOutstandingTokensPerIdentility(maxOutstandingTokensPerIdentility);
        pigeonReturn.setAuthorizationValidityInMs(authorizationValidityInMs);
        pigeonReturn.setReauthorizationValidityInMs(reauthorizationValidityInMs);
        pigeonReturn.setReauthorizationNopDurationInMs(reauthorizationNopDurationInMs);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(5);
      toListResult.add(name);
      toListResult.add(maxOutstandingTokensPerIdentility);
      toListResult.add(authorizationValidityInMs);
      toListResult.add(reauthorizationValidityInMs);
      toListResult.add(reauthorizationNopDurationInMs);
      return toListResult;
    }

    static @NonNull AuthIssuerConfigDto fromList(@NonNull ArrayList<Object> list) {
      AuthIssuerConfigDto pigeonResult = new AuthIssuerConfigDto();
      Object name = list.get(0);
      pigeonResult.setName((String) name);
      Object maxOutstandingTokensPerIdentility = list.get(1);
      pigeonResult.setMaxOutstandingTokensPerIdentility((maxOutstandingTokensPerIdentility == null) ? null : ((maxOutstandingTokensPerIdentility instanceof Integer) ? (Integer) maxOutstandingTokensPerIdentility : (Long) maxOutstandingTokensPerIdentility));
      Object authorizationValidityInMs = list.get(2);
      pigeonResult.setAuthorizationValidityInMs((authorizationValidityInMs == null) ? null : ((authorizationValidityInMs instanceof Integer) ? (Integer) authorizationValidityInMs : (Long) authorizationValidityInMs));
      Object reauthorizationValidityInMs = list.get(3);
      pigeonResult.setReauthorizationValidityInMs((reauthorizationValidityInMs == null) ? null : ((reauthorizationValidityInMs instanceof Integer) ? (Integer) reauthorizationValidityInMs : (Long) reauthorizationValidityInMs));
      Object reauthorizationNopDurationInMs = list.get(4);
      pigeonResult.setReauthorizationNopDurationInMs((reauthorizationNopDurationInMs == null) ? null : ((reauthorizationNopDurationInMs instanceof Integer) ? (Integer) reauthorizationNopDurationInMs : (Long) reauthorizationNopDurationInMs));
      return pigeonResult;
    }
  }

  public interface Result<T> {
    void success(T result);

    void error(Throwable error);
  }

  private static class ApiFlutterCodec extends StandardMessageCodec {
    public static final ApiFlutterCodec INSTANCE = new ApiFlutterCodec();

    private ApiFlutterCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return AuthorizeRequestDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 129:
          return AuthorizeResultDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 130:
          return DeauthorizeEventDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 131:
          return ReauthorizeRequestDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 132:
          return SignAndSendTransactionsRequestDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 133:
          return SignMessagesRequestDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 134:
          return SignTransactionsRequestDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 135:
          return SignaturesResultDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 136:
          return SignedPayloadsResultDto.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof AuthorizeRequestDto) {
        stream.write(128);
        writeValue(stream, ((AuthorizeRequestDto) value).toList());
      } else if (value instanceof AuthorizeResultDto) {
        stream.write(129);
        writeValue(stream, ((AuthorizeResultDto) value).toList());
      } else if (value instanceof DeauthorizeEventDto) {
        stream.write(130);
        writeValue(stream, ((DeauthorizeEventDto) value).toList());
      } else if (value instanceof ReauthorizeRequestDto) {
        stream.write(131);
        writeValue(stream, ((ReauthorizeRequestDto) value).toList());
      } else if (value instanceof SignAndSendTransactionsRequestDto) {
        stream.write(132);
        writeValue(stream, ((SignAndSendTransactionsRequestDto) value).toList());
      } else if (value instanceof SignMessagesRequestDto) {
        stream.write(133);
        writeValue(stream, ((SignMessagesRequestDto) value).toList());
      } else if (value instanceof SignTransactionsRequestDto) {
        stream.write(134);
        writeValue(stream, ((SignTransactionsRequestDto) value).toList());
      } else if (value instanceof SignaturesResultDto) {
        stream.write(135);
        writeValue(stream, ((SignaturesResultDto) value).toList());
      } else if (value instanceof SignedPayloadsResultDto) {
        stream.write(136);
        writeValue(stream, ((SignedPayloadsResultDto) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated class from Pigeon that represents Flutter messages that can be called from Java. */
  public static final class ApiFlutter {
    private final BinaryMessenger binaryMessenger;

    public ApiFlutter(BinaryMessenger argBinaryMessenger) {
      this.binaryMessenger = argBinaryMessenger;
    }

    /** Public interface for sending reply. */     public interface Reply<T> {
      void reply(T reply);
    }
    /** The codec used by ApiFlutter. */
    static MessageCodec<Object> getCodec() {
      return ApiFlutterCodec.INSTANCE;
    }
    public void onScenarioReady(@NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onScenarioReady", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> callback.reply(null));
    }
    public void onScenarioServingClients(@NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onScenarioServingClients", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> callback.reply(null));
    }
    public void onScenarioServingComplete(@NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onScenarioServingComplete", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> callback.reply(null));
    }
    public void onScenarioComplete(@NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onScenarioComplete", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> callback.reply(null));
    }
    public void onScenarioError(@NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onScenarioError", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> callback.reply(null));
    }
    public void onScenarioTeardownComplete(@NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onScenarioTeardownComplete", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> callback.reply(null));
    }
    public void onLowPowerAndNoConnection(@NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onLowPowerAndNoConnection", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> callback.reply(null));
    }
    public void authorize(@NonNull AuthorizeRequestDto requestArg, @NonNull Long idArg, Reply<AuthorizeResultDto> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.authorize", getCodec());
      channel.send(
          new ArrayList<Object>(Arrays.asList(requestArg, idArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            AuthorizeResultDto output = (AuthorizeResultDto) channelReply;
            callback.reply(output);
          });
    }
    public void reauthorize(@NonNull ReauthorizeRequestDto requestArg, @NonNull Long idArg, Reply<Boolean> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.reauthorize", getCodec());
      channel.send(
          new ArrayList<Object>(Arrays.asList(requestArg, idArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            Boolean output = (Boolean) channelReply;
            callback.reply(output);
          });
    }
    public void signTransactions(@NonNull SignTransactionsRequestDto requestArg, @NonNull Long idArg, Reply<SignedPayloadsResultDto> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.signTransactions", getCodec());
      channel.send(
          new ArrayList<Object>(Arrays.asList(requestArg, idArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            SignedPayloadsResultDto output = (SignedPayloadsResultDto) channelReply;
            callback.reply(output);
          });
    }
    public void signMessages(@NonNull SignMessagesRequestDto requestArg, @NonNull Long idArg, Reply<SignedPayloadsResultDto> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.signMessages", getCodec());
      channel.send(
          new ArrayList<Object>(Arrays.asList(requestArg, idArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            SignedPayloadsResultDto output = (SignedPayloadsResultDto) channelReply;
            callback.reply(output);
          });
    }
    public void signAndSendTransactions(@NonNull SignAndSendTransactionsRequestDto requestArg, @NonNull Long idArg, Reply<SignaturesResultDto> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.signAndSendTransactions", getCodec());
      channel.send(
          new ArrayList<Object>(Arrays.asList(requestArg, idArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            SignaturesResultDto output = (SignaturesResultDto) channelReply;
            callback.reply(output);
          });
    }
    public void deauthorize(@NonNull DeauthorizeEventDto eventArg, @NonNull Long idArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.deauthorize", getCodec());
      channel.send(
          new ArrayList<Object>(Arrays.asList(eventArg, idArg)),
          channelReply -> callback.reply(null));
    }
    public void onNewIntent(@NonNull Boolean isInitialIntentArg, Reply<Void> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.onNewIntent", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(isInitialIntentArg)),
          channelReply -> callback.reply(null));
    }
    public void getWalletConfig(@NonNull Long idArg, Reply<WalletConfigDto> callback) {
      BasicMessageChannel<Object> channel =
          new BasicMessageChannel<>(
              binaryMessenger, "dev.flutter.pigeon.ApiFlutter.getWalletConfig", getCodec());
      channel.send(
          new ArrayList<Object>(Collections.singletonList(idArg)),
          channelReply -> {
            @SuppressWarnings("ConstantConditions")
            WalletConfigDto output = (WalletConfigDto) channelReply;
            callback.reply(output);
          });
    }
  }

  private static class ApiHostCodec extends StandardMessageCodec {
    public static final ApiHostCodec INSTANCE = new ApiHostCodec();

    private ApiHostCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return AuthIssuerConfigDto.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 129:
          return WalletConfigDto.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof AuthIssuerConfigDto) {
        stream.write(128);
        writeValue(stream, ((AuthIssuerConfigDto) value).toList());
      } else if (value instanceof WalletConfigDto) {
        stream.write(129);
        writeValue(stream, ((WalletConfigDto) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface ApiHost {

    void start(@NonNull Long id);

    void close(@NonNull Long id);

    void createScenario(@NonNull Long id, @NonNull WalletConfigDto walletConfig, @NonNull AuthIssuerConfigDto authIssuerConfig, Result<byte[]> result);

    void getWalletConfig(@NonNull Long id, Result<WalletConfigDto> result);

    /** The codec used by ApiHost. */
    static MessageCodec<Object> getCodec() {
      return ApiHostCodec.INSTANCE;
    }
    /**Sets up an instance of `ApiHost` to handle messages through the `binaryMessenger`. */
    static void setup(BinaryMessenger binaryMessenger, ApiHost api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.ApiHost.start", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  assert args != null;
                  Number idArg = (Number) args.get(0);
                  if (idArg == null) {
                    throw new NullPointerException("idArg unexpectedly null.");
                  }
                  api.start((idArg == null) ? null : idArg.longValue());
                  wrapped.add(0, null);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.ApiHost.close", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  assert args != null;
                  Number idArg = (Number) args.get(0);
                  if (idArg == null) {
                    throw new NullPointerException("idArg unexpectedly null.");
                  }
                  api.close((idArg == null) ? null : idArg.longValue());
                  wrapped.add(0, null);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.ApiHost.createScenario", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  assert args != null;
                  Number idArg = (Number) args.get(0);
                  if (idArg == null) {
                    throw new NullPointerException("idArg unexpectedly null.");
                  }
                  WalletConfigDto walletConfigArg = (WalletConfigDto) args.get(1);
                  if (walletConfigArg == null) {
                    throw new NullPointerException("walletConfigArg unexpectedly null.");
                  }
                  AuthIssuerConfigDto authIssuerConfigArg = (AuthIssuerConfigDto) args.get(2);
                  if (authIssuerConfigArg == null) {
                    throw new NullPointerException("authIssuerConfigArg unexpectedly null.");
                  }
                  Result<byte[]> resultCallback = 
                      new Result<byte[]>() {
                        public void success(byte[] result) {
                          wrapped.add(0, result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          ArrayList<Object> wrappedError = wrapError(error);
                          reply.reply(wrappedError);
                        }
                      };

                  api.createScenario((idArg == null) ? null : idArg.longValue(), walletConfigArg, authIssuerConfigArg, resultCallback);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  reply.reply(wrappedError);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.ApiHost.getWalletConfig", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                try {
                  ArrayList<Object> args = (ArrayList<Object>) message;
                  assert args != null;
                  Number idArg = (Number) args.get(0);
                  if (idArg == null) {
                    throw new NullPointerException("idArg unexpectedly null.");
                  }
                  Result<WalletConfigDto> resultCallback = 
                      new Result<WalletConfigDto>() {
                        public void success(WalletConfigDto result) {
                          wrapped.add(0, result);
                          reply.reply(wrapped);
                        }

                        public void error(Throwable error) {
                          ArrayList<Object> wrappedError = wrapError(error);
                          reply.reply(wrappedError);
                        }
                      };

                  api.getWalletConfig((idArg == null) ? null : idArg.longValue(), resultCallback);
                } catch (Error | RuntimeException exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  reply.reply(wrappedError);
                }
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
}
