/* ==========================================================
 * SurfShell_AppDelegate.m
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

#import "SurfShell_AppDelegate.h"

@implementation SurfShell_AppDelegate

@synthesize window = window_;
@synthesize tracker = tracker_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker.
    self.tracker = [[GAI sharedInstance] trackerWithName:SurfShell_companyOrSiteName
                                              trackingId:SurfShell_GA_trackingID];
    return YES;
}

// Handle custom URL Scheme: SurfShell_customUrlScheme
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *customURLString = [url absoluteString];
    
    //Rewrite custom URL to usable URL
    NSString *customURLStringModified = [customURLString stringByReplacingOccurrencesOfString:SurfShell_customUrlScheme withString:SurfShell_baseUrl];
    
    NSUserDefaults *customUrlPrefs = [NSUserDefaults standardUserDefaults];
    [customUrlPrefs setObject:customURLStringModified forKey:@"customURLStringModified"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
