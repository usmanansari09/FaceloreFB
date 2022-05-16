//##############################################
//Cᴏᴘʏʀɪɢʜᴛ 2020 DᴏᴜɢʜᴏᴜᴢLɪɢʜᴛ Codecanyon Item 19703216
//Elin Doughouz >> https://www.facebook.com/Elindoughouz
//====================================================

//For the accuracy of the icon and logo, please use this website " https://appicon.co " and add images according to size in folders " mipmap " 

using System.Collections.Generic;
using WoWonder.Activities.NativePost.Extra;
using WoWonder.Helpers.Model;

namespace WoWonder
{
    internal static class AppSettings
    {
        /// <summary>
        /// Deep Links To App Content
        /// you should add your website without http in the analytic.xml file >> ../values/analytic.xml .. line 5
        /// <string name="ApplicationUrlWeb">demo.wowonder.com</string>
        /// </summary>
        public static string TripleDesAppServiceProvider = "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";

        //Main Settings >>>>>
        //*********************************************************
        public static string Version = "4.6";
        public static string ApplicationName = "WoWonder Timeline";
        public static string DatabaseName = "WowonderSocial"; 

        // Friend system = 0 , follow system = 1
        public static int ConnectivitySystem = 1;
         
        //Main Colors >>
        //*********************************************************
        public static string MainColor = "#a84849";
         
        //Language Settings >> http://www.lingoes.net/en/translator/langcode.htm
        //*********************************************************
        public static bool FlowDirectionRightToLeft = false;
        public static string Lang = ""; //Default language ar

        //Set Language User on site from phone 
        public static bool SetLangUser = true; 

        //Notification Settings >>
        //*********************************************************
        public static bool ShowNotification = true;
        public static string OneSignalAppId = "64974c58-9993-40ed-b782-0814edc401ea";

        // WalkThrough Settings >>
        //*********************************************************
        public static bool ShowWalkTroutPage = true;

        //Main Messenger settings
        //*********************************************************
        public static bool MessengerIntegration = true;
        public static bool ShowDialogAskOpenMessenger = false; 
        public static string MessengerPackageName = "com.wowondermessenger.app"; //APK name on Google Play

        //AdMob >> Please add the code ad in the Here and analytic.xml 
        //*********************************************************
        public static ShowAds ShowAds = ShowAds.AllUsers; 

        public static bool ShowAdMobBanner = true;
        public static bool ShowAdMobInterstitial = true;
        public static bool ShowAdMobRewardVideo = true;
        public static bool ShowAdMobNative = true;
        public static bool ShowAdMobNativePost = true;
        public static bool ShowAdMobAppOpen = true;  
        public static bool ShowAdMobRewardedInterstitial = true;  

        public static string AdInterstitialKey = "ca-app-pub-5135691635931982/3584502890";
        public static string AdRewardVideoKey = "ca-app-pub-5135691635931982/2518408206";
        public static string AdAdMobNativeKey = "ca-app-pub-5135691635931982/2280543246";
        public static string AdAdMobAppOpenKey = "ca-app-pub-5135691635931982/2813560515";  
        public static string AdRewardedInterstitialKey = "ca-app-pub-5135691635931982/7842669101";  

        //Three times after entering the ad is displayed
        public static int ShowAdMobInterstitialCount = 3;
        public static int ShowAdMobRewardedVideoCount = 3;
        public static int ShowAdMobNativeCount = 40;
        public static int ShowAdMobAppOpenCount = 2;  
        public static int ShowAdMobRewardedInterstitialCount = 3;  

        //FaceBook Ads >> Please add the code ad in the Here and analytic.xml 
        //*********************************************************
        public static bool ShowFbBannerAds = false; 
        public static bool ShowFbInterstitialAds = false;  
        public static bool ShowFbRewardVideoAds = false; 
        public static bool ShowFbNativeAds = false; 
         
        //YOUR_PLACEMENT_ID
        public static string AdsFbBannerKey = "250485588986218_554026418632132"; 
        public static string AdsFbInterstitialKey = "250485588986218_554026125298828";  
        public static string AdsFbRewardVideoKey = "250485588986218_554072818627492"; 
        public static string AdsFbNativeKey = "250485588986218_554706301897477"; 

        //Three times after entering the ad is displayed
        public static int ShowFbNativeAdsCount = 40;

        //Colony Ads >> Please add the code ad in the Here 
        //*********************************************************  
        public static bool ShowColonyBannerAds = true; 
        public static bool ShowColonyInterstitialAds = true; 
        public static bool ShowColonyRewardAds = true;  

        public static string AdsColonyAppId = "appff22269a7a0a4be8aa"; 
        public static string AdsColonyBannerId = "vz85ed7ae2d631414fbd"; 
        public static string AdsColonyInterstitialId = "vz39712462b8634df4a8";  
        public static string AdsColonyRewardedId = "vz32ceec7a84aa4d719a"; 
        //********************************************************* 

        public static bool EnableRegisterSystem = true;

        /// <summary>
        /// true => Only over 18 years old
        /// false => all 
        /// </summary>
        public static bool IsUserYearsOld = true;
        public static bool AddAllInfoPorfileAfterRegister = true; //#New

        //Set Theme Full Screen App
        //*********************************************************
        public static bool EnableFullScreenApp = false;
            
        //Code Time Zone (true => Get from Internet , false => Get From #CodeTimeZone )
        //*********************************************************
        public static bool AutoCodeTimeZone = true;
        public static string CodeTimeZone = "UTC";

        //Error Report Mode
        //*********************************************************
        public static bool SetApisReportMode = false;

        //Social Logins >>
        //If you want login with facebook or google you should change id key in the analytic.xml file 
        //Facebook >> ../values/analytic.xml .. line 10-11 
        //Google >> ../values/analytic.xml .. line 15 
        //*********************************************************
        public static bool EnableSmartLockForPasswords = true; //#New

        public static bool ShowFacebookLogin = true;
        public static bool ShowGoogleLogin = true;

        public static readonly string ClientId = "430795656343-679a7fus3pfr1ani0nr0gosotgcvq2s8.apps.googleusercontent.com";

        //########################### 

        //Main Slider settings
        //*********************************************************
        public static PostButtonSystem PostButton = PostButtonSystem.ReactionDefault;
        public static ToastTheme ToastTheme = ToastTheme.Custom; 

        public static BottomNavigationSystem NavigationBottom = BottomNavigationSystem.Default; 

        public static bool ShowBottomAddOnTab = true; 
         
        public static bool ShowAlbum = true;
        public static bool ShowArticles = true;
        public static bool ShowPokes = true;
        public static bool ShowCommunitiesGroups = true;
        public static bool ShowCommunitiesPages = true;
        public static bool ShowMarket = true;
        public static bool ShowPopularPosts = true;
        /// <summary>
        /// if selected false will remove boost post and get list Boosted Posts
        /// </summary>
        public static bool ShowBoostedPosts = true;  
        public static bool ShowBoostedPages = true;  
        public static bool ShowMovies = true;
        public static bool ShowNearBy = true;
        public static bool ShowStory = true;
        public static bool ShowSavedPost = true;
        public static bool ShowUserContacts = true; 
        public static bool ShowJobs = true; 
        public static bool ShowCommonThings = true; 
        public static bool ShowFundings = true;
        public static bool ShowMyPhoto = true; 
        public static bool ShowMyVideo = true; 
        public static bool ShowGames = true;
        public static bool ShowMemories = true;  
        public static bool ShowOffers = true;  
        public static bool ShowNearbyShops = true;   

        public static bool ShowSuggestedPage = true; 
        public static bool ShowSuggestedGroup = true;
        public static bool ShowSuggestedUser = true;
         
        //count times after entering the Suggestion is displayed
        public static int ShowSuggestedPageCount = 90;  
        public static int ShowSuggestedGroupCount = 70; 
        public static int ShowSuggestedUserCount = 50;

        //allow download or not when share
        public static bool AllowDownloadMedia = true; 

        public static bool ShowAdvertise = true;  
         
        /// <summary>
        /// https://rapidapi.com/api-sports/api/covid-193
        /// you can get api key and host from here https://prnt.sc/wngxfc 
        /// </summary>
        public static bool ShowInfoCoronaVirus = true;  
        public static string KeyCoronaVirus = "164300ef98msh0911b69bed3814bp131c76jsneaca9364e61f"; 
        public static string HostCoronaVirus = "covid-193.p.rapidapi.com"; 
         
        public static bool ShowLive = true;
        public static string AppIdAgoraLive = "619ee4ec26334d2dae20e52d1abbb32e";

        //Events settings
        //*********************************************************  
        public static bool ShowEvents = true; 
        public static bool ShowEventGoing = true; 
        public static bool ShowEventInvited = true;  
        public static bool ShowEventInterested = true;  
        public static bool ShowEventPast = true;

        // Story >>
        //*********************************************************
        //Set a story duration >> 10 Sec
        public static long StoryDuration = 10000L;
        public static bool EnableStorySeenList = true; 
        public static bool EnableReplyStory = true;  

        //*********************************************************

        /// <summary>
        ///  Currency
        /// CurrencyStatic = true : get currency from app not api 
        /// CurrencyStatic = false : get currency from api (default)
        /// </summary>
        public static readonly bool CurrencyStatic = false;
        public static readonly string CurrencyIconStatic = "$";
        public static readonly string CurrencyCodeStatic = "USD";
        public static readonly string CurrencyFundingPriceStatic = "$";

        //Profile settings
        //*********************************************************
        public static bool ShowGift = true;
        public static bool ShowWallet = true; 
        public static bool ShowGoPro = true;  
        public static bool ShowAddToFamily = true;

        public static bool ShowUserGroup = false; 
        public static bool ShowUserPage = false;  
        public static bool ShowUserImage = true;  
        public static bool ShowUserSocialLinks = false; 

        public static CoverImageStyle CoverImageStyle = CoverImageStyle.CenterCrop; 

        /// <summary>
        /// The default value comes from the site .. in case it is not available, it is taken from these values
        /// </summary>
        public static string WeeklyPrice = "3"; 
        public static string MonthlyPrice = "8"; 
        public static string YearlyPrice = "89"; 
        public static string LifetimePrice = "259";

        //Native Post settings
        //********************************************************* 
        public static bool ShowTextWithSpace = true; 

        public static ImagePostStyle ImagePostStyle = ImagePostStyle.FullWidth; 

        public static bool ShowTextShareButton = false;
        public static bool ShowShareButton = true;
         
        public static int AvatarPostSize = 60;
        public static int ImagePostSize = 200;
        public static string PostApiLimitOnScroll = "22";

        //Get post in background >> 1 Min = 30 Sec
        public static long RefreshPostSeconds = 30000;  
        public static string PostApiLimitOnBackground = "12"; 

        public static bool AutoPlayVideo = true;
         
        public static bool EmbedPlayTubePostType = true;
        public static bool EmbedDeepSoundPostType = true;
        public static VideoPostTypeSystem EmbedFacebookVideoPostType = VideoPostTypeSystem.EmbedVideo; 
        public static VideoPostTypeSystem EmbedVimeoVideoPostType = VideoPostTypeSystem.EmbedVideo; 
        public static VideoPostTypeSystem EmbedPlayTubeVideoPostType = VideoPostTypeSystem.Link; 
        public static VideoPostTypeSystem EmbedTikTokVideoPostType = VideoPostTypeSystem.Link; 
        public static VideoPostTypeSystem EmbedTwitterPostType = VideoPostTypeSystem.Link; 
        public static bool ShowSearchForPosts = true; 
        public static bool EmbedLivePostType = true;
         
        //new posts users have to scroll back to top
        public static bool ShowNewPostOnNewsFeed = true; 
        public static bool ShowAddPostOnNewsFeed = false; 
        public static bool ShowCountSharePost = true;

        public static WRecyclerView.VolumeState DefaultVolumeVideoPost = WRecyclerView.VolumeState.Off; 

        /// <summary>
        /// Post Privacy
        /// ShowPostPrivacyForAllUser = true : all posts user have icon Privacy 
        /// ShowPostPrivacyForAllUser = false : just my posts have icon Privacy (default)
        /// </summary>
        public static bool ShowPostPrivacyForAllUser = false; 

        public static bool ShowFullScreenVideoPost = true;

        public static bool EnableVideoCompress = false;
        public static bool EnableFitchOgLink = true; //#New

        //Trending page
        //*********************************************************   
        public static bool ShowTrendingPage = true;
         
        public static bool ShowProUsersMembers = true;
        public static bool ShowPromotedPages = true;
        public static bool ShowTrendingHashTags = true;
        public static bool ShowLastActivities = true;
        public static bool ShowShortcuts = true; 
        public static bool ShowFriendsBirthday = true; 
        public static bool ShowAnnouncement = true; 

        /// <summary>
        /// https://www.weatherapi.com
        /// </summary>
        public static bool ShowWeather = true;  
        public static string KeyWeatherApi = "e7cffc4d6a9a4a149a1113143201711";

        /// <summary>
        /// https://openexchangerates.org
        /// #Currency >> Your currency
        /// #Currencies >> you can use just 3 from those : USD,EUR,DKK,GBP,SEK,NOK,CAD,JPY,TRY,EGP,SAR,JOD,KWD,IQD,BHD,DZD,LYD,AED,QAR,LBP,OMR,AFN,ALL,ARS,AMD,AUD,BYN,BRL,BGN,CLP,CNY,MYR,MAD,ILS,TND,YER
        /// </summary>
        public static bool ShowExchangeCurrency = false; 
        public static string KeyCurrencyApi = "644761ef2ba94ea5aa84767109d6cf7b"; 
        public static string ExCurrency = "USD";  
        public static string ExCurrencies = "EUR,GBP,TRY"; 
        public static readonly List<string> ExCurrenciesIcons = new List<string>() {"€", "£", "₺"}; 

        //********************************************************* 

        public static bool ShowUserPoint = true;

        //Add Post
        public static AddPostSystem AddPostSystem = AddPostSystem.AllUsers;

        public static bool ShowGalleryImage = true;
        public static bool ShowGalleryVideo = true;
        public static bool ShowMention = true;
        public static bool ShowLocation = true;
        public static bool ShowFeelingActivity = true;
        public static bool ShowFeeling = true;
        public static bool ShowListening = true;
        public static bool ShowPlaying = true;
        public static bool ShowWatching = true;
        public static bool ShowTraveling = true;
        public static bool ShowGif = true;
        public static bool ShowFile = true;
        public static bool ShowMusic = true;
        public static bool ShowPolls = true;
        public static bool ShowColor = true;
        public static bool ShowVoiceRecord = true; 

        public static bool ShowAnonymousPrivacyPost = true;

        //Advertising 
        public static bool ShowAdvertisingPost = true;  

        //Settings Page >> General Account
        public static bool ShowSettingsGeneralAccount = true;
        public static bool ShowSettingsAccount = true;
        public static bool ShowSettingsSocialLinks = true;
        public static bool ShowSettingsPassword = true;
        public static bool ShowSettingsBlockedUsers = true;
        public static bool ShowSettingsDeleteAccount = true;
        public static bool ShowSettingsTwoFactor = true; 
        public static bool ShowSettingsManageSessions = true;  
        public static bool ShowSettingsVerification = true;
         
        public static bool ShowSettingsSocialLinksFacebook = true; 
        public static bool ShowSettingsSocialLinksTwitter = true; 
        public static bool ShowSettingsSocialLinksGoogle = true; 
        public static bool ShowSettingsSocialLinksVkontakte = true;  
        public static bool ShowSettingsSocialLinksLinkedin = true;  
        public static bool ShowSettingsSocialLinksInstagram = true;  
        public static bool ShowSettingsSocialLinksYouTube = true;  

        //Settings Page >> Privacy
        public static bool ShowSettingsPrivacy = true;
        public static bool ShowSettingsNotification = true;

        //Settings Page >> Tell a Friends (Earnings)
        public static bool ShowSettingsInviteFriends = true;

        public static bool ShowSettingsShare = true;
        public static bool ShowSettingsMyAffiliates = true;
        public static bool ShowWithdrawals = true;

        /// <summary>
        /// if you want this feature enabled go to Properties -> AndroidManefist.xml and remove comments from below code
        /// Just replace it with this 5 lines of code
        /// <uses-permission android:name="android.permission.READ_CONTACTS" />
        /// <uses-permission android:name="android.permission.READ_PHONE_NUMBERS" />
        /// </summary>
        public static bool InvitationSystem = true; 

        //Settings Page >> Help && Support
        public static bool ShowSettingsHelpSupport = true;

        public static bool ShowSettingsHelp = true;
        public static bool ShowSettingsReportProblem = true;
        public static bool ShowSettingsAbout = true;
        public static bool ShowSettingsPrivacyPolicy = true;
        public static bool ShowSettingsTermsOfUse = true;

        public static bool ShowSettingsRateApp = true; 
        public static int ShowRateAppCount = 5; 
         
        public static bool ShowSettingsUpdateManagerApp = false; 

        public static bool ShowSettingsInvitationLinks = true; 
        public static bool ShowSettingsMyInformation = true; 

        public static bool ShowSuggestedUsersOnRegister = true;

        //Set Theme Tab
        //*********************************************************
        public static bool SetTabDarkTheme = false;
        public static MoreTheme MoreTheme = MoreTheme.Card; 

        //Bypass Web Errors  
        //*********************************************************
        public static bool TurnTrustFailureOnWebException = true;
        public static bool TurnSecurityProtocolType3072On = true;

        //*********************************************************
        public static bool RenderPriorityFastPostLoad = false;

        /// <summary>
        /// if you want this feature enabled go to Properties -> AndroidManefist.xml and remove comments from below code
        /// <uses-permission android:name="com.android.vending.BILLING" />
        /// </summary>
        public static bool ShowInAppBilling = false; 

        public static bool ShowPaypal = true; 
        public static bool ShowBankTransfer = true; 
        public static bool ShowCreditCard = true;

        //********************************************************* 
        public static bool ShowCashFree = true;  

        /// <summary>
        /// Currencies : http://prntscr.com/u600ok
        /// </summary>
        public static string CashFreeCurrency = "INR";  

        //********************************************************* 

        /// <summary>
        /// If you want RazorPay you should change id key in the analytic.xml file
        /// razorpay_api_Key >> .. line 24 
        /// </summary>
        public static bool ShowRazorPay = true; 

        /// <summary>
        /// Currencies : https://razorpay.com/accept-international-payments
        /// </summary>
        public static string RazorPayCurrency = "USD";  
         
        public static bool ShowPayStack = true;  
        public static bool ShowPaySera = false;  //#Next Version   
                                               
        //********************************************************* 

    }
}