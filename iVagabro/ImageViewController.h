//
//  SinglePostViewController.h
//  LuBannApp
//
//  Created by Fr@nk on 06/03/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iVagabroAppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface ImageViewController : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate> {
	
	IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *m_activity; 
	iVagabroAppDelegate *appDelegate;
    NSMutableString *path;
    
}


@property (nonatomic, retain) iVagabroAppDelegate *appDelegate;
@property (nonatomic, retain) UIActivityIndicatorView *m_activity;
@property (nonatomic, retain) NSMutableString *path;
@end
