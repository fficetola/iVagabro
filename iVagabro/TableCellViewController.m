//
//  TableCellViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 26/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "TableCellViewController.h"

@implementation TableCellViewController
@synthesize primaryLabel,secondaryLabel, myImageView;
//@synthesize imageCell;


/*- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



- (void)dealloc {
	//[primaryLabel dealloc];
	//[secondaryLabel dealloc];
	//[lastUpdateText dealloc];
    [super dealloc];
}

@end

