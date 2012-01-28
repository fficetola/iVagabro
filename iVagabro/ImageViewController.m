//
//  SinglePostViewController.m
//  LuBannApp
//
//  Created by Fr@nk on 06/03/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "ImageViewController.h"
#import "iVagabroAppDelegate.h"

@implementation ImageViewController

@synthesize appDelegate;
@synthesize m_activity;
@synthesize path;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


- (void)viewDidLoad{

   /* UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sendmail.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showPicker:)];          
    self.navigationItem.rightBarButtonItem = anotherButton;
    [anotherButton release];
    */
    
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    m_activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [m_activity setHidesWhenStopped:YES]; 

    [self.view addSubview:m_activity];
    m_activity.center = self.view.center;
    
    
	//indirizzo web da caricare
	NSString *indirizzo = appDelegate.urlSelection;	//indirizzo = [indirizzo stringByAppendingString:appDelegate.idPost];
    NSString *title = appDelegate.nameSelection;	//indirizzo = [indirizzo 
	
    
	//crea un oggetto URL
	NSURL *url = [NSURL URLWithString:indirizzo];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    webView.scalesPageToFit = YES;
    webView.delegate = self;
	
    // visualizza la pagina nella UIWebView
	[webView loadRequest:requestObj];
    
    self.navigationItem.title = title;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return YES;
}




- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if(fromInterfaceOrientation == UIInterfaceOrientationPortrait){
        [webView stringByEvaluatingJavaScriptFromString:@"rotate(0)"];
        
    }
    
    else {
        
        [webView stringByEvaluatingJavaScriptFromString:@"rotate(1)"];
    }
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [m_activity startAnimating];
	// starting the load, show the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [m_activity stopAnimating];
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)myWebView:(UIWebView *)myWebView didFailLoadWithError:(NSError *)error
{
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>", @"Il numero selezionato non esiste!"];
							 //error.localizedDescription];
	[webView loadHTMLString:errorString baseURL:nil];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;

}

- (void)dealloc {
    [webView release];
	[super dealloc];
}


@end
