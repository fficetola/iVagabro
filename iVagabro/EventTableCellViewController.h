//
//  TableCellViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 26/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableCellViewController :  UITableViewCell {
    IBOutlet UILabel *primaryLabel;
    IBOutlet UILabel *secondaryLabel;
    IBOutlet UILabel *detail1Label;
    IBOutlet UILabel *detail2Label;
    IBOutlet UIImageView *myImageView;
}
@property(nonatomic,retain)IBOutlet UILabel *primaryLabel;
@property(nonatomic,retain)IBOutlet UILabel *secondaryLabel;
@property(nonatomic,retain)IBOutlet UILabel *detail1Label;
@property(nonatomic,retain)IBOutlet UILabel *detail2Label;


@property(nonatomic,retain)IBOutlet UIImageView *myImageView;

@end
