import 'dart:async' show Completer;
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import '../helpers/log.dart';

@lazySingleton
class AdManager {
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;

  BannerAd? get bannerAd => _bannerAd;

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      final rewardedAdUnitId = dotenv.get('REWARDED_AD_ID');
      return rewardedAdUnitId;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          LogManager.instance.i('RewardedAd loaded.');
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedAd = null;
          LogManager.instance.e('RewardedAd failed to load', error);
        },
      ),
    );
  }

  /// Shows a rewarded ad and returns a Future<bool> indicating if the user earned the reward.
  Future<bool> showRewardedAd() async {
    final completer = Completer<bool>();

    if (_rewardedAd == null) {
      LogManager.instance.w('Rewarded ad is not ready yet.');
      loadRewardedAd(); // Pre-load another for next time
      return false;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadRewardedAd();
        // If ad is dismissed before reward, complete with false
        if (!completer.isCompleted) {
          completer.complete(false);
        }
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        loadRewardedAd();
        LogManager.instance.e('Failed to show RewardedAd', err);
        if (!completer.isCompleted) {
          completer.complete(false);
        }
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        LogManager.instance.i('User earned reward: ${reward.amount}');
        // When reward is earned, complete with true
        if (!completer.isCompleted) {
          completer.complete(true);
        }
      },
    );

    _rewardedAd = null;
    return completer.future;
  }

  void disposeAds() {
    _rewardedAd?.dispose();
    LogManager.instance.i('Rewarded ad disposed.');
  }
}
