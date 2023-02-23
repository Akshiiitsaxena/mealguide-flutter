import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/keys.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:mealguide/providers/auth_provider.dart';
import 'package:mealguide/providers/tab_provider.dart';
import 'package:mealguide/providers/user_diary_provider.dart';
import 'package:mealguide/providers/user_state_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final revenueCatProvider = Provider((ref) => RevenueCatProvider(ref));

class RevenueCatProvider {
  ProviderRef ref;

  RevenueCatProvider(this.ref);

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.error);

    PurchasesConfiguration configuration;

    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(Keys.revenueCatAppKey);
      await Purchases.configure(configuration);
    }

    setPremiumStateIfActive();
  }

  Future<List<Package>> getPackages() async {
    List<Package> packages = [];
    try {
      final offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        packages.addAll(offerings.current!.availablePackages);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
    return packages;
  }

  Future<void> purchasePackage(Package package) async {
    try {
      CustomerInfo info = await Purchases.purchasePackage(package);
      if (info.activeSubscriptions.isNotEmpty) {
        ref.read(userStateNotifierProvider.notifier).setHasPremium(true);
        ref.read(tabControllerProvider).goToTab(tab: 1);

        Map<dynamic, dynamic> data = {};
        data['premium'] = true;
        data['original_purchase_date'] = await getOriginalPurchaseDate();

        ref.read(authProvider).syncUserState(data);
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        throw MgException(message: e.message);
      }
    }
  }

  Future<void> setPremiumStateIfActive() async {
    final hasPremium = await hasAnySubscription();
    ref.read(userStateNotifierProvider.notifier).setHasPremium(hasPremium);
    ref.read(authProvider).syncUserState({'premium': hasPremium});
  }

  Future<bool> hasAnySubscription() async {
    final info = await Purchases.getCustomerInfo();
    return info.activeSubscriptions.isNotEmpty;
  }

  Future<void> setName(String name) async {
    await Purchases.setDisplayName(name);
  }

  Future<void> setEmail(String email) async {
    await Purchases.setEmail(email);
  }

  Future<void> setNumber(String number) async {
    await Purchases.setPhoneNumber(number);
  }

  Future<void> setFCM(String token) async {
    await Purchases.setPushToken(token);
  }

  Future<String?> getOriginalPurchaseDate() async {
    return (await Purchases.getCustomerInfo()).originalPurchaseDate;
  }

  Future<void> logIn(String id) async {
    final info = await Purchases.logIn(id);
    print(info.customerInfo.toJson());
  }

  Future<void> logOut() async {
    await Purchases.logOut();
  }
}
