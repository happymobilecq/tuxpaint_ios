//
//  IOSMisc.m
//  TuxPaint
//
//  Created by twomol on 2023/11/12.
//

#import <Foundation/Foundation.h>
#import "IOSMisc.h"
#import "SDL.h"
#include <UserMessagingPlatform/UserMessagingPlatform.h>

@implementation IOSMISC
@synthesize ADRect = ADRect_;
@synthesize ADRect_center = ADRect_center_;
@synthesize rBtn = rBtn_;
@synthesize PView = Pview_;
@synthesize rootview = rootview_;
@synthesize PWindow = PWindow_;
@synthesize screen_scale = screen_scale_;
@synthesize textview = textview_;
@synthesize btnOK = btnOK_;
@synthesize textField = textFiled_;
@synthesize shareSurf = shareSurf_;
@synthesize screenDim = screenDim_;
@synthesize bADStarted = bADStarted_;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startADUMP];
}

#pragma mark GADRequest generation
- (GADRequest *)request {
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for the simulator as well as any devices
    // you want to receive test ads.
    /*request.testDevices = @[
                            // TODO: Add your device/simulator test identifiers here. Your device identifier is printed to
                            // the console when the app is launched.
                            GAD_SIMULATOR_ID,
                            @"728619fcf307ab31e90d5a8cffb4bcd6",
                            @"e9a8b6f68a516a03d861c7829d3d719b"
                            ];*/
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[ GADSimulatorID ];
    return request;
}

#pragma mark GADBannerViewDelegate implementation

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
    [self postAD];
}


#pragma mark ad related logic
/*- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}*/
-(IBAction)ADCloseClicked:(id)sender
{
    if (products.count) {
        /*SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:products[0]];
        payment.quantity = 1;
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];*/
    }
    
}
-(void) HideAD
{
    if (Pview_) {
        Pview_.hidden = YES;
    }
}
/*- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
                // Call the appropriate custom method for the transaction state.
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"SKPaymentTransactionStatePurchasing");
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"SKPaymentTransactionStateDeferred");
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"SKPaymentTransactionStateFailed");
                break;
            case SKPaymentTransactionStatePurchased:
            {
                bNoAD = YES;
#ifdef USE_ICLOUD_STORAGE
                NSUbiquitousKeyValueStore *storage = [NSUbiquitousKeyValueStore defaultStore];
#else
                NSUserDefaults *storage = [NSUserDefaults standardUserDefaults];
#endif
                [storage setBool:YES forKey:UD_NOAD_KEY];
                [storage synchronize];
                [self HideAD];
                NSLog(@"SKPaymentTransactionStatePurchased");
                break;
            }
            case SKPaymentTransactionStateRestored:
                NSLog(@"SKPaymentTransactionStateRestored");
                break;
            default:
                // For debugging
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;
        }
    }
}*/
-(void)postAD
{
//    if(! btn){
//        btn = [[UIButton alloc] init];
//        btn.backgroundColor = [UIColor whiteColor];
//        [btn setBackgroundImage:[UIImage imageNamed:@"close.jpg"] forState:UIControlStateNormal];
//        btn.frame = CGRectMake(320, 0, rBtn_.size.width, rBtn_.size.height);
//        [btn addTarget:self action:@selector(ADCloseClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [Pview_ addSubview:btn];
//    }
}
-(void) startADUMP
{
#if 1
    // Create a UMPRequestParameters object.
    UMPRequestParameters *parameters = [[UMPRequestParameters alloc] init];
    // Set tag for under age of consent. NO means users are not under age
    // of consent.
    parameters.tagForUnderAgeOfConsent = NO;
    
    //debug staff
#if TARGET_IPHONE_SIMULATOR
    UMPDebugSettings *debugSettings = [[UMPDebugSettings alloc] init];
    debugSettings.testDeviceIdentifiers = @[ @"TEST-DEVICE-HASHED-ID" ];
    debugSettings.geography = UMPDebugGeographyEEA;
    parameters.debugSettings = debugSettings;
    [UMPConsentInformation.sharedInstance reset];
#endif
    
    //static dispatch_once_t onceToken;
    

    __weak __typeof__(self) weakSelf = self;
    // Request an update for the consent information.
    [UMPConsentInformation.sharedInstance
      requestConsentInfoUpdateWithParameters:parameters
          completionHandler:^(NSError *_Nullable requestConsentError) {
            if (requestConsentError) {
              // Consent gathering failed.
              NSLog(@"Error: %@", requestConsentError.localizedDescription);
              return;
            }
            __strong __typeof__(self) strongSelf = weakSelf;
            if (!strongSelf) {
              return;
            }

            [UMPConsentForm loadAndPresentIfRequiredFromViewController:strongSelf
                completionHandler:^(NSError *loadAndPresentError) {

                  if (loadAndPresentError) {
                    // Consent gathering failed.
                    NSLog(@"Error: %@", loadAndPresentError.localizedDescription);
                    return;
                  }

                  // Consent has been gathered.
                  __strong __typeof__(self) strongSelf = weakSelf;
                  if (!strongSelf) {
                    return;
                  }

                  if (UMPConsentInformation.sharedInstance.canRequestAds) {
                      /*dispatch_once(&onceToken, ^{
                         // start the Google Mobile Ads SDK.
                         [self startAD];

                       });*/
                      [self startAD];
                  }

                }];
          }];

    // Check if you can initialize the Google Mobile Ads SDK in parallel
    // while checking for new consent information. Consent obtained in
    // the previous session can be used to request ads.
    if (UMPConsentInformation.sharedInstance.canRequestAds) {
        /*dispatch_once(&onceToken, ^{
           // start the Google Mobile Ads SDK.
           [self startAD];

         });*/
        [self startAD];
    }
#endif
    [self startAD];
}

-(void) startAD
{
//    // Use predefined GADAdSize constants to define the GADBannerView.
//    admobView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:ADRect_.origin];
//    // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID before compiling.
//    if (![[admob_id valueForKey:@"default"] isKindOfClass:[NSString class]] || [[admob_id valueForKey:@"default"] isEqualToString:@""]) {
//        admobView.adUnitID = DEFAULT_ADMOB_ID;
//    } else {
//        admobView.adUnitID = [admob_id valueForKey:@"default"];
//    }
//
//    admobView.delegate = self;
//    admobView.rootViewController = PWindow_.rootViewController;
//    //[self.PView addSubview:admobView];
//    [PWindow_.subviews[0] addSubview:admobView];
//    [admobView loadRequest:[self request]];
    if (bADStarted_) {
        return ;
    }
    bADStarted_ = YES;
    
    
    
    [GADMobileAds.sharedInstance startWithCompletionHandler:nil];
    bscale_x = 1;
    bcenter_ad = 0;

#ifdef USE_ICLOUD_STORAGE
    NSUbiquitousKeyValueStore *storage = [NSUbiquitousKeyValueStore defaultStore];
#else
    NSUserDefaults *storage = [NSUserDefaults standardUserDefaults];
#endif
    bNoAD = NO;
    //bNoAD = [storage boolForKey:UD_NOAD_KEY];
//    if (!bNoAD) {
//        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[[NSSet alloc]initWithObjects:@"com.happymobile.Tuxpaint.noad3", nil]];
//        productsRequest.delegate = self;
//        [productsRequest start];
//    }
    //it get other config from server, so we still need the following
/*    if ((@available(iOS 14, *)) || (@available(iOS 15, *))) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // Tracking authorization completed. Start loading ads here.
            [self loadADURL];
        }];
    } else {
        [self loadADURL];// Fallback on earlier versions
    }
*/
    [self startADInternal];
}
-(void) startADInternal
{
    //return;
    if (bNoAD) {
        return;
    }
    Pview_ = [[UIView alloc] init];
    if (bcenter_ad) {
        Pview_.frame = ADRect_center_;
    } else Pview_.frame =  ADRect_;
    float scale_f;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        scale_f = 1;
        bscale_x = 0;
    } else scale_f = 1*/*56*/50*screen_scale_/[[UIScreen mainScreen] scale]/48;
    Pview_.transform = CGAffineTransformScale(CGAffineTransformIdentity, bscale_x?scale_f:1, scale_f);
    if (1 /*ad_type == ADMOB*/) {
        // Use predefined GADAdSize constants to define the GADBannerView.
        admobView = [[GADBannerView alloc] initWithAdSize:GADAdSizeBanner origin:CGPointMake(0, 0)];
        // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID before compiling.
        if (![[admob_id valueForKey:@"default"] isKindOfClass:[NSString class]] || [[admob_id valueForKey:@"default"] isEqualToString:@""]) {
            admobView.adUnitID = DEFAULT_ADMOB_ID;
        } else {
            admobView.adUnitID = [admob_id valueForKey:@"default"];
        }
        //admobView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
        admobView.delegate = self;
        admobView.rootViewController = PWindow_.rootViewController;
        //[self.PView addSubview:admobView];
        [rootview_ addSubview:Pview_];
        [Pview_ addSubview:admobView];
//        #define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
//        // Rotate 90 degrees to hide it off screen
//        CGAffineTransform rotationTransform = CGAffineTransformIdentity;
//        rotationTransform = CGAffineTransformRotate(rotationTransform, DEGREES_TO_RADIANS(90));
//        admobView.transform = rotationTransform;
        [admobView loadRequest:[self request]];
    }else {
#if 0
        /*//使用嵌入广告的方法实例。
        sharedAdView = [[BaiduMobAdView alloc] init];
        //sharedAdView.AdUnitTag = @"myAdPlaceId1";
        //此处为广告位id，可以不进行设置，如需设置，在百度移动联盟上设置广告位id，然后将得到的id填写到此处。
        sharedAdView.AdType = BaiduMobAdViewTypeBanner;
        sharedAdView.frame = ADRect_;
        sharedAdView.delegate = self;
        [Pview_ addSubview:sharedAdView];
        [sharedAdView start];*/
#endif
    }
    //[self postAD];
}

- (void)loadADURL {
}

@end
