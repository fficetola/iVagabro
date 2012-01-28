//
//  MyBrowserViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 13/12/11.
//  Copyright (c) 2011 lubannaiuolu. All rights reserved.
//

#import "MyBrowserViewController.h"

@implementation MyBrowserViewController

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
     
   
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dictionarySelection = appDelegate.dictionarySelection;
    
    NSMutableString *title =  [[NSMutableString alloc] initWithString:[dictionarySelection objectForKey:@"title"]];
    
    self.title = title;
    
	NSMutableString *indirizzo = [[NSMutableString alloc] initWithString:[dictionarySelection objectForKey:@"urlSite"]];

    
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    
    //crea un oggetto URL
    NSURL *url = [NSURL URLWithString:indirizzo];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    // visualizza la pagina nella UIWebView
    [webView loadRequest:requestObj];
        
    [indirizzo release];
    [title release];
    
}



-(void)webViewDidStartLoad:(UIWebView *)webView {
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activityIndicator stopAnimating];
	
}

- (void)myWebView:(UIWebView *)myWebView didFailLoadWithError:(NSError *)error
{
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>Si &egrave; verificato un errore:<br>%@</font></center></html>",
							 error.localizedDescription];
	[webView loadHTMLString:errorString baseURL:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activityIndicator stopAnimating];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) dealloc{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activityIndicator stopAnimating];
    
    [webView release];
    [super dealloc];
    
}

@end
