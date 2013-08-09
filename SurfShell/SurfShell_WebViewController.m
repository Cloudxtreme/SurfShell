/* ==========================================================
 * SurfShell_WebViewController.m
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

#import "SurfShell_WebViewController.h"

@interface SurfShell_WebViewController () <UIWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong, readonly) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *refreshBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *stopBarButtonItem;
@property (nonatomic, strong, readonly) UIBarButtonItem *actionBarButtonItem;
@property (nonatomic, strong, readonly) UIActionSheet *pageActionSheet;
@property (nonatomic, strong, retain) NSString *SurfShell_pdfName;

@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) NSURL *URL;

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;

- (void)updateToolbarItems;

- (void)goBackClicked:(UIBarButtonItem *)sender;
- (void)goForwardClicked:(UIBarButtonItem *)sender;
- (void)reloadClicked:(UIBarButtonItem *)sender;
- (void)stopClicked:(UIBarButtonItem *)sender;
- (void)actionButtonClicked:(UIBarButtonItem *)sender;

@end


@implementation SurfShell_WebViewController

@synthesize availableActions;

@synthesize URL, mainWebView;
@synthesize backBarButtonItem, forwardBarButtonItem, refreshBarButtonItem, stopBarButtonItem, actionBarButtonItem, pageActionSheet;

@synthesize activityImageView;
@synthesize connectionErrorImageView;
@synthesize SurfShell_pdfName;

#pragma mark - setters and getters

- (UIBarButtonItem *)backBarButtonItem {
    
    if (!backBarButtonItem) {
        backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SurfShell_WebViewController.bundle/iPhone/back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackClicked:)];
        backBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		backBarButtonItem.width = 18.0f;
    }
    return backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    
    if (!forwardBarButtonItem) {
        forwardBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SurfShell_WebViewController.bundle/iPhone/forward"] style:UIBarButtonItemStylePlain target:self action:@selector(goForwardClicked:)];
        forwardBarButtonItem.imageInsets = UIEdgeInsetsMake(2.0f, 0.0f, -2.0f, 0.0f);
		forwardBarButtonItem.width = 18.0f;
    }
    return forwardBarButtonItem;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    
    if (!refreshBarButtonItem) {
        refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadClicked:)];
    }
    
    return refreshBarButtonItem;
    
}

- (UIBarButtonItem *)stopBarButtonItem {
    
    if (!stopBarButtonItem) {
        stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopClicked:)];
    }
    return stopBarButtonItem;
}

- (UIBarButtonItem *)actionBarButtonItem {
    
    if (!actionBarButtonItem) {
        actionBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonClicked:)];
        
    }
    return actionBarButtonItem;
}

- (UIActionSheet *)pageActionSheet {
    
    if(!pageActionSheet) {
        if([SurfShell_currentUrl hasSuffix:@".pdf"]) {
            pageActionSheet = [[UIActionSheet alloc]
                               initWithTitle:pdfTitle
                               delegate:self
                               cancelButtonTitle:nil
                               destructiveButtonTitle:nil
                               otherButtonTitles:nil];
        }
        else {
            pageActionSheet = [[UIActionSheet alloc]
                               initWithTitle:self.mainWebView.request.URL.absoluteString
                               delegate:self
                               cancelButtonTitle:nil
                               destructiveButtonTitle:nil
                               otherButtonTitles:nil];
        }
        
        if([MFMailComposeViewController canSendMail] && (self.availableActions & SurfShell_WebViewControllerAvailableActionsMailPDF) == SurfShell_WebViewControllerAvailableActionsMailPDF)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"Email PDF", @"")];
        
        if([MFMailComposeViewController canSendMail] && (self.availableActions & SurfShell_WebViewControllerAvailableActionsMailLink) == SurfShell_WebViewControllerAvailableActionsMailLink)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"Mail link", @"")];
        
        if((self.availableActions & SurfShell_WebViewControllerAvailableActionsCopyLink) == SurfShell_WebViewControllerAvailableActionsCopyLink)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"Copy link", @"")];
        
        if((self.availableActions & SurfShell_WebViewControllerAvailableActionsOpenInSafari) == SurfShell_WebViewControllerAvailableActionsOpenInSafari)
            [pageActionSheet addButtonWithTitle:NSLocalizedString(@"Open in Safari", @"")];
        
        [pageActionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
        pageActionSheet.cancelButtonIndex = [self.pageActionSheet numberOfButtons]-1;
    }
    
    return pageActionSheet;
}

#pragma mark - Initialization

- (id)initWithAddress:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (id)initWithURL:(NSURL*)pageURL {
    
    if(self = [super init]) {
        self.URL = pageURL;
        self.availableActions = SurfShell_WebViewControllerAvailableActionsOpenInSafari | SurfShell_WebViewControllerAvailableActionsMailLink;
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    mainWebView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mainWebView.delegate = self;
    mainWebView.scalesPageToFit = YES;
    [mainWebView loadRequest:[NSURLRequest requestWithURL:self.URL]];
    self.view = mainWebView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    [self updateToolbarItems];
    
    NSLog(@"SurfShell_WebViewController.m viewDidLoad");
    
    // Get requested URL and set to variable SurfShell_currentUrl
    SurfShell_currentUrl = self.URL.absoluteString;
    NSLog(@"SurfShell_currentUrl:%@", SurfShell_currentUrl);
    
    //Get PDF file name
    NSArray *urlArray = [SurfShell_currentUrl componentsSeparatedByString:@"/"];
    SurfShell_fullDocumentName = [urlArray lastObject];
    NSLog(@"SurfShell_fullDocumentName:%@", SurfShell_fullDocumentName);
    
    //Get PDF file name without ".pdf"
    NSArray *docName = [SurfShell_fullDocumentName componentsSeparatedByString:@"."];
    SurfShell_pdfName = [docName objectAtIndex:0];
    NSLog(@"SurfShell_pdfName:%@", SurfShell_pdfName);
    
    pdfTitle = [SurfShell_pdfName stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    NSLog(@"pdfTitle:%@", pdfTitle);
    
    // Google Analytics Screen Name
    self.trackedViewName = [NSString stringWithFormat:@"Modal View: %@", pdfTitle];
    
    self->mainWebView.scrollView.bounces = NO;
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"mainWebView shouldStartLoadWithRequest");
    
    // If click link in modal, close modal
    if(navigationType == UIWebViewNavigationTypeLinkClicked && SurfShell_closeModalOnClick == YES){
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        return NO;
    }
    
    return YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    mainWebView = nil;
    backBarButtonItem = nil;
    forwardBarButtonItem = nil;
    refreshBarButtonItem = nil;
    stopBarButtonItem = nil;
    actionBarButtonItem = nil;
    pageActionSheet = nil;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSAssert(self.navigationController, @"SurfShell_WebViewController needs to be contained in a UINavigationController. If you are presenting SurfShell_WebViewController modally, use SurfShell_ModalViewController instead.");
    
	[super viewWillAppear:animated];
	
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:YES animated:animated];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark - Toolbar

- (void)updateToolbarItems {
    self.backBarButtonItem.enabled = self.mainWebView.canGoBack;
    self.forwardBarButtonItem.enabled = self.mainWebView.canGoForward;
    self.actionBarButtonItem.enabled = !self.mainWebView.isLoading;
    
    UIBarButtonItem *refreshStopBarButtonItem = self.mainWebView.isLoading ? self.stopBarButtonItem : self.refreshBarButtonItem;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 5.0f;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        NSArray *items;
        CGFloat toolbarWidth = 250.0f;
        
        if(self.availableActions == 0) {
            toolbarWidth = 200.0f;
            items = [NSArray arrayWithObjects:
                     fixedSpace,
                     refreshStopBarButtonItem,
                     flexibleSpace,
                     self.backBarButtonItem,
                     flexibleSpace,
                     self.forwardBarButtonItem,
                     fixedSpace,
                     nil];
        }
        else {
            items = [NSArray arrayWithObjects:
                     fixedSpace,
                     //refreshStopBarButtonItem,
                     //flexibleSpace,
                     //self.backBarButtonItem,
                     //flexibleSpace,
                     //self.forwardBarButtonItem,
                     flexibleSpace,
                     self.actionBarButtonItem,
                     fixedSpace,
                     nil];
        }
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, toolbarWidth, 44.0f)];
        toolbar.items = items;
        toolbar.tintColor = self.navigationController.navigationBar.tintColor;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolbar];
        
    }
    
    else {
        NSArray *items;
        
        if(self.availableActions == 0) {
            items = [NSArray arrayWithObjects:
                     flexibleSpace,
                     self.backBarButtonItem,
                     flexibleSpace,
                     self.forwardBarButtonItem,
                     flexibleSpace,
                     refreshStopBarButtonItem,
                     flexibleSpace,
                     nil];
        } else {
            items = [NSArray arrayWithObjects:
                     fixedSpace,
                     self.backBarButtonItem,
                     flexibleSpace,
                     self.forwardBarButtonItem,
                     flexibleSpace,
                     refreshStopBarButtonItem,
                     flexibleSpace,
                     self.actionBarButtonItem,
                     fixedSpace,
                     nil];
        }
        
        self.navigationItem.rightBarButtonItem = actionBarButtonItem;
        //self.toolbarItems = items;
    }
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)mainWebView {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self updateToolbarItems];
    
    /**************** --- START CUSTOM ACTIVITY INDICATOR ****************/
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
                                         self.view.frame.size.width/2
                                         -statusImage.size.width/2,
                                         self.view.frame.size.height/2
                                         -statusImage.size.height/2,
                                         statusImage.size.width,
                                         statusImage.size.height);
    
    //Start the animation
    [activityImageView startAnimating];
    
    //Add your custom activity indicator to your current view
    [self.view addSubview:activityImageView];
    /*  --- END CUSTOM ACTIVITY INDICATOR */
    
}


- (void)webViewDidFinishLoad:(UIWebView *)mainWebView {
    
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    // Remove custom activity indicator
    [activityImageView removeFromSuperview];
    
    if([SurfShell_currentUrl hasSuffix:@".pdf"]) {
        self.navigationItem.title = pdfTitle;
        [self updateToolbarItems];
    } else {
        [self updateToolbarItems];
    }
    
}

- (void)mainWebView:(UIWebView *)mainWebView didFailLoadWithError:(NSError *)error {
    [self updateToolbarItems];
    
    if ([error code] != NSURLErrorCancelled) {
        //show error alert, etc.
        
        NSLog(@"fire didFailLoadWithError");
        
        [activityImageView stopAnimating];
        [activityImageView removeFromSuperview];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        // Start Add Connection Error image
        UIImage *connectionErrorImage = [UIImage imageNamed:@"connectionError.png"];
        connectionErrorImageView = [[UIImageView alloc] initWithImage:connectionErrorImage];
        connectionErrorImageView.animationImages = [NSArray arrayWithObjects:
                                                    [UIImage imageNamed:@"connectionError.png"],
                                                    nil];
        [self.view addSubview:connectionErrorImageView];
        // End Add Connection Error image
        
        // Alert messages depending on loading error
        NSString *errorMsg = nil;
        
        if ([[error domain] isEqualToString:NSURLErrorDomain]) {
            switch ([error code]) {
                case NSURLErrorCannotFindHost:
                    errorMsg = NSLocalizedString(@"Cannot find specified host. Please exit and try again shortly.", nil);
                    break;
                case NSURLErrorCannotConnectToHost:
                    errorMsg = NSLocalizedString(@"Cannot connect to SurfShell_baseUrl website. Server may be down.", nil);
                    break;
                case NSURLErrorNotConnectedToInternet:
                    errorMsg = NSLocalizedString(@"Cannot connect to the Internet. Please enable Wi-Fi or check your network connection.", nil);
                    break;
                default:
                    errorMsg = [error localizedDescription];
                    break;
            }
        } else {
            errorMsg = [error localizedDescription];
        }
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:
                           NSLocalizedString(@"Error Loading Request", nil)
                                                     message:errorMsg delegate:self
                                           cancelButtonTitle:@"Exit" otherButtonTitles:nil];
        [av show];
    }
}

#pragma mark - Target actions

- (void)goBackClicked:(UIBarButtonItem *)sender {
    [mainWebView goBack];
}

- (void)goForwardClicked:(UIBarButtonItem *)sender {
    [mainWebView goForward];
}

- (void)reloadClicked:(UIBarButtonItem *)sender {
    [mainWebView reload];
}

- (void)stopClicked:(UIBarButtonItem *)sender {
    [mainWebView stopLoading];
	[self updateToolbarItems];
}

- (void)actionButtonClicked:(id)sender {
    
    if(pageActionSheet)
        return;
	
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        [self.pageActionSheet showFromBarButtonItem:self.actionBarButtonItem animated:YES];
    else
        [self.pageActionSheet showFromToolbar:self.navigationController.toolbar];
    
}

- (void)doneButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    
	if([title isEqualToString:NSLocalizedString(@"Open in Safari", @"")])
        [[UIApplication sharedApplication] openURL:self.mainWebView.request.URL];
    
    if([title isEqualToString:NSLocalizedString(@"Copy link", @"")]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.mainWebView.request.URL.absoluteString;
    }
    
    if([title isEqualToString:NSLocalizedString(@"Mail link", @"")]) {
        
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
		mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:pdfTitle];
  		[mailViewController setMessageBody:self.mainWebView.request.URL.absoluteString isHTML:NO];
		mailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Email" withAction:@"Clicked to Email Link" withLabel:[NSString stringWithFormat:@"Email link: %@", SurfShell_fullDocumentName] withValue:[NSNumber numberWithInt:1]];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
	}
    
    if([title isEqualToString:NSLocalizedString(@"Email PDF", @"")]) {
        
		MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
		mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:pdfTitle];
        
        NSString *newFilePath = [[NSBundle mainBundle] pathForResource:SurfShell_pdfName ofType:@"pdf"];
        NSData *pdfData = [NSData dataWithContentsOfFile:newFilePath];
        [mailViewController addAttachmentData:pdfData mimeType:@"application/pdf" fileName:SurfShell_fullDocumentName];
        
  		[mailViewController setMessageBody:[NSString stringWithFormat:@"%@ via %@ ", pdfTitle, SurfShell_companyOrSiteName] isHTML:NO];
		mailViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [[GAI sharedInstance].defaultTracker trackEventWithCategory:@"Email" withAction:@"Clicked to Email PDF" withLabel:[NSString stringWithFormat:@"Email PDF: %@", SurfShell_fullDocumentName] withValue:[NSNumber numberWithInt:1]];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
	}
    
    pageActionSheet = nil;
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
