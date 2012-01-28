//
//  TableCellViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 26/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellViewController :  UITableViewCell {
    IBOutlet UILabel *primaryLabel;
    IBOutlet UILabel *secondaryLabel;
    IBOutlet UIImageView *myImageView;
}
@property(nonatomic,retain)IBOutlet UILabel *primaryLabel;
@property(nonatomic,retain)IBOutlet UILabel *secondaryLabel;
@property(nonatomic,retain)IBOutlet UIImageView *myImageView;

@end
