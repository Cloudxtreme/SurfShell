/* ==========================================================
 * SurfShell_ViewController.m
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

#import "SurfShell_ViewController.h"
#import "SurfShell_ModalViewController.h"

@interface SurfShell_ViewController ()

@end

@implementation SurfShell_ViewController;

@synthesize webView;
@synthesize loadingImageView;
@synthesize activityImageView;
@synthesize connectionErrorImageView;
@synthesize av;

-(IBAction)back:(id)sender{
    
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"closeModal" withAction:@"doneClick" withLabel:@"exitedModalView" withValue:[NSNumber numberWithInt:1]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
    self.trackedViewName = @"Main App Screen";
    
    // Subscribe to Notification, and perform 'handleDidBecomeActive'
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(handleDidBecomeActive:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
    
    // **************** Set URL for UIWebView
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SurfShell_loadUrl] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:35.0]];
    
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    NSLog(@"Current Orientation is: %d", currentOrientation);
    
    
    //**************** Start Add loading image  ****************/
    
    // Get device screen pixel dimensions
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSString *screenDimensions = NSStringFromCGRect(screenBounds);
    NSLog(@"Screen Dimensions:%@", screenDimensions);
    
    //If Screen Dimensions contain 568, set user agent and loading image to tall
    if([screenDimensions rangeOfString:@"568"].location != NSNotFound) {
        NSLog(@"Detected iPhone 5 - tall");
        // Change iPhone User Agent to Tall
        NSDictionary *dictionary = [NSDictionary  dictionaryWithObjectsAndKeys:SurfShell_userAgent_iPhone5, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
        NSLog(@"Changed iPhone User Agent to tall");
        
        // Set tall loading image
        loadingImage = [UIImage imageNamed:@"webViewLoadImage-568h.png"];
        loadingImageView = [[UIImageView alloc] initWithImage:loadingImage];
        loadingImageView.animationImages = [NSArray arrayWithObjects:
                                            [UIImage imageNamed:@"webViewLoadImage-568h.png"],
                                            nil];
    }
    if([screenDimensions rangeOfString:@"568"].location == NSNotFound) {
        NSLog(@"Detected iPhone regular height");
        // Change iPhone User Agent
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:SurfShell_userAgent_iPhone, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
        NSLog(@"Changed iPhone User Agent to regular");
        
        // Set regular iPhone loading image
        loadingImage = [UIImage imageNamed:@"webViewLoadImage.png"];
        loadingImageView = [[UIImageView alloc] initWithImage:loadingImage];
        loadingImageView.animationImages = [NSArray arrayWithObjects:
                                            [UIImage imageNamed:@"webViewLoadImage.png"],
                                            nil];
    }
    
    [self.view addSubview:loadingImageView];
    // End Add loading image
    
    /**************** --- START CUSTOM ACTIVITY SPINNER ****************/
    //Create the first status image and the indicator view
    UIImage *statusImage = [UIImage imageNamed:@"activity1.png"];
    activityImageView = [[UIImageView alloc] initWithImage:statusImage];
    
    //Add more images which will be used for the animation
    activityImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"activity1.png"],
                                         [UIImage imageNamed:@"activity2.png"],
                                         [UIImage imageNamed:@"activity3.png"],
                                         [UIImage imageNamed:@"activity4.png"],
                                         [UIImage imageNamed:@"activity5.png"],
                                         [UIImage imageNamed:@"activity6.png"],
                                         [UIImage imageNamed:@"activity7.png"],
                                         [UIImage imageNamed:@"activity8.png"],
                                         [UIImage imageNamed:@"activity9.png"],
                                         [UIImage imageNamed:@"activity10.png"],
                                         [UIImage imageNamed:@"activity11.png"],
                                         [UIImage imageNamed:@"activity12.png"],
                                         [UIImage imageNamed:@"activity13.png"],
                                         [UIImage imageNamed:@"activity14.png"],
                                         [UIImage imageNamed:@"activity15.png"],
                                         [UIImage imageNamed:@"activity16.png"],
                                         [UIImage imageNamed:@"activity17.png"],
                                         [UIImage imageNamed:@"activity18.png"],
                                         [UIImage imageNamed:@"activity19.png"],
                                         [UIImage imageNamed:@"activity20.png"],
                                         [UIImage imageNamed:@"activity21.png"],
                                         [UIImage imageNamed:@"activity22.png"],
                                         [UIImage imageNamed:@"activity23.png"],
                                         [UIImage imageNamed:@"activity24.png"],
                                         nil];
    
    //Set the duration of the animation (play with it until it looks nice for you)
    activityImageView.animationDuration = 0.9;
    
    //Position the activity image view somewhere in your current view
    activityImageView.frame = CGRectMake(
                                         self.view.frame.size.width/2 // Center Image
                                         -statusImage.size.width/2, // Center Image
                                         self.view.frame.size.height/1.15 // Distance from btm
                                         -statusImage.size.height/1.15,  // Distance from btm
                                         statusImage.size.width,
                                         statusImage.size.height);
    
    //Start the animation
    [activityImageView startAnimating];
    
    //Add your custom activity indicator to your current view
    [self.view addSubview:activityImageView];
    /*  --- END CUSTOM ACTIVITY SPINNER */
    
    webView.scrollView.bounces = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    // If iOS 6 or above, check if user has Facebook and Twitter accounts set up. 0=No, 1=Yes
    if([SLComposeViewController class] != nil) {
        NSLog(@"Facebook Account in Settings: %d -- Twitter Account in Settings: %d",[SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook], [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]);
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    NSLog(@"Hide status bar");
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"shouldStartLoadWithRequest");
    
    // Hide Network Activity Indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // Get requested URL and set to variable SurfShell_currentUrl
    SurfShell_currentUrl = request.URL.absoluteString;
    NSLog(@"SurfShell_currentUrl: %@", SurfShell_currentUrl);
    
    if([SurfShell_currentUrl rangeOfString:SurfShell_customUrlScheme].location != NSNotFound) {
        NSLog(@"shouldstart DETECT CUSTOM URL");
        
        [[GAI sharedInstance].defaultTracker setReferrerUrl:@"launchedFromCustomUrl"];
    }
    
    if([SurfShell_currentUrl hasSuffix:@".pdf"]) {
        
        //Get PDF file name
        NSArray *urlArray = [SurfShell_currentUrl componentsSeparatedByString:@"/"];
        SurfShell_fullDocumentName = [urlArray lastObject];
        
        //Get PDF file name without ".pdf"
        NSArray *docName = [SurfShell_fullDocumentName componentsSeparatedByString:@"."];
        SurfShell_pdfName = [docName objectAtIndex:0];
        
        fileExistPath = [[NSBundle mainBundle]
                         pathForResource:SurfShell_fullDocumentName
                         ofType:nil];
        NSLog(@"fileExistPath: %@", fileExistPath);
    }
    
    
    // Handle links
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        // Open external PDFs not in app or on SurfShell_baseUrl website in modal
        if([SurfShell_currentUrl hasSuffix:@".pdf"] && (![SurfShell_currentUrl hasPrefix:SurfShell_baseUrl] || fileExistPath == nil)){
            [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"openModal" withAction:@"externalLinkClick" withLabel:[NSString stringWithFormat:@"Link: %@", SurfShell_currentUrl] withValue:[NSNumber numberWithInt:1]];
            
            SurfShell_ModalViewController *webViewController = [[SurfShell_ModalViewController alloc] initWithAddress:SurfShell_currentUrl];
            webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            webViewController.availableActions = SurfShell_WebViewControllerAvailableActionsMailLink | SurfShell_WebViewControllerAvailableActionsOpenInSafari;
            webViewController.barsTintColor = [UIColor darkGrayColor];
            webViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            [self presentViewController:webViewController animated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            return NO;
        }
        
        // Open PDFs (app bundle files) in modal
        if([SurfShell_currentUrl hasSuffix:@".pdf"] && ([SurfShell_currentUrl hasPrefix:SurfShell_baseUrl] || fileExistPath != nil)){
            [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"openModal" withAction:@"bundleLinkClick" withLabel:[NSString stringWithFormat:@"Link: %@", SurfShell_currentUrl] withValue:[NSNumber numberWithInt:1]];
            
            //Show local file in modal with SurfShell_pdfName string as file name without ".pdf"
            SurfShell_ModalViewController *webViewController = [[SurfShell_ModalViewController alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:SurfShell_pdfName ofType:@"pdf"]]];
            
            webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            webViewController.availableActions = SurfShell_WebViewControllerAvailableActionsMailPDF;
            webViewController.barsTintColor = [UIColor darkGrayColor];
            webViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            [self presentViewController:webViewController animated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            return NO;
        }
        
        
        for(NSString *modalPage in SurfShell_pagesToOpenInModal){
            if([SurfShell_currentUrl rangeOfString:modalPage].location == NSNotFound) {
                NSLog(@"modalPage: %@ does NOT contain %@, so open in app.",SurfShell_currentUrl,modalPage);
            } else {
                NSLog(@"modalPage: %@ DOES contain %@, so open in modal.",SurfShell_currentUrl,modalPage);
                SurfShell_ModalViewController *webViewController = [[SurfShell_ModalViewController alloc] initWithAddress:SurfShell_currentUrl];
                webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
                webViewController.availableActions = SurfShell_WebViewControllerAvailableActionsMailLink | SurfShell_WebViewControllerAvailableActionsOpenInSafari;
                webViewController.barsTintColor = [UIColor darkGrayColor];
                webViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                
                [self presentViewController:webViewController animated:YES completion:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
                
                return NO;
            }
        }
        
        for(NSString *safariPage in SurfShell_pagesToOpenInSafari){
            if([SurfShell_currentUrl rangeOfString:safariPage].location == NSNotFound) {
                NSLog(@"safariPage: %@ does NOT contain %@, so continue / open in app.",SurfShell_currentUrl,safariPage);
            } else {
                NSLog(@"safariPage: %@ DOES contain %@, so open in Safari.",SurfShell_currentUrl,safariPage);
                [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"openInSafari" withAction:@"externalLinkClick" withLabel:[NSString stringWithFormat:@"External Link: %@", SurfShell_currentUrl] withValue:[NSNumber numberWithInt:1]];
                
                [[UIApplication sharedApplication] openURL:request.URL];
                return NO;
            }
        }
        
        // Open Twitter links in Tweet Sheet
        if([SurfShell_currentUrl hasPrefix:@"https://twitter.com/share"]){
            // Tweet url format: https://twitter.com/share?url=address&via=Username&text=DefaultTweetText
            
            // Create Share Sheet URL and Page Title
            TwitterShareSheetUrl = [SurfShell_currentUrl stringByReplacingOccurrencesOfString:@"https://twitter.com/share?url=" withString:@""];
            TwitterShareSheetUrl = [TwitterShareSheetUrl stringByReplacingOccurrencesOfString:@"%3A" withString:@":"];
            TwitterShareSheetUrl = [TwitterShareSheetUrl stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
            
            NSString *twitterLinkVia = @"&via=";
            twitterLinkVia = [twitterLinkVia stringByAppendingString:SurfShell_twitterHandle];
            
            NSArray *twitterLinkArray = [TwitterShareSheetUrl componentsSeparatedByString:@"&text="];
            
            TwitterShareSheetUrl = [twitterLinkArray firstObjectCommonWithArray:twitterLinkArray];
            TwitterShareSheetUrl = [TwitterShareSheetUrl stringByReplacingOccurrencesOfString:twitterLinkVia withString:@""];
            NSLog(@"TwitterShareSheetUrl:%@", TwitterShareSheetUrl);
            
            TwitterShareSheetPageTitle = [twitterLinkArray lastObject];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@"%5B" withString:@"["];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@"%5D" withString:@"]"];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle capitalizedString];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" And " withString:@" and "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" The " withString:@" the "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" A " withString:@" a "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" For " withString:@" for "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Of " withString:@" of "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" By " withString:@" by "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" The " withString:@" the "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" To " withString:@" to "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" With " withString:@" with "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" At " withString:@" at "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Or " withString:@" or "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Nor " withString:@" nor "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" But " withString:@" but "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Yet " withString:@" yet "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" So " withString:@" so "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" By " withString:@" by "];
            TwitterShareSheetPageTitle = [TwitterShareSheetPageTitle stringByReplacingOccurrencesOfString:@" In " withString:@" in "];
            
            NSString *viaTwitterHandle = @"via @";
            viaTwitterHandle = [viaTwitterHandle stringByAppendingString:SurfShell_twitterHandle];
            
            TwitterShareSheetPageTitle = [NSString stringWithFormat:@"%@ %@", TwitterShareSheetPageTitle, viaTwitterHandle];
            NSLog(@"TwitterShareSheetPageTitle:%@", TwitterShareSheetPageTitle);
            
            if([SLComposeViewController class] != nil) {
                NSLog(@"Social Framework IS Supported - Tweet via SLComposeViewController");
                
                if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                    
                    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Twitter" withAction:@"Tweet Share Sheet" withLabel:[NSString stringWithFormat:@"Tweet: %@", TwitterShareSheetUrl] withValue:[NSNumber numberWithInt:1]];
                    
                    SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                    [tweetSheet setInitialText:TwitterShareSheetPageTitle];
                    [tweetSheet addURL:[NSURL URLWithString:TwitterShareSheetUrl]];
                    [self presentViewController:tweetSheet animated:YES completion:nil];
                    
                    return NO;
                    
                } else {
                    
                    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Twitter" withAction:@"showNoTwitterAccountsAlert" withLabel:@"cantTweetFromSLComposeViewController" withValue:[NSNumber numberWithInt:1]];
                    
                    UIAlertView *alertView = [[UIAlertView alloc]
                                              initWithTitle:@"No Twitter Account"
                                              message:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."
                                              delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
                    [alertView show];
                    
                    return NO;
                }
            } else {
                
                [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Twitter" withAction:@"showNoTwitterAccounts" withLabel:@"cantTweetFromTWTweetComposeViewController" withValue:[NSNumber numberWithInt:1]];
                
                NSLog(@"can NOT share via Twitter Sheet");
                
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"No Twitter Account"
                                          message:@"There are no Twitter accounts configured. You can add or create a Twitter account in Settings."
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
                
                return NO;
            }
            return NO;
        }
        
        // Open Facebook links in Facebook Sheet
        if([SurfShell_currentUrl hasPrefix:@"http://www.facebook.com/sharer"] && [SLComposeViewController class] != nil){
            
            // Facebook share url format: http://www.facebook.com/sharer.php?u=address&t=DefaultText
            
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                NSLog(@"Does support Social Framework and CAN share via Facebook Sheet");
                
                // Create Share Sheet URL and Page Title
                FbShareSheetUrl = [SurfShell_currentUrl stringByReplacingOccurrencesOfString:@"http://www.facebook.com/sharer.php?u=" withString:@""];
                FbShareSheetUrl = [FbShareSheetUrl stringByReplacingOccurrencesOfString:@"#" withString:@""];
                FbShareSheetUrl = [FbShareSheetUrl stringByReplacingOccurrencesOfString:@"%3A" withString:@":"];
                FbShareSheetUrl = [FbShareSheetUrl stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
                NSArray *fbUrlPieces = [FbShareSheetUrl componentsSeparatedByString:@"&t="];
                FbShareSheetPageTitle = [fbUrlPieces lastObject];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@"%5B" withString:@"["];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@"%5D" withString:@"]"];
                FbShareSheetPageTitle = [FbShareSheetPageTitle capitalizedString];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" And " withString:@" and "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" The " withString:@" the "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" A " withString:@" a "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" For " withString:@" for "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Of " withString:@" of "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" By " withString:@" by "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" The " withString:@" the "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" To " withString:@" to "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" With " withString:@" with "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" At " withString:@" at "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Or " withString:@" or "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Nor " withString:@" nor "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" But " withString:@" but "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" Yet " withString:@" yet "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" So " withString:@" so "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" By " withString:@" by "];
                FbShareSheetPageTitle = [FbShareSheetPageTitle stringByReplacingOccurrencesOfString:@" In " withString:@" in "];
                NSLog(@"FbShareSheetPageTitle:%@", FbShareSheetPageTitle);
                FbShareSheetUrl = [fbUrlPieces firstObjectCommonWithArray:fbUrlPieces];
                NSLog(@"FbShareSheetUrl:%@", FbShareSheetUrl);
                
                BOOL displayedNativeDialog =
                [FBDialogs
                 presentOSIntegratedShareDialogModallyFrom:self
                 initialText:FbShareSheetPageTitle
                 image:[UIImage imageNamed:@""]
                 url:[NSURL URLWithString:FbShareSheetUrl]
                 handler:^(FBOSIntegratedShareDialogResult result, NSError *error) {
                     if (error) {
                         /* handle failure */
                     } else {
                         if (result == FBNativeDialogResultSucceeded) {
                             /* handle success */
                             [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Facebook" withAction:@"FacebookShared" withLabel:[NSString stringWithFormat:@"FbShared: %@", FbShareSheetUrl] withValue:[NSNumber numberWithInt:1]];
                         } else {
                             /* handle user cancel */
                             [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Facebook" withAction:@"FacebookCancelled" withLabel:[NSString stringWithFormat:@"FbCancelled: %@", FbShareSheetUrl] withValue:[NSNumber numberWithInt:1]];
                         }
                     }
                 }];
                if (!displayedNativeDialog) {
                    /* handle fallback to native dialog  */
                    
                }
                
                return NO;
            } else {
                
                [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Facebook" withAction:@"showNoFacebookAccount" withLabel:@"cantPostFromFacebookShareSheet" withValue:[NSNumber numberWithInt:1]];
                
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"No Facebook Account"
                                          message:@"There is no Facebook account configured. You can add or create a Facebook account in Settings."
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
                
                return NO;
            }
        } else if((navigationType == UIWebViewNavigationTypeLinkClicked) && [SurfShell_currentUrl hasPrefix:@"http://www.facebook.com/sharer"] && [SLComposeViewController class] == nil) {
            
            NSLog(@"Does not support Social Framework and can NOT share via Facebook Sheet, open in Safari");
            
            [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Facebook" withAction:@"openFbInSafari" withLabel:FbShareSheetUrl withValue:[NSNumber numberWithInt:1]];
            
            [[UIApplication sharedApplication] openURL:request.URL];
            return NO;
        }
        
        // MAIL FUNCTION
        if([SurfShell_currentUrl hasPrefix:@"mailto:"]){
            
            // Email link format: mailto:?subject=email%20subject&body=address
            
            // Create Share Sheet URL and Page Title
            EmailShareUrl = [SurfShell_currentUrl stringByReplacingOccurrencesOfString:@"mailto:?subject=" withString:@""];
            EmailShareUrl = [EmailShareUrl stringByReplacingOccurrencesOfString:@"#" withString:@""];
            EmailShareUrl = [EmailShareUrl stringByReplacingOccurrencesOfString:@"%3A" withString:@":"];
            EmailShareUrl = [EmailShareUrl stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
            NSArray *emailUrlPieces = [EmailShareUrl componentsSeparatedByString:@"&body="];
            EmailShareTitle = [emailUrlPieces firstObjectCommonWithArray:emailUrlPieces];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@"%5B" withString:@"["];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@"%5D" withString:@"]"];
            EmailShareTitle = [EmailShareTitle capitalizedString];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" And " withString:@" and "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" The " withString:@" the "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" A " withString:@" a "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" For " withString:@" for "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" Of " withString:@" of "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" By " withString:@" by "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" The " withString:@" the "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" To " withString:@" to "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" With " withString:@" with "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" At " withString:@" at "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" Or " withString:@" or "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" Nor " withString:@" nor "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" But " withString:@" but "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" Yet " withString:@" yet "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" So " withString:@" so "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" By " withString:@" by "];
            EmailShareTitle = [EmailShareTitle stringByReplacingOccurrencesOfString:@" In " withString:@" in "];
            NSLog(@"EmailShareTitle:%@", EmailShareTitle);
            EmailShareUrl = [emailUrlPieces lastObject];
            NSLog(@"EmailShareUrl:%@", EmailShareUrl);
            
            // Check that a mail account is available
            if ([MFMailComposeViewController canSendMail]) {
                
                [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"EmailShare" withAction:@"clickedEmailShareLink" withLabel:[NSString stringWithFormat:@"Emailed: %@", EmailShareTitle] withValue:[NSNumber numberWithInt:1]];
                
                MFMailComposeViewController * emailController = [[MFMailComposeViewController alloc] init];
                emailController.mailComposeDelegate = self;
                
                [emailController setSubject:EmailShareTitle];
                [emailController setMessageBody:[NSString stringWithFormat:@"%@ <br /><br /> %@", EmailShareTitle,EmailShareUrl] isHTML:YES];
                
                [self presentViewController:emailController animated:YES completion:nil];
                
                //[emailController release];
                return NO;
            }
            // Show error if no mail account is active
            else {
                [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"EmailShare" withAction:@"clickedEmailShareLink" withLabel:@"noEmailAccountsActive" withValue:[NSNumber numberWithInt:1]];
                
                [[UIApplication sharedApplication] openURL:request.URL];
                return NO;
            }
        }
        // Open all other external links in Safari.
        if(
           ![SurfShell_currentUrl hasSuffix:@".pdf"] && ![SurfShell_currentUrl hasPrefix:SurfShell_baseUrl] && ![SurfShell_currentUrl hasPrefix:[@"https://www.google.com/url?q=" stringByAppendingString:SurfShell_baseUrl]] && ![SurfShell_currentUrl hasPrefix:@"https://twitter.com/share"] && ![SurfShell_currentUrl hasPrefix:@"http://www.facebook.com/sharer"] && ![SurfShell_currentUrl hasPrefix:@"mailto:"]
           ){
            [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"openInSafari" withAction:@"externalLinkClick" withLabel:[NSString stringWithFormat:@"External Link: %@", SurfShell_currentUrl] withValue:[NSNumber numberWithInt:1]];
            
            [[UIApplication sharedApplication] openURL:request.URL];
            return NO;
        }
        
    }
    
    // START Google Analytics Screen Tracking
    NSString *currentLongUrl = [SurfShell_currentUrl stringByReplacingOccurrencesOfString:SurfShell_baseUrl withString:@""];
    currentLongUrl = [currentLongUrl stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSArray *currentUrlPieces = [currentLongUrl componentsSeparatedByString:@"/"];
    
    
    NSMutableArray *uniqueValues = [[NSMutableArray alloc] init];
    for(id urlSegment in currentUrlPieces) {
        if(![uniqueValues containsObject:urlSegment] && ![urlSegment isEqualToString:@""] && ![urlSegment isEqualToString:@" "] && ![urlSegment isEqualToString:@"&ui-state=dialog"]) {
            [uniqueValues addObject:urlSegment];
        }
    }
    
    NSString *resultString = [[uniqueValues valueForKey:@"description"] componentsJoinedByString:@"/"];
    
    if([resultString hasSuffix:@"View%20Online"]) {
        resultString = @"/confirmation.php";
    }
    if([resultString length] < 2) {
        resultString = @"Main App Screen";
    }
    
    [[GAI sharedInstance].defaultTracker trackView:resultString];
    NSLog(@"The analytics tracking screen is: %@", resultString);
    // END Google Analytics Screen Tracking
    
    return YES;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"EmailShare" withAction:@"closeEmailModal" withLabel:@"emailSentOrCanceled" withValue:[NSNumber numberWithInt:1]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"fire webViewDidStartLoad");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}

- (void) handleDidBecomeActive: (NSNotification*) sender
{
    NSLog(@"fire handleDidBecomeActive");
    
    NSUserDefaults *customUrlPrefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *goToCustomUrl = [customUrlPrefs stringForKey:@"customURLStringModified"];
    
    if(goToCustomUrl != nil && ![goToCustomUrl isEqualToString:@""]) {
        NSLog(@"fire IF statement in handleDidBecomeActive");
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        //**************** Set URL for UIWebView
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:goToCustomUrl] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:35.0]];
        NSLog(@"goToCustomUrl in webview");
    } else {
        
        NSString *refreshView = [customUrlPrefs stringForKey:@"needsRefresh"];
        NSLog(@"REFRESH VIEW in handleDidBecomeActive is:%@", refreshView);
        
        [connectionErrorImageView removeFromSuperview];
        
        if([refreshView isEqualToString: @"Yes"]) {
            NSLog(@"refreshView = Yes");
            
            [webView addSubview:loadingImageView];
            [connectionErrorImageView removeFromSuperview];
            
            // **************** Set URL for UIWebView
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:SurfShell_baseUrl] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:35.0]];
            [activityImageView startAnimating];
            [webView addSubview:activityImageView];
            
        }
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"fire webViewDidFinishLoad");
    
    // Hide Network Activity Indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // Remove custom activity indicator
    [activityImageView removeFromSuperview];
    
    // Remove loading image
    [loadingImageView removeFromSuperview];
    
    
    NSUserDefaults *customUrlPrefs = [NSUserDefaults standardUserDefaults];
    // saving an NSString
    [customUrlPrefs setObject:nil forKey:@"customURLStringModified"];
    [customUrlPrefs setObject:@"No" forKey:@"needsRefresh"];
    NSLog(@"Clear customURLStringModified and needsRefresh in webViewDidFinishLoad");
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    if((error.code == NSURLErrorCancelled) ||(error.code == 102 && [error.domain isEqualToString:@"WebKitErrorDomain"])) {
        return;
    }
    
    if ([error code] != NSURLErrorCancelled) {
        //show error alert, etc.
        
        [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Error" withAction:@"connectionErrorShown" withLabel:@"didFailLoadWithError" withValue:[NSNumber numberWithInt:1]];
        
        NSLog(@"fire didFailLoadWithError");
        
        [activityImageView stopAnimating];
        [activityImageView removeFromSuperview];
        
        [loadingImageView removeFromSuperview];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSUserDefaults *customUrlPrefs = [NSUserDefaults standardUserDefaults];
        // saving an NSString
        [customUrlPrefs setObject:nil forKey:@"customURLStringModified"];
        NSLog(@"Clear customURLStringModified in webViewDidFinishLoad");
        
        NSString *refreshView = [customUrlPrefs stringForKey:@"needsRefresh"];
        
        if(![refreshView isEqualToString:@"Yes"]) {
            // saving an NSString
            [customUrlPrefs setObject:@"Yes" forKey:@"needsRefresh"];
            NSLog(@"Set needsRefresh to Yes");
        }
        
        
        // Get device screen pixel dimensions
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        NSString *screenDimensions = NSStringFromCGRect(screenBounds);
        NSLog(@"Screen Dimensions:%@", screenDimensions);
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if([screenDimensions rangeOfString:@"568"].location == NSNotFound) {
                NSLog(@"Detected iPhone regular height");
                // Start Add Connection Error image
                UIImage *connectionErrorImage = [UIImage imageNamed:@"connectionError.png"];
                connectionErrorImageView = [[UIImageView alloc] initWithImage:connectionErrorImage];
                connectionErrorImageView.animationImages = [NSArray arrayWithObjects:
                                                            [UIImage imageNamed:@"connectionError.png"],
                                                            nil];
                [self.view addSubview:connectionErrorImageView];
                // End Add Connection Error image
            }
            
            if([screenDimensions rangeOfString:@"568"].location != NSNotFound) {
                NSLog(@"Detected iPhone 5 - tall");
                // Start Add Connection Error image
                UIImage *connectionErrorImage = [UIImage imageNamed:@"connectionError-568h.png"];
                connectionErrorImageView = [[UIImageView alloc] initWithImage:connectionErrorImage];
                connectionErrorImageView.animationImages = [NSArray arrayWithObjects:
                                                            [UIImage imageNamed:@"connectionError-568h.png"],
                                                            nil];
                [self.view addSubview:connectionErrorImageView];
                // End Add Connection Error image
            }
        }
        
    }
}

// section to change the background image depending on the device orientation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    NSUserDefaults *customUrlPrefs = [NSUserDefaults standardUserDefaults];
    NSString *refreshView = [customUrlPrefs stringForKey:@"needsRefresh"];
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        // code for Portrait orientation
        [loadingImageView removeFromSuperview];
        [activityImageView removeFromSuperview];
        [connectionErrorImageView removeFromSuperview];
        
        if([refreshView isEqualToString:@"Yes"]) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
                // Get device screen pixel dimensions
                CGRect screenBounds = [[UIScreen mainScreen] bounds];
                NSString *screenDimensions = NSStringFromCGRect(screenBounds);
                NSLog(@"Screen Dimensions:%@", screenDimensions);
                
                //If Screen Dimensions does not contain 568, set normal image
                if([screenDimensions rangeOfString:@"568"].location == NSNotFound) {
                    UIImage *connectionErrorImage = [UIImage imageNamed:@"connectionError.png"];
                    connectionErrorImageView = [[UIImageView alloc] initWithImage:connectionErrorImage];
                    connectionErrorImageView.animationImages = [NSArray arrayWithObjects:
                                                                [UIImage imageNamed:@"connectionError.png"],
                                                                nil];
                } else {
                    UIImage *connectionErrorImage = [UIImage imageNamed:@"connectionError-568h.png"];
                    connectionErrorImageView = [[UIImageView alloc] initWithImage:connectionErrorImage];
                    connectionErrorImageView.animationImages = [NSArray arrayWithObjects:
                                                                [UIImage imageNamed:@"connectionError-568h.png"],
                                                                nil];
                }
            }
            
            
            [self.view addSubview:connectionErrorImageView];
        }
    }
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        // code for Landscape orientation
        [loadingImageView removeFromSuperview];
        [activityImageView removeFromSuperview];
        [connectionErrorImageView removeFromSuperview];
        
        if([refreshView isEqualToString: @"Yes"]) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
                // Get device screen pixel dimensions
                CGRect screenBounds = [[UIScreen mainScreen] bounds];
                NSString *screenDimensions = NSStringFromCGRect(screenBounds);
                NSLog(@"Screen Dimensions:%@", screenDimensions);
                
                //If Screen Dimensions does not contain 568, set normal image
                if([screenDimensions rangeOfString:@"568"].location == NSNotFound) {
                    UIImage *connectionErrorImage = [UIImage imageNamed:@"connectionError.png"];
                    connectionErrorImageView = [[UIImageView alloc] initWithImage:connectionErrorImage];
                    connectionErrorImageView.animationImages = [NSArray arrayWithObjects:
                                                                [UIImage imageNamed:@"connectionError.png"],
                                                                nil];
                } else {
                    UIImage *connectionErrorImage = [UIImage imageNamed:@"connectionError-568h.png"];
                    connectionErrorImageView = [[UIImageView alloc] initWithImage:connectionErrorImage];
                    connectionErrorImageView.animationImages = [NSArray arrayWithObjects:
                                                                [UIImage imageNamed:@"connectionError-568h.png"],
                                                                nil];
                }
            }
            
            [self.view addSubview:connectionErrorImageView];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    alertShowing = @"No";
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if(([title isEqualToString:@"Ok"]) && (buttonIndex == 0))
    {
        //Exit button clicked
        //exit(0);
        [self removeFromParentViewController];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    NSLog(@"fire viewDidUnload");
    // Release any retained subviews of the main view.
    
    if ( [self->webView isLoading] ) {
        [self->webView stopLoading];
    }
    [activityImageView stopAnimating];
    [activityImageView removeFromSuperview];
    [loadingImageView removeFromSuperview];
    [connectionErrorImageView removeFromSuperview];
    [webView removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSUserDefaults *customUrlPrefs = [NSUserDefaults standardUserDefaults];
    // saving an NSString
    [customUrlPrefs setObject:nil forKey:@"customURLStringModified"];
    [customUrlPrefs setObject:@"No" forKey:@"needsRefresh"];
    NSLog(@"Clear customURLStringModified and needsRefresh in webViewDidFinishLoad");
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
