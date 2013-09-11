/* ==========================================================
 * SurfShell_ModalViewController.h
 * SurfShell v2.0
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
#import "GAITrackedViewController.h"
#import "GAITracker.h"

enum {
    SurfShell_WebViewControllerAvailableActionsNone             = 0,
    SurfShell_WebViewControllerAvailableActionsOpenInSafari     = 1 << 0,
    SurfShell_WebViewControllerAvailableActionsMailLink         = 1 << 1,
    SurfShell_WebViewControllerAvailableActionsMailPDF          = 1 << 2,
    SurfShell_WebViewControllerAvailableActionsCopyLink         = 1 << 3
};

typedef NSUInteger SurfShell_WebViewControllerAvailableActions;


@class SurfShell_WebViewController;

@interface SurfShell_ModalViewController : UINavigationController

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL *)URL;

@property (nonatomic, strong) UIColor *barsTintColor;
@property (nonatomic, readwrite) SurfShell_WebViewControllerAvailableActions availableActions;

@end
