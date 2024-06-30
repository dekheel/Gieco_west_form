// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdManager {
//   static BannerAd? bannerAd;
//   static InterstitialAd? interstitialAd;
//   static AppOpenAd? appOpenAd;
//   static RewardedAd? rewardedAd;
//
//   static bool isBannerAdLoaded = false;
//   static bool isOpenAdLoaded = false;
//
//   static bool isTest = true;
//
//   // TODO: replace this test ad unit with your own ad unit.
//   static final adBannerId = isTest
//       ? 'ca-app-pub-3940256099942544/6300978111'
//       : 'ca-app-pub-7908902393785602/6686644221';
//
//   static final adInterstitialId = isTest
//       ? 'ca-app-pub-3940256099942544/1033173712'
//       : 'ca-app-pub-7908902393785602/4266147408';
//
//   static final adOpenId = isTest
//       ? 'ca-app-pub-3940256099942544/9257395921'
//       : 'ca-app-pub-7908902393785602/5476121448';
//
//   static final adRewardedId =
//       isTest ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-7908902393785602/4224966568';
//
//   /// Loads a banner ad.
//   static void loadBannerAd(void setStateRebuild, {required AdSize adSize}) {
//     bannerAd = BannerAd(
//       adUnitId: adBannerId,
//       request: const AdRequest(),
//       size: adSize,
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           isBannerAdLoaded = true;
//           setStateRebuild;
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, err) {
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }
//
//   static void loadInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: adInterstitialId,
//         request: const AdRequest(),
//         adLoadCallback: InterstitialAdLoadCallback(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             // Keep a reference to the ad so you can show it later.
//             interstitialAd = ad;
//             if (interstitialAd != null) {
//               interstitialAd!.show();
//             }
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (LoadAdError error) {
//             interstitialAd!.dispose();
//           },
//         ));
//   }
//
//   static void loadOpenAd() {
//     AppOpenAd.load(
//       adUnitId: adOpenId,
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           appOpenAd = ad;
//           if (appOpenAd != null) {
//             appOpenAd!.show();
//           }
//         },
//         onAdFailedToLoad: (error) {
//           appOpenAd!.dispose();
//         },
//       ),
//       request: const AdRequest(),
//     );
//   }
//
//   static void loadRewardedAd() {
//     RewardedAd.load(
//         adUnitId: adRewardedId,
//         request: const AdRequest(),
//         rewardedAdLoadCallback: RewardedAdLoadCallback(
//           onAdLoaded: (ad) {
//             rewardedAd = ad;
//             rewardedAd?.show(
//               onUserEarnedReward: (ad, reward) {
//                 // rewarded
//               },
//             );
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             rewardedAd!.dispose();
//           },
//         ));
//   }
// }
