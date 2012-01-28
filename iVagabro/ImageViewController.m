//
//  SinglePostViewController.m
//  LuBannApp
//
//  Created by Fr@nk on 06/03/11.
//  Copyright 2011 Eustema. All rights reserved.
//

#import "SingleNumeroViewController.h"
#import "LuBannAppAppDelegate.h"

@implementation SingleNumeroViewController

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



-(IBAction)showPicker:(id)sender
{
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self launchMailAppOnDevice];
		}
	}
	else
	{
		[self launchMailAppOnDevice];
	}
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"LuBannApp - numero de LuBannaiuolu"];
	
    
	// Set up recipients
	//NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"]; 
    //NSArray *toRecipients = [NSArray arrayWithObject:nil]; 
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil]; 
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"]; 
	
	//[picker setToRecipients:toRecipients];
    //[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
    appDelegate = (LuBannAppAppDelegate *)[[UIApplication sharedApplication] delegate];

    NSURL *pdfURL = [NSURL URLWithString:appDelegate.path];
  
    NSData *myData = [NSData dataWithContentsOfURL:pdfURL];
	[picker addAttachmentData:myData mimeType:@"application/pdf" fileName:appDelegate.title];
	
	// Fill out the email body text
	NSString *emailBody = @"Ecco il numero de LuBannaiuolu scaricato dall'app mobile LuBannApp. La trovi sull'Apple Store!";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			//message.text = @"Result: canceled";
			break;
		case MFMailComposeResultSaved:
			//message.text = @"Result: saved";
			break;
		case MFMailComposeResultSent:
			//message.text = @"Result: sent";
			break;
		case MFMailComposeResultFailed:
			//message.text = @"Result: failed";
			break;
		default:
			//message.text = @"Result: not sent";
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void)viewDidLoad{

    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sendmail.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showPicker:)];          
    self.navigationItem.rightBarButtonItem = anotherButton;
    [anotherButton release];
    
    appDelegate = (LuBannAppAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    m_activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [m_activity setHidesWhenStopped:YES]; 

    [self.view addSubview:m_activity];
    m_activity.center = self.view.center;
    
	//indirizzo web da caricare
	NSString *indirizzo = appDelegate.path;	//indirizzo = [indirizzo stringByAppendingString:appDelegate.idPost];
	
	//crea un oggetto URL
	NSURL *url = [NSURL URLWithString:indirizzo];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    webView.scalesPageToFit = YES;
    webView.delegate = self;
	
    // visualizza la pagina nella UIWebView
	[webView loadRequest:requestObj];
    
    self.navigationItem.title = appDelegate.title;
    
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

}

- (void)dealloc {
    [webView release];
	[super dealloc];
}


@end
