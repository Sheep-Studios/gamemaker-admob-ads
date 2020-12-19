/*
	Critical functions needed for use of program
*/
	
// Shows an interstitial ad if loaded
function show_interstitial() {
	with(cont_admob) {
		// Check if interstitial is loaded
		if(interstitial_loaded) {
			GoogleMobileAds_ShowInterstitial(); // Show the interstitial
			
			interstitial_loaded = false;
		}
		else
		{
			show_debug_message("\n\n!! Interstitial was called, but was not loaded. !!\n\n");
		}
	}
}
	
// Shows a rewarded video if it is loaded
function show_rewarded() {
	with(cont_admob) {
		// Check if rewarded is loaded
		if(rewarded_loaded) {
			// Play the rewarded ad
			GoogleMobileAds_ShowRewardedVideo();
			
			rewarded_loaded = false;
			rewarded_watched = false;
		}
		else {
			// Interstitial failed to load
			if(os_is_network_connected(false)) {
				// Is connected to the internet
				show_message_async("We're fetching your ad right now. Try again later!");
			}
			else
			{
				// Is NOT connected to the internet
				show_message_async("You have to be connected to the internet!");
			}
		}
	}
}
	
// Adds a simple dynamic banner to the bottom of the screen
function add_banner() {
	with(cont_admob) GoogleMobileAds_AddBanner(banner_id, GoogleMobileAds_Smart_Banner);
}
	
// Hides the currently showing banner (if it exists)
function hide_banner() {
	GoogleMobileAds_HideBanner();
}
	
// Shows the currently hiddden banner (if it exists)
function show_banner() {
	GoogleMobileAds_ShowBanner();
}

// Destroys a currently showing banner
function destroy_banner() {
	GoogleMobileAds_RemoveBanner();
}
	
	
	
/*
	Functions added on for ease-of-use
*/
	
// Returns true or false based on wheather device is a mobile device
function is_mobile() {
	var _is_mobile = false;

	if(os_type == os_ios) or (os_type == os_android) or (os_type == os_winphone) _is_mobile = true;

	return _is_mobile;
}