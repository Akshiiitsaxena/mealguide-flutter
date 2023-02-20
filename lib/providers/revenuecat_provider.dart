import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mealguide/helper/keys.dart';
import 'package:mealguide/helper/mg_exception.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final revenueCatProvider = Provider((ref) => RevenueCatProvider());

class RevenueCatProvider {
  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;

    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(Keys.revenueCatAppKey);
      await Purchases.configure(configuration);
    }
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
      print(info.activeSubscriptions);
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        throw MgException(message: e.message);
      }
    }
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

  Future<void> logIn(String id) async {
    final info = await Purchases.logIn(id);
    print(info.customerInfo.toJson());
  }

  Future<void> logOut() async {
    await Purchases.logOut();
  }
}
