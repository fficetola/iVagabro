//
//  SinglePostViewController.h
//  LuBannApp
//
//  Created by Fr@nk on 06/03/11.
//  Copyright 2011 Eustema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuBannAppAppDelegate.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface SingleNumeroViewController : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate> {
	
	IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *m_activity; 
	LuBannAppAppDelegate *appDelegate;
    NSMutableString *path;
    
}


-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@property (nonatomic, retain) LuBannAppAppDelegate *appDelegate;
@property (nonatomic, retain) UIActivityIndicatorView *m_activity;
@property (nonatomic, retain) NSMutableString *path;
@end
