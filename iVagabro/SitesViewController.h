//
//  FourthViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouTubeViewController.h"
#import "MyBrowserViewController.h"
#import "iVagabroAppDelegate.h"


@interface SitesViewController : UITableViewController{


	//controller della vista che dovrà essere aperta
	YouTubeViewController *youTubeView;	
    MyBrowserViewController *myBrowserView;	
	iVagabroAppDelegate *appDelegate;
    
    NSMutableArray *listaOggetti;
    
    UIActivityIndicatorView *spinner;
    UIAlertView *progressAlert;
    
}
@property (nonatomic, retain) iVagabroAppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableArray *listaOggetti;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet  UIAlertView *progressAlert;

@end
