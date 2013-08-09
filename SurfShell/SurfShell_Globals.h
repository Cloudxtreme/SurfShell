/* ==========================================================
 * SurfShell_Globals.h
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

#import <Foundation/Foundation.h>

/* ==========================================================
 * Edit Global Variables Below
 */

// Company or Website Name
#define SurfShell_companyOrSiteName @"SurfShell"

// URL to load on app launch.
#define SurfShell_loadUrl @"http://www.example.com/"

// Base URL for site. ( May be same (and usually is the same) as SurfShell_loadUrl ) & include trailing slash.
#define SurfShell_baseUrl @"http://www.example.com/" 

// Set custom URL Scheme for app. Used for app linking. Also must define URL Scheme in Supporting Files / SurfShell-Info.plist
#define SurfShell_customUrlScheme @"surfshell://" 

// Define pages (path after SurfShell_baseUrl) to open within app modal. PDF files are already included.
// Ex: http://www.example.com/contact-us.php = @"contact-us.php". Can include whole directory like @"products/"
#define SurfShell_pagesToOpenInModal [NSMutableArray arrayWithObjects: @"contact-us.php",nil]

// Close modals if user clicks any link shown within? (Good for displaying confirmation pages, etc.) YES or NO. Default: YES
#define SurfShell_closeModalOnClick YES 

// Open page(s) in Safari, rather than in the app. (path after SurfShell_baseUrl) 
// Ex: http://www.example.com/external/page.html = @"external/page.html". Can include whole directory like @"products/"
#define SurfShell_pagesToOpenInSafari [NSMutableArray arrayWithObjects: @"products/",nil]

// Twitter username without the "@" symbol
#define SurfShell_twitterHandle @"adamdehaven"

// Set custom user agent for iPhone 5.
#define SurfShell_userAgent_iPhone5 @"SurfShell_iOS_App_Tall" 

// Set custom user agent for other iPhones.
#define SurfShell_userAgent_iPhone @"SurfShell_iOS_App" 

// Set Google Analytics iOS App Tracking code. https://developers.google.com/analytics/devguides/collection/ios/v2/
#define SurfShell_kTrackingId @"UA-XXXXXXX-X" 

/*
 * DO NOT EDIT BELOW
 * ==========================================================
 */

@interface SurfShell_Globals : NSObject

@end
