//
//  YouTubeViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 04/12/11.
//  Copyright (c) 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iVagabroAppDelegate.h"
#import "MyBrowserViewController.h"


@interface YouTubeViewController : UIViewController<UIWebViewDelegate>
{
   	IBOutlet UIWebView *webView;
    IBOutlet UILabel *primaryLabel;
    IBOutlet UITextView *secondaryLabel;
    iVagabroAppDelegate* appDelegate;
    MyBrowserViewController* myBrowserView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UILabel *primaryLabel;
@property (nonatomic, retain) UITextView *secondaryLabel;

@end
