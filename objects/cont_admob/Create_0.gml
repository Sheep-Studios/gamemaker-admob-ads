/// @description Initialize variables

// Initialize variables
interstitial_loaded = false;
rewarded_loaded = false;
rewarded_watched = false;
use_test_ads = true;

load_fail_delay = room_speed * 4; // Amount of time to wait after a failed ad load to load a new ad (shorter times may lag device)

// Initialize ad codes
if(os_type == os_ios) {
	// Initialize ad codes for iOS
	app_id = "ca-app-pub-7710053540336814~2171222300";		// This is a dummy app ID, make sure you add in your real one!
	banner_id = "ca-app-pub-3940256099942544/6300978111";
	interstitial_id = "ca-app-pub-3940256099942544/1033173712";
	rewarded_id = "ca-app-pub-3940256099942544/5224354917";
}
else {
	// Initialize ad codes for Android (or Amazon Fire)
	app_id = "ca-app-pub-7710053540336814~2171222300";		// This is a dummy app ID, make sure you add in your real one!
	banner_id = "ca-app-pub-3940256099942544/6300978111";
	interstitial_id = "ca-app-pub-3940256099942544/1033173712";
	rewarded_id = "ca-app-pub-3940256099942544/5224354917";
}

// Ensure AdMob is only being initialized if is a mobile device
if(is_mobile()) {
	// Initialize Google Mobile Ads SDK
	GoogleMobileAds_Init(interstitial_id, app_id);

	// Attempt to load interstitial and rewarded video ads
	GoogleMobileAds_LoadInterstitial();
	GoogleMobileAds_LoadRewardedVideo(rewarded_id);
	
	// Use test ads?
	GoogleMobileAds_UseTestAds(use_test_ads, "my_device_id"); // Note: see guide for how to find your device ID
}