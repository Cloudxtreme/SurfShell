SurfShell v1.0
=========

A powerful iOS app shell to turn any website into an elegant, releasable iOS app that can utilize native iOS device actions. Created and maintained by [@adamdehaven](#author).

## FEATURES

* Easily configurable default settings.
* Native iOS Twitter, Facebook, & Email sharing.
* Google Analytics iOS SDK integration for easy screen tracking.
* **Modal View** for displaying local & external PDFs, confirmation messages, external websites, etc.
* **Network Connectivity Monitor** for displaying an error graphic if App is launched and cannot access the web. 
	* Rechecks network connection when user returns to app and reloads upon connection.
* Commented code for easy customizations.

## REQUIREMENTS

* XCode v4.6.3+
* iOS v6.1+
* Facebook Page with page id (Optional - To link to app via Facebook's native iOS App)
* [Google Analytics for iOS](https://developers.google.com/analytics/devguides/collection/ios/v2/) App Tracking Code (Optional)

## SETUP

While the steps appear complicated at first sight, these **{INSERT NUMBER}** steps will have your app up and running in **_less than 5 minutes_**!

STEP|INSTRUCTIONS
:---:|---
1.|[Download the SurfShell package](https://github.com/adamdehaven/SurfShell/archive/master.zip).
2.|Open `SurfShell.xcodeproj` in XCode.
3.|Modify `SurfShell_Globals.h` by changing the values for all desired [Global Variables](#global-variables).
4.|Open `SurfShell-Info.plist` within the **Supporting Files** group and modify the following fields:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. Change the value for `FacebookAppID` to your Facebook Page ID (optional).<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. Change the value for `FacebookDisplayName` to the name of your app (optional).<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c. Change the `Application Category` to your desired App Category for the App Store (optional).<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d. Within this `.plist` file, navigate to `URL types` \ `Item 0` \ `URL Schemes`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i. Change the value of `Item 0` to match the `SurfShell_customUrlScheme` in `SurfShell_Globals.h`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;just the string; ex. `surfshell`<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ii. Change the value of `Item 1` to your Facebook Page ID, leaving the `fb` prefix (optional).<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ex. `fb123456789123456`
5.|Rename the Project to your desired App Name, and accept XCode's suggested Rename changes. ![Rename XCode Project](https://github.com/adamdehaven/SurfShell/raw/master/docs/rename-project.png)
6.|In the XCode Navigator, open the **Supporting Files** group. If your `MyProject-Info.plist` and `MyProject-Prefix.pch` files appear **red** in color, follow these steps for both:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. Click the file to select it.<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. On the right side of XCode, click the file source button (shown below)<br>![XCode File Source Button](https://github.com/adamdehaven/SurfShell/raw/master/docs/file-source-button.png)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Select the file XCode *should* be pointed to (in reality, it will appear as if you're selecting the same file being linked to). Repeat for the second file.
7.|After renaming, click on your Project in the XCode Navigator, and then click on the **Summary** tab. Check for a button that reads "Choose Info.plist File..." (shown below)<br>![Choose Info.plist Button](https://github.com/adamdehaven/SurfShell/raw/master/docs/choose-info-plist.png)<br>If the button is present, click the button, select the suggested `MyProject-Info.plist` file, and click **Choose** to select it.<br>![Select Info.plist Button](https://github.com/adamdehaven/SurfShell/raw/master/docs/select-info-plist.png)
8.|Select **iOS Device** as the destination for your project ( **Product** \ **Destination** \ **iOS Device** ) and then Clean the Product ( **Product** \ **Clean** ).
9.|If you will be linking to any **PDF** documents from the app, drag them into the `pdf` folder within the **Supporting Files** group. Be sure to check the box to **Copy items into destination group's folder (if needed)** as well as the box **Add to targets**.
10.|Select a target for your App (iOS Simulator, Device, etc.) and **Run**. That's it!

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

VARIABLE|DESCRIPTION|DEFAULT
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

## NOTES

1. The loading spinner can be modified in an image editor such as [Gimp](http://www.gimp.org). If you'd just like a different color, just change the **Hue** of each of the images in the **graphics/activityImageView** folder.
2. The Launch image (`Default.png`), webView loading image (`webViewLoadImage.png`), and connection error image (`connectionError.png`) are basically the same image with different file names, with the connection error having a message over the logo. You may create your own images, name them the same, and just mirror the dimensions for each file found in the **graphics** folder. You will need 4 different sizes for each image, shown in the table below:

FILE NAME|SIZE|DEVICE(S)
---|:---:|:---:
`Default.png`<br>`webViewLoadImage.png`<br>`connectionError.png`|320 x 480|iPhone (non-retina)
`Default@2x.png`<br>`webViewLoadImage@2x.png`<br>`connectionError@2x.png`|640 x 960|iPhone (retina)
`webViewLoadImage-568h.png`<br>`connectionError-568h.png`|320 x 568|N/A (as of 8/2013)
`Default-568h@2x.png`<br>`webViewLoadImage-568h@2x.png`<br>`connectionError-568h@2x.png`|640 x 1136|iPhone Tall (retina)

## AUTHOR

**Adam Dehaven**
* [http://about.adamdehaven.com](http://about.adamdehaven.com)
* [http://twitter.com/adamdehaven](http://twitter.com/adamdehaven)
* [http://github.com/adamdehaven](http://github.com/adamdehaven)

## COPYRIGHT &amp; LICENSE

Copyright &copy; 2013 Adam Dehaven under [the MIT License](https://github.com/adamdehaven/SurfShell/blob/master/LICENSE)
