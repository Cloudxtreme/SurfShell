SurfShell v1.0
=========

**_README UNDER CONSTRUCTION_**

A powerful iOS app shell to turn any website into an elegant, releasable iOS app that can utilize native iOS device actions. Created and maintained by [@adamdehaven](#author).

## FEATURES

* Easily configurable default settings.
* Commented code for easy customizations.
* Native iOS Twitter, Facebook, & Email sharing.
* Google Analytics iOS SDK integration for easy screen tracking.
* **Modal View** for displaying local & external PDFs, external web pages, etc.
* **Network Connectivity Monitor** that displays an error graphic (customizable) if App is launched and cannot access the web. 
	* Rechecks network connection when user returns to app and reloads defined homepage upon connection.

## REQUIREMENTS

* XCode v4.6.3+
* iOS v6.1+
* Facebook Page with page id (Optional - To link to app via Facebook's native iOS App)
* [Google Analytics for iOS](https://developers.google.com/analytics/devguides/collection/ios/v2/) App Tracking Code (Optional)

## SETUP
STEP|INSTRUCTIONS
:---:|---
1.|[Download SurfShell](https://github.com/adamdehaven/SurfShell/archive/master.zip).
2.|In XCode, open `SurfShell.xcodeproj`
3.|Open `SurfShell_Globals.h` and modify the [Global Variables](#global-variables).
4.|Open `SurfShell-Info.plist` within the **Supporting Files** group and modify the following fields:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. Change the value for `FacebookAppID` to your Facebook Page ID.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. Change the value for `FacebookDisplayName` to the name of your app.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c. Change the `Application Category` to your desired App Category for the App Store.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d. Within the `.plist` file, navigate to `URL types` \ `Item 0` \ `URL Schemes`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i. Change the value of `Item 0` to match the `SurfShell_customUrlScheme` in `SurfShell_Globals.h`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;just the string; ex. `surfshell`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ii. Change the value of `Item 1` to your Facebook Page ID, leaving the `fb` prefix.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ex. `fb123456789123456`
5.|Rename the Project to your desired App Name, and accept XCode's suggested Rename changes. ![Rename XCode Project](https://github.com/adamdehaven/SurfShell/raw/master/docs/rename-project.png)
6.|In the XCode Navigator, open the **Supporting Files** group. If your `MyProject-Info.plist` and `MyProject-Prefix.pch` files appear **red** in color, follow these steps for both:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. Click the file to select it.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. On the right side of XCode, click the file source button (shown below)<br>![XCode File Source Button](https://github.com/adamdehaven/SurfShell/raw/master/docs/file-source-button.png)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Select the file XCode *should* be pointed to (in reality, it will appear as if you're selecting the same file being linked to). Repeat for the second file.
7.|After renaming, click on your Project in the XCode Navigator, and then click on the **Summary** tab. Check for a button that reads "Choose Info.plist File..." (shown below)<br>![Choose Info.plist Button](https://github.com/adamdehaven/SurfShell/raw/master/docs/choose-info-plist.png)<br>If the button is present, click the button, select the suggested `MyProject-Info.plist` file, and click **Choose** to select it.<br>![Select Info.plist Button](https://github.com/adamdehaven/SurfShell/raw/master/docs/select-info-plist.png)
8.|Select **iOS Device** as the destination for your project ( **Product** \ **Destination** \ **iOS Device** ) and then Clean the Product ( **Product** \ **Clean** ).
9.|If you will be linking to any **PDF** documents from the app, drag them into the `pdf` folder within the **Supporting Files** group. Be sure to check the box to **Copy items into destination group's folder (if needed)** as well as the box **Add to targets**. 

## GLOBAL VARIABLES

All variables are set within `SurfShell_Globals.h`

###Variable Format
Variables are all set using `#define` with a constructor `@""`

#####String Variables
```
#define stringVariableName @"value"
```
#####Array Variables
```
#define arrayVariableName [NSMutableArray arrayWithObjects: @"object", @"object-two", @"Another object", nil]
```

### Default Variables
```objc 
# Note: Hash removed from #define statements to enable code highlighting for display purposes
define SurfShell_companyOrSiteName @"SurfShell"
define SurfShell_loadUrl @"http://www.example.com/"
define SurfShell_baseUrl @"http://www.example.com/" 
define SurfShell_customUrlScheme @"surfshell://" 
define SurfShell_pagesToOpenInModal [NSMutableArray arrayWithObjects: @"contact-us.php", @"directory/sub-directory", nil]
define SurfShell_closeModalOnClick YES 
define SurfShell_pagesToOpenInSafari [NSMutableArray arrayWithObjects: @"external-page.html", @"tracking/", nil]
define SurfShell_twitterHandle @"adamdehaven"
define SurfShell_userAgent_iPhone5 @"SurfShell_iOS_App_Tall" 
define SurfShell_userAgent_iPhone @"SurfShell_iOS_App" 
define SurfShell_kTrackingId @"UA-XXXXXXX-X"
```

### Variable Descriptions

Variable|Description|Default
---|---|---
`SurfShell_companyOrSiteName`|The name of your company, website, app, etc.|`SurfShell`
`SurfShell_loadUrl`|The URL to load upon app launch. **You must include the trailing slash!**|`http://www.example.com/`
`SurfShell_baseUrl`|The base URL for your website. In most cases, this is the same value set for `SurfShell_loadUrl` above.|`http://www.example.com/`
`SurfShell_customUrlScheme`|The custom URL Scheme used to launch the app from within *other* apps or Safari.|`surfshell://`
`SurfShell_pagesToOpenInModal`|An array of pages you would like to open within a modal view without exiting the app. This can include single pages or even entire directories. Files ending in `.pdf` are included by default. The values in the array are defined by including all or partial URLs, whatever comes directly after the trailing slash in your `SurfShell_baseUrl` set above.|**NONE**
`SurfShell_closeModalOnClick`|Boolean `YES` or `NO` value. When set to `YES`, any link clicked within an open modal will prevent the default link action and automatically close the modal returning to the main app view where the user entered the modal.|`YES`
`SurfShell_pagesToOpenInSafari`|An array of pages you would like to open externally with Safari by switching away from the app. This can include single pages or even entire directories. The values in the array are defined by including all or partial URLs, whatever comes directly after the trailing slash in your `SurfShell_baseUrl` set above.|**NONE**
`SurfShell_twitterHandle`|Your Twitter username without the `@` symbol.|`adamdehaven`
`SurfShell_userAgent_iPhone5`|Browser User Agent set by the app running on an iPhone 5 (or future iPhones with a default `568` height. Useful if your web content is altered depending on device, screen size, etc.|`SurfShell_iOS_App_Tall`
`SurfShell_userAgent_iPhone`|Browser User Agent set by the app running on an iPhone (not tall). Useful if your web content is altered depending on device, screen size, etc.|`SurfShell_iOS_App`
`SurfShell_kTrackingId`|Google Analytics iOS App Tracking ID. If you have not yet set up a profile in Google Analytics, do so [now](https://developers.google.com/analytics/devguides/collection/ios/v2/).|`UA-XXXXXXX-X`

## AUTHOR

**Adam Dehaven**
* [http://about.adamdehaven.com](http://about.adamdehaven.com)
* [http://twitter.com/adamdehaven](http://twitter.com/adamdehaven)
* [http://github.com/adamdehaven](http://github.com/adamdehaven)

## COPYRIGHT &amp; LICENSE

Copyright &copy; 2013 Adam Dehaven under [the MIT License](https://github.com/adamdehaven/SurfShell/blob/master/LICENSE)
