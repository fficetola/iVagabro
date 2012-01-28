//
//  FirstViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewContentController.h"
#import "SecondViewContentController.h"
#import "ThirdViewContentController.h"

@interface FirstViewController : UIViewController<UIScrollViewDelegate>{
    
    IBOutlet FirstViewContentController *firstViewContent;
    IBOutlet SecondViewContentController *secondViewContent;
    IBOutlet ThirdViewContentController *thirdViewContent;
    IBOutlet UIImageView *imageView;
    IBOutlet UIView *contentView;
}

- (IBAction)switchViews:(id)sender;

@property (nonatomic, retain) FirstViewContentController *firstViewContent;
@property (nonatomic, retain) SecondViewContentController *secondViewContent;
@property (nonatomic, retain) ThirdViewContentController *thirdViewContent;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIView *contentView;

@end
