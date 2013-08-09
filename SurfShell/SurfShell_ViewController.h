/* ==========================================================
 * SurfShell_ViewController.h
 * SurfShell v1.0
 * https://github.com/adamdehaven/SurfShell
 *
 * Author: Adam Dehaven ( @adamdehaven )
 * http://about.adamdehaven.com/
 *
 * ==========================================================
 * MIT License
 *
 * Copyright (c) 2013 Adam Dehaven
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * ========================================================== */

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import <FacebookSDK/FacebookSDK.h>
#import <AdSupport/AdSupport.h>
#import <MessageUI/MessageUI.h>
#import "SurfShell_Globals.h"
#import "GAI.h"
#import "GAITrackedViewController.h"
#import "GAITracker.h"

@interface SurfShell_ViewController : GAITrackedViewController <MFMailComposeViewControllerDelegate> {
    IBOutlet UIWebView *webView;
    NSString *SurfShell_currentUrl;
    NSString *SurfShell_fullDocumentName;
    NSString *SurfShell_pdfName;
    UIImage *loadingImage;
    NSString *alertShowing;
    NSString *fileExistPath;
    NSString *TwitterShareSheetUrl;
    NSString *TwitterShareSheetPageTitle;
    NSString *FbShareSheetUrl;
    NSString *FbShareSheetPageTitle;
    NSString *EmailShareUrl;
    NSString *EmailShareTitle;
    NSArray * documents;
}

-(IBAction)back:(id)sender;

@property(nonatomic, retain) UIWebView *webView;
@property(nonatomic, strong) UIImageView *loadingImageView;
@property(nonatomic, strong) UIImageView *activityImageView;
@property(nonatomic, strong) UIImageView *connectionErrorImageView;
@property(nonatomic, retain) UIAlertView *av;

@end