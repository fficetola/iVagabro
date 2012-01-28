//
//  PostitViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 04/12/11.
//  Copyright (c) 2011 lubannaiuolu. All rights reserved.
//

#import "PostitViewController.h"
#import "iVagabroAppDelegate.h"

@implementation PostitViewController

@synthesize primaryLabel, secondaryLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dictionarySelection = appDelegate.dictionarySelection;
    
    
	NSMutableString *label1 = [[NSMutableString alloc] initWithString:[dictionarySelection objectForKey:@"label1"]];
    NSMutableString *label2 = [[NSMutableString alloc] initWithString:[dictionarySelection objectForKey:@"label2"]];

    self.title = @"Post-it";
    self.primaryLabel.text = label1;
    self.secondaryLabel.text = label2;
    
    [label1 release];
    [label2 release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
   // [primaryLabel release];
   // [secondaryLabel release];
	[super dealloc];
}

@end
