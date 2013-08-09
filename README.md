SurfShell v1.0
=========

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

1. [Download SurfShell](https://github.com/adamdehaven/SurfShell/archive/master.zip).
2. In XCode, open `SurfShell.xcodeproj`
3. Rename the Project to your desired App Name. 
![Rename XCode Project](https://github.com/adamdehaven/SurfShell/raw/master/docs/rename-project.png)
4. Open `SurfShell_Globals.h` and modify the [default settings](#defaults). 

## DEFAULTS
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
