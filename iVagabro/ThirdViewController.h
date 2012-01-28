//
//  ThirdViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iVagabroAppDelegate.h"
#import "EventViewController.h"

@interface ThirdViewController : UITableViewController{
	
    //array che conterrà gli elementi da visualizzare nella tabella
	NSArray *lista;
    
	//controller della vista che dovrà essere aperta
	EventViewController *eventView;
	
	iVagabroAppDelegate *appDelegate;
    
    NSMutableArray *listaOggetti;
    NSMutableArray *listaSezioni;
    
    UIActivityIndicatorView *spinner;
    UIAlertView *progressAlert;
    
}
@property (nonatomic, retain) NSArray *lista;
@property (nonatomic, retain) iVagabroAppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableArray *listaOggetti;
@property (nonatomic, retain) NSMutableArray *listaSezioni;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet  UIAlertView *progressAlert;

@end
