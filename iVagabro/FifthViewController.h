//
//  FifthViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "iVagabroAppDelegate.h"
#import "MyBrowserViewController.h"


@interface FifthViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate>{
    
 	//IBOutlet UIWebView *webView;
    IBOutlet UITextField *nome;
    IBOutlet UITextField *email;
    IBOutlet UITextView *message;
    IBOutlet UIButton *labelBlink;
    
    iVagabroAppDelegate *appDelegate;
    MyBrowserViewController *myBrowserController;
    
}
-(IBAction)openWebBrowser:(id)sender;
-(IBAction)sendMail;
- (IBAction) dismissKeyboard:(id)sender;
-(IBAction) textFieldReturn:(id)sender;
-(IBAction)showPicker:(id)sender;

@property (nonatomic, retain) UITextField *nome;
@property (nonatomic, retain) UITextField *email;
@property (nonatomic, retain) UITextView *message;
@property (nonatomic, retain) UIButton *labelBlink;

@end
