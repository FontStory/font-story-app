import 'dart:async';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';

import '../helpers/log.dart';

@lazySingleton
class AdManager {
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  bool _isRewardedLoading = false;

  BannerAd? get bannerAd => _bannerAd;

  static String get rewardedAdUnitId {
    if (dotenv.get('NO_ADS', fallback: 'false') == 'true') {
      throw UnsupportedError('Ads are disabled by NO_ADS flag.');
    }

    if (Platform.isAndroid) return dotenv.get('REWARDED_AD_ID_ANDROID');
    if (Platform.isIOS) return dotenv.get('REWARDED_AD_ID_IOS');
    throw UnsupportedError('Unsupported platform');
  }

  static String get bannerAdUnitId {
    if (dotenv.get('NO_ADS', fallback: 'false') == 'true') {
      throw UnsupportedError('Ads are disabled by NO_ADS flag.');
    }

    if (Platform.isAndroid) return dotenv.get('BANNER_AD_ID_ANDROID');
    if (Platform.isIOS) return dotenv.get('BANNER_AD_ID_IOS');
    throw UnsupportedError('Unsupported platform');
  }

  void loadRewardedAd() {
    if (_isRewardedLoading ||
        dotenv.get('NO_ADS', fallback: 'false') == 'true') {
      return;
    }

    _isRewardedLoading = true;

    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isRewardedLoading = false;
          LogManager.instance.i('RewardedAd loaded.');
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          _isRewardedLoading = false;
          LogManager.instance.e('RewardedAd failed to load', error);
        },
      ),
    );
  }

  Future<bool> showRewardedAd() async {
    if (dotenv.get('NO_ADS', fallback: 'false') == 'true') return false;

    if (_rewardedAd == null) {
      LogManager.instance.w('Rewarded ad is not ready yet.');
      loadRewardedAd();
      return false;
    }

    final completer = Completer<bool>();

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadRewardedAd();
        if (!completer.isCompleted) completer.complete(false);
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        loadRewardedAd();
        LogManager.instance.e('Failed to show RewardedAd', err);
        if (!completer.isCompleted) completer.complete(false);
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        LogManager.instance.i('User earned reward: ${reward.amount}');
        if (!completer.isCompleted) completer.complete(true);
      },
    );

    _rewardedAd = null;
    return completer.future;
  }

  void loadBannerAd({AdSize size = AdSize.banner}) {
    if (dotenv.get('NO_ADS', fallback: 'false') == 'true') return;

    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => LogManager.instance.i('BannerAd loaded.'),
        onAdFailedToLoad: (ad, err) {
          LogManager.instance.e('BannerAd failed to load', err);
          ad.dispose();
        },
        onAdOpened: (ad) => LogManager.instance.i('BannerAd opened.'),
        onAdClosed: (ad) => LogManager.instance.i('BannerAd closed.'),
      ),
    )..load();
  }

  void disposeAds() {
    _rewardedAd?.dispose();
    _bannerAd?.dispose();
    _rewardedAd = null;
    _bannerAd = null;
    LogManager.instance.i('All ads disposed.');
  }
}
