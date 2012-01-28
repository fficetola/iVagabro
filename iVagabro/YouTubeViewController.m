//
//  WebViewController.m
//  WebViewTutorial
//
//  Created by iPhone SDK Articles on 8/19/08.
//  Copyright 2008 www.iPhoneSDKArticles.com. All rights reserved.
//

#import "YouTubeViewController.h"
#import "iVagabroAppDelegate.h"


@implementation YouTubeViewController

@synthesize webView, primaryLabel, secondaryLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"YouTubeView" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 Implement loadView if you want to create a view hierarchy programmatically
 - (void)loadView {
 }
 */



- (void) openWebBrowser{
    
    myBrowserView = [[MyBrowserViewController alloc] init];
    
    [self.navigationController pushViewController:myBrowserView animated:YES];
    
    //rilasciamo il controller
    [myBrowserView release];
    myBrowserView = nil;
}

/*
 If you need to do additional setup after loading the view, override viewDidLoad. */
- (void)viewDidLoad {

    // webView is a UIWebView, either initialized programmatically or loaded as part of a xib.
   
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dictionarySelection = appDelegate.dictionarySelection;
    

	NSMutableString *titleSelection = [[NSMutableString alloc] initWithString:[dictionarySelection objectForKey:@"title"]];
    
    NSMutableString *descriptionSelection = [[NSMutableString alloc] initWithString:[dictionarySelection objectForKey:@"description"]];
    
    NSMutableString *url = [[NSMutableString alloc] initWithString:[dictionarySelection objectForKey:@"urlVideo"]];
    
    self.title = @"Video";
    
    if([dictionarySelection objectForKey:@"urlSite"]!=nil){
    
        UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Sito" style:UIBarButtonItemStylePlain target:self action:@selector(openWebBrowser)];          
        self.navigationItem.rightBarButtonItem = anotherButton;
        [anotherButton release];
    }
    
    
    self.primaryLabel.text = titleSelection;
    self.secondaryLabel.text = descriptionSelection;
    
    [titleSelection release];
    [descriptionSelection release];
    
    
    NSString *htmlString = nil;
    
    if([self interfaceOrientation] == UIInterfaceOrientationPortrait){
       htmlString = @"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 200\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><iframe width=\"200\" height=\"200\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></div></body></html>";
        
    }
    else {
        htmlString = @"<html><head><meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 300\"/></head><body style=\"background:#F00;margin-top:0px;margin-left:0px\"><div><iframe width=\"300\" height=\"300\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe></div></body></html>";
        
    }
        
    
     htmlString = [NSString stringWithFormat:htmlString, url];
    
    webView.delegate = self;
    
    [webView loadHTMLString:htmlString baseURL:nil];
    
    [url release];
    
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


-(void) viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return YES;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[webView release];
    [primaryLabel release];
    [secondaryLabel release];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [activityIndicator stopAnimating];

	[super dealloc];
}


@end

