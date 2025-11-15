//
//  IOSMisc.h
//  TuxPaint
//
//  Created by happymobile on 2023/11/11.
//

#ifndef IOSMisc_h
#define IOSMisc_h


#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>

@import GoogleMobileAds;

struct SDL_Surface;

#if TARGET_IPHONE_SIMULATOR
#define DEFAULT_ADMOB_ID  @"ca-app-pub-3940256099942544/2934735716"
#else
//#define DEFAULT_ADMOB_ID  @"ca-app-pub-8449785999705199/2826668228"
#define DEFAULT_ADMOB_ID  @"ca-app-pub-8449785999705199/9544494395"
#endif


@interface IOSMISC : UIViewController< GADBannerViewDelegate>
{
    UIImage* image_;
 
    GADBannerView*  admobView;
    UIButton *btn;
    NSMutableData       *responseData;
    NSURLConnection     *MyConnection;

    NSDictionary *admob_id;
    NSDictionary *baidu_id;
    int bscale_x;
    int bcenter_ad;
    NSArray *products;
    BOOL bNoAD;
   
}
-(IBAction)ADCloseClicked:(id)sender;
-(void)startAD;
-(void)startADUMP;
-(void)postAD;
-(void)startADInternal;
-(void)loadADURL;
-(void)HideAD;
@property (nonatomic) CGRect ADRect;
@property (nonatomic) CGRect ADRect_center;
@property (nonatomic) CGRect rBtn;
@property (nonatomic) float screen_scale;
@property (nonatomic) BOOL bADStarted;
@property (atomic, retain)UIView *PView;
@property (atomic, retain)UIView *rootview;
@property (atomic, retain)UIWindow *PWindow;
@property (atomic, retain)IBOutlet UITextField *textField;
@property (atomic, retain)IBOutlet UIView      *textview;
@property (atomic, retain)IBOutlet UIButton    *btnOK;
@property (nonatomic) struct SDL_Surface* shareSurf;
@property (nonatomic) CGRect screenDim;
@end



#endif /* IOSMisc_h */
