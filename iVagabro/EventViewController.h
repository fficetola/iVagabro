//
//  EventViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 12/11/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+Cached.h"
#import "UIImage+Scale.h"
#import "ImageViewController.h"
#import "MapViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface EventViewController : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate> {

    
    NSDictionary * eventSelected;  
    IBOutlet UILabel *primaryLabel;
    IBOutlet UITextView *secondaryLabel;
    IBOutlet UILabel *detail1Label;
    IBOutlet UITextView *detail2Label;
    IBOutlet UITextView *detail3Label;
    IBOutlet UILabel *detail4Label;
    IBOutlet UIButton *myImageView;
    
    ImageViewController *imageView;
    MapViewController *mapView;
    
    iVagabroAppDelegate *appDelegate;
    
    UIActivityIndicatorView *spinner;
    UIAlertView *progressAlert;
}

- (IBAction)showPicker:(id)sender;
- (IBAction)openMap:(id)sender;
- (IBAction)saveEventInCalendar:(id)sender;
- (IBAction)saveEventInCalendar:(id)sender;
    

@property(nonatomic,retain)IBOutlet UILabel *primaryLabel;
@property(nonatomic,retain)IBOutlet UITextView *secondaryLabel;
@property(nonatomic,retain)IBOutlet UILabel *detail1Label;
@property(nonatomic,retain)IBOutlet UITextView *detail2Label;
@property(nonatomic,retain)IBOutlet UITextView *detail3Label;
@property(nonatomic,retain)IBOutlet UILabel *detail4Label;
@property(nonatomic,retain)IBOutlet UIButton *myImageView;
@property(nonatomic,retain) NSDictionary *eventSelected;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet  UIAlertView *progressAlert;


@end
