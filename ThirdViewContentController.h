//
//  ThirdViewContentController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 25/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewContentController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate>{
    
    UIScrollView * scrollView;
    UIView       * contentView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *contentView;

@end
