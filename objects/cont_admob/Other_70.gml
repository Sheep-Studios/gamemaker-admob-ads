/// @description Ad events

// Get the event ID
var eventID = async_load[? "id"];

// Ensure this is a Google Mobile Ads async event
if(eventID == GoogleMobileAds_ASyncEvent) {
	// Get the type
	var eventType = async_load[? "type"];
	
	switch (eventType) {
		/// Interstitial ad events
		case "interstitial_load":
			
			/*
				This event is called either when the interstitial fails to load or
				when the interstitial has successfully loaded.
			*/
			
			// Get the data
			var loaded = async_load[? "loaded"];
			
			// Get the status
			if(loaded) {
				// Interstitial load was a success
				interstitial_loaded = true;
				
				// Show a debug message (optional)
				show_debug_message("\n\n!! INTERSTITIAL AD LOAD SUCCESS !!\n\n");
			}
			else {
				// Interstitial load failure, retry after delay.
				alarm[1] = load_fail_delay;
				
				// Show a debug message (optional)
				show_debug_message("\n\n!! Interstitial failed to load. Retrying in 3 seconds !!\n\n");
			}
			
		break;
		case "interstitial_closed":
			
			/*
				Interstitial ad has been closed out.
			*/
			
			// Load a new interstitial & reset variable
			GoogleMobileAds_LoadInterstitial();
			interstitial_loaded = false;
			
		break;
		
		/// Rewarded video ad events
		case "rewardedvideo_adloaded":
			
			/*
				Rewarded video has been successfully loaded
			*/
			
			rewarded_loaded = true;
			
			// Show a success message (optional)
			show_debug_message("\n\n!! REWARDED AD LOAD SUCCESS !!\n\n");
			
		break;
		case "rewardedvideo_loadfailed":
			/// Rewarded video failed to load, retry
			
			// Show a message (optional)
			show_debug_message("\n\n!-- REWARDED VIDEO FAILED TO LOAD! ERROR CODE: " + string(async_load[? "errorcode"]) + " --!\n\n");
			show_debug_message("Trying again in 3 seconds...")
			
			// Retry loading ad after a delay
			alarm[0] = load_fail_delay;
		break;
		case "rewardedvideo_adopened":
			
			/*
				Rewarded video ad has been opened. Use this
				event to pause game music, ect.
			*/
			
		break;
		case "rewardedvideo_videostarted":
			
			/*
				Rewarded video started
			*/
			
		break;
		case "rewardedvideo_watched":
			
			/*
				Rewarded video has been watched but not closed out, so
				don't give your rewards just yet!
			*/
			
			// Rewarded video has been watched. Give the reward!
			rewarded_watched = true;
			
		break;
		case "rewardedvideo_adclosed":
			
			/*
				Rewarded ad has been closed. (resume game music, give rewards, ect.)
			*/
			
			// Check to see if the rewarded video has been watched
			if(rewarded_watched)
			{
				/*
					Rewarded video has been watched all the way through
					and was closed. Give your reward here!
				*/
				
				// Show a success message (remove me!)
				show_message_async("Hey, thanks for watching! Here's three SheepCoins.");
			}
			else
			{
				/*
					Rewarded video was cancelled early.
				*/
				
				// Show a message (remove me!)
				show_message_async("Hey, you didn't watch the video all the way through!\nYou must watch the whole video to get your three SheepCoins.");
			}
			
			// Load a new rewarded video
			GoogleMobileAds_LoadRewardedVideo(rewarded_id);
		break;
		
		// Banner ad events
		case "banner_load":
			#region Banner ad load
			
				// Has the ad actually loaded?
				if(async_load[? "loaded"] == 1) {
					/// Move the banner to the bottom center of the screen
				
					// Initialize temp. varibles
					var bannerWidth = GoogleMobileAds_BannerGetWidth();
					var bannerHeight = GoogleMobileAds_BannerGetHeight();
					var displayHeight = display_get_height();
					var displayWidth = display_get_width();
			
					// Move the banner to middle-bottom
					GoogleMobileAds_MoveBanner((displayWidth / 2) - (bannerWidth / 2), displayHeight - bannerHeight);
				}
				else {
					// Banner ad failed to load (internet must be offline)
				
				}
			
			#endregion
		break;
	}
}