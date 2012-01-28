//
//  MyBrowserViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 13/12/11.
//  Copyright (c) 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iVagabroAppDelegate.h"

@interface MyBrowserViewController : UIViewController<UIWebViewDelegate> {
   
    IBOutlet UIWebView *webView;
    iVagabroAppDelegate *appDelegate;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}

@end
