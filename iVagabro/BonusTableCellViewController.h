//
//  TableCellViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 26/10/11.
//  Copyright 2012 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BonusTableCellViewController :  UITableViewCell {
    IBOutlet UILabel *primaryLabel;
    IBOutlet UITextView *secondaryLabel;
    IBOutlet UIImageView *myImageView;
}
@property(nonatomic,retain)IBOutlet UILabel *primaryLabel;
@property(nonatomic,retain)IBOutlet UITextView *secondaryLabel;
@property(nonatomic,retain)IBOutlet UIImageView *myImageView;


@end
