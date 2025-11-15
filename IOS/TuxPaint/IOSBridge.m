//
//  IOSBridge.m
//  TuxPaint
//
//  Created by twomol on 2023/11/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#include <UserMessagingPlatform/UserMessagingPlatform.h>
#import "SDL.h"
#import "SDL_syswm.h"
#import "IOSMisc.h"

static IOSMISC *myIOSMisc;
static BOOL bIOMiscStarted = NO;

#pragma mark - export to photo
void ExportPicToPhone(char *fname)
{
    //UIImage *image = [UIImage imageWithContentsOfFile:[[[NSString alloc] initWithCString:(const char*)fname encoding:NSASCIIStringEncoding] autorelease]];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithCString:(const char*)fname encoding:NSASCIIStringEncoding]];
    
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
}

void ExportGifToPhone(char *fname)
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];

    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[NSString stringWithCString:(const char*)fname]]];

    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {}];
}



#pragma mark - text input

#define TFC_X 200
#define TFC_Y 30
#define BUTTON_H 20
#if 0
void IOSSTartTextInput(SDL_Window * sdlWindow, float x, float y, char* str)
{
    SDL_SysWMinfo systemWindowInfo;
    SDL_VERSION(&systemWindowInfo.version);
    if (! myIOSMisc) {
        myIOSMisc = [[IOSMISC alloc] initWithNibName:@"textview" bundle:nil];
        //myIOSMisc = [[IOSMISC alloc] init];
    }
    if ( !SDL_GetWindowWMInfo(sdlWindow, &systemWindowInfo)) {
        // consider doing some kind of error handling here
        return;
    }
    float scale = [[UIScreen mainScreen] scale];
    int ww, wh;
    SDL_GetWindowSize(sdlWindow, &ww, &wh);
    
    UIWindow * appWindow = systemWindowInfo.info.uikit.window;
    //if (x > (ww-TFC_X*scale)) x = ww-TFC_X*scale;
    //if (y < TFC_Y*scale) y = TFC_Y*scale;
    if (x > (ww-TFC_X)) x = ww-TFC_X;
    if (y < TFC_Y) y = TFC_Y;

    
//    //[myIOSMisc loadView];
//    myIOSMisc.textview.center = CGPointMake(x, y);
//    myIOSMisc.textview.bounds = CGRectMake(0, 0, TFC_X*2, TFC_Y*2+BUTTON_H);
//    [appWindow.subviews[0] addSubview: myIOSMisc.textview];
//    myIOSMisc.textview.hidden = NO;
//    [myIOSMisc.textField becomeFirstResponder];
    UIView *view = appWindow.subviews[0];
//    printf("%f %f %f %f", appWindow.frame.origin.x, appWindow.frame.origin.y, appWindow.frame.size.width,appWindow.frame.size.height);
//    printf("----%f %f %f %f---", view.frame.origin.x, view.frame.origin.y, view.frame.size.width,view.frame.size.height);
    //SDL_Rect r = {x, y - TFC_Y*scale, TFC_X*scale, TFC_Y*scale};
    SDL_Rect r = {x, y - TFC_Y, TFC_X, TFC_Y};
    SDL_SetTextInputRect(&r);
    SDL_EventState(SDL_TEXTINPUT, SDL_ENABLE);
    SDL_EventState(SDL_TEXTEDITING, SDL_ENABLE);
    if (!textField) {
        textview = [[UIView alloc] init];
        textview.center = CGPointMake(x*myIOSMisc.screen_scale/scale+TFC_X/2, y*myIOSMisc.screen_scale/scale-TFC_Y/2);
        textview.bounds = CGRectMake(0, 0, TFC_X, TFC_Y);
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, TFC_X, TFC_Y)];
        textField.delegate = myIOSMisc;
        /* placeholder so there is something to delete! */
        if (str) {
            textField.text = [[NSString alloc] initWithUTF8String:str];
        } else textField.text = @" ";
        /* set UITextInputTrait properties, mostly to defaults */
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.enablesReturnKeyAutomatically = NO;
        textField.keyboardAppearance = UIKeyboardAppearanceDefault;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDefault;
        textField.secureTextEntry = NO;
        textField.backgroundColor = [UIColor whiteColor];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [textview addSubview:textField];
        
//        btnOK = [[UIButton alloc] initWithFrame:CGRectMake(TFC_X, TFC_Y*2, TFC_X, BUTTON_H)];
//        btnOK.backgroundColor = [UIColor greenColor];
        //btnOK.titleLabel =
        //btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, TFC_Y*2, TFC_X, BUTTON_H)];
        //btnCancel.backgroundColor = [UIColor redColor];
        [textview addSubview:btnCancel];
        [textview addSubview:btnOK];
        [appWindow.subviews[0] addSubview: textview];
    }
    if (str) {
        textField.text = [[NSString alloc] initWithUTF8String:str];
    } else textField.text = @" ";
    //textview.center = CGPointMake(x/scale+TFC_X/2, y/scale-TFC_Y/2);
    //textview.center = CGPointMake(x*myIOSMisc.screen_scale/scale+TFC_X/2, y*myIOSMisc.screen_scale/scale-TFC_Y/2);
    textview.center = CGPointMake(x+TFC_X/2, y-TFC_Y/2);
    textview.bounds = CGRectMake(0, 0, TFC_X, TFC_Y);
    textview.hidden = NO;
    /* add the UITextField (hidden) to our view */
    [textField becomeFirstResponder];
    //appWindow.frame = CGRectMake(0, 0, appWindow.frame.size.width, appWindow.frame.size.height);
}
static int SDL_SendKeyboardText(const char *text)
{
    int posted;
    
    /* Don't post text events for unprintable characters */
    if ((unsigned char)*text < ' ' || *text == 127) {
        return 0;
    }
    
    /* Post the event, if desired */
    posted = 0;
    if (SDL_GetEventState(SDL_TEXTINPUT) == SDL_ENABLE) {
        SDL_Event event;
        event.text.type = SDL_TEXTINPUT;
        event.text.windowID = 0;
        SDL_utf8strlcpy(event.text.text, text, SDL_arraysize(event.text.text));
        posted = (SDL_PushEvent(&event) > 0);
    }
    return (posted);
}
static int SDL_SendKeyboardKey(Uint8 state, SDL_Scancode scancode, SDL_Keycode sym)
{
    int posted;
    Uint16 modstate = 0;
    Uint32 type;
    Uint8 repeat = 0;
    
    if (!scancode) {
        return 0;
    }
#ifdef DEBUG_KEYBOARD
    printf("The '%s' key has been %s\n", SDL_GetScancodeName(scancode),
           state == SDL_PRESSED ? "pressed" : "released");
#endif
    
    /* Figure out what type of event this is */
    switch (state) {
        case SDL_PRESSED:
            type = SDL_KEYDOWN;
            break;
        case SDL_RELEASED:
            type = SDL_KEYUP;
            break;
        default:
            /* Invalid state -- bail */
            return 0;
    }
    
    /* Post the event, if desired */
    posted = 0;
    if (SDL_GetEventState(type) == SDL_ENABLE) {
        SDL_Event event;
        event.key.type = type;
        event.key.state = state;
        event.key.repeat = repeat;
        event.key.keysym.scancode = scancode;
        event.key.keysym.sym = sym;
        event.key.keysym.mod = modstate;
        event.key.windowID =  0;
        posted = (SDL_PushEvent(&event) > 0);
    }
    return (posted);
}
void IOSStopTextInput(SDL_Window * sdlWindow, float x, float y)
{
        //[myIOSMisc.textField resignFirstResponder];
        //myIOSMisc.textview.hidden = YES;
    if (!textField) {
        return;
    }
    SDL_SendKeyboardText([textField.text UTF8String]);
    SDL_SendKeyboardKey(SDL_PRESSED, SDL_SCANCODE_RETURN, SDLK_RETURN);
    SDL_SendKeyboardKey(SDL_RELEASED, SDL_SCANCODE_RETURN, SDLK_RETURN);
    [textField resignFirstResponder];
    textview.hidden = YES;
    //SDL_EventState(SDL_TEXTINPUT, SDL_DISABLE);
    //SDL_EventState(SDL_TEXTEDITING, SDL_DISABLE);
    textField.text = @"";
}
#endif

#pragma mark - google admob
float IOSReturnSceenScale()
{
    #if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
    float scale = (float)([UIScreen mainScreen].nativeScale);
    #else
    float scale = (float)([UIScreen mainScreen].scale);
    #endif
    return scale;
}

void IOSMisc_StartAD(SDL_Window * sdlWindow, float x, float y, float w, float screen_scale)
{
    if (bIOMiscStarted) {
        return;
    }
    bIOMiscStarted = YES;
    float uiScrScale = IOSReturnSceenScale();
    screen_scale = screen_scale * uiScrScale;//for latest SDL2
    SDL_SysWMinfo systemWindowInfo;
    UIScreen *uiscreen = [UIScreen mainScreen];
    float fw = [uiscreen bounds].size.width;
    float fh = [uiscreen bounds].size.height;
    float scale = [uiscreen scale];
    if (fw < fh) {
        float ftmp = fw;
        fw = fh;
        fh = ftmp;
    }
    int button_size = 0/*48*/;
    CGRect r = CGRectMake(fw-320-button_size, fh-43, 320+button_size, 48);
    // 48 for r_color, 56 for r_tuxarea
    CGRect rc = CGRectMake(fw/2-160, fh-(48+56)*screen_scale/scale-48, 320+button_size, 48);
    SDL_VERSION(&systemWindowInfo.version);
    if ( !SDL_GetWindowWMInfo(sdlWindow, &systemWindowInfo)) {
        // consider doing some kind of error handling here
        return;
    }
    UIWindow * appWindow = systemWindowInfo.info.uikit.window;
    //UIViewController * rootViewController = appWindow.rootViewController;
    if (! myIOSMisc) {
        //myIOSMisc = [[IOSMISC alloc] initWithNibName:@"textview" bundle:nil];
        myIOSMisc = [[IOSMISC alloc] init];
    }
    
    myIOSMisc.ADRect = r;
    myIOSMisc.ADRect_center = rc;
    myIOSMisc.rootview = appWindow.subviews[0];
    myIOSMisc.PWindow = appWindow;
    myIOSMisc.rBtn = CGRectMake(fw - button_size, fh-48, button_size, button_size);
    myIOSMisc.screen_scale = screen_scale;
    myIOSMisc.bADStarted = NO;
    //[myIOSMisc startADUMP];
    //[myIOSMisc startAD];
    [myIOSMisc loadViewIfNeeded];
    
}
