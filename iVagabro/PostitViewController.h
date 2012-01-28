//
//  PostitViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 04/12/11.
//  Copyright (c) 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iVagabroAppDelegate.h"

@interface PostitViewController : UIViewController{
    
    IBOutlet UITextView *primaryLabel;
    IBOutlet UILabel *secondaryLabel;
    iVagabroAppDelegate *appDelegate;
}

@property (nonatomic, retain) UITextView *primaryLabel;
@property (nonatomic, retain) UILabel *secondaryLabel;

@end
