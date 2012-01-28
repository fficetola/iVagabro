//
//  FifthViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "FifthViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Utils.h"
#import "iVagabroAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MyBrowserViewController.h"

@implementation FifthViewController

@synthesize nome, email, message, labelBlink;


int loopCount;

	
/** BLINK text **/
- (void) hideLabel:(NSTimer*)theTimer {
	labelBlink.hidden = !labelBlink.hidden;
}

-(void) blinkText {
    
    //here is a similar example but with using an NSNumber
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(hideLabel  :) userInfo:nil repeats:YES];
     
}  



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

-(void) viewDidAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Contatti";
    [self blinkText];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//chiude la finestra della tastiera se clicco in un'area vuota
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [self.email resignFirstResponder];
        [self.message resignFirstResponder];
        [self.nome resignFirstResponder];
    }
    //See if touch was inside the label
    /* if (CGRectContainsPoint(UrlLabel.frame, [[[event allTouches] anyObject] locationInView:mainView]))
     {
     //Open webpage
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.google.com"]];
     }*/
}


- (IBAction) dismissKeyboard:(id)sender
{
	[nome resignFirstResponder];
	[email resignFirstResponder];
	[message resignFirstResponder];
}

- (IBAction) textFieldReturn:(id)sender
{
	[sender resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}



-(IBAction)sendMail{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:@"http://www.lubannaiuolu.net/ivagabro/sendMail.php"];
    
    if([Utils IsEmpty:email.text]==false && [Utils NSStringIsValidEmail:email.text]==true && [Utils IsEmpty:message.text]==false && [Utils IsEmpty:nome.text]==false ){
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:message.text forKey:@"message"];
        [request setPostValue:email.text forKey:@"from"];
        [request setPostValue:nome.text forKey:@"nome"];
        
        [request setDelegate:self];
        [request startAsynchronous];
        
        [email resignFirstResponder];
        [nome resignFirstResponder];
        [message resignFirstResponder];
        
        
        
    } else {
        //mando un messaggio all'utente
        NSString *messaggio = @"";
        
        if([Utils IsEmpty:nome.text]==true){
            messaggio = [messaggio stringByAppendingString:@"Inserire il nome!\n"];
             nome.text = @"";
        }
        if( [Utils IsEmpty:message.text]==true){
            messaggio = [messaggio stringByAppendingString: @"Inserire un messaggio!\n"];
             message.text = @"";
        }
        
        if([Utils IsEmpty:email.text]==true || [Utils NSStringIsValidEmail:email.text]==false){
            messaggio = [messaggio stringByAppendingString: @"Inserire una email valida!\n"];
             email.text = @"";
        }
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Errore nei dati" message:messaggio delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
       
    }
    
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //mando un messaggio all'utente
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Messaggio inviato con successo" message: @"Verrai contattato all'indirizzo email specificato!" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [alertView show];
    [alertView release];
    
    [email resignFirstResponder];
    email.text = @"";
    
    
}


- (void)requestFailed:(ASIHTTPRequest *)request

{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSError *error = [request error];
    if (error != nil) { 
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Errore di rete" message: @"Connettività ad Internet limitata o assente!" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];  
        
    }  
    [email resignFirstResponder];
    email.text = @"";
    
}





#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from California!";
	NSString *body = @"&body=It is raining in sunny California!";
	
	NSString *emailText = [NSString stringWithFormat:@"%@%@", recipients, body];
	emailText = [emailText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailText]];
}


// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    
	NSString *subject = @"Info per la mia app mobile";
    
	[picker setSubject:subject];
	
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"webmaster@lubannaiuolu.net"]; 
    //NSArray *toRecipients = [NSArray arrayWithObject:nil]; 
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil]; 
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"]; 
	
	[picker setToRecipients:toRecipients];
    //[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email
      
    
	// Fill out the email body text
	NSString *emailBody = @"Messaggio inviato da <b>iVagabro</b>:<br/><br/>";
    
    emailBody = [emailBody stringByAppendingString:@"Salve,<br/>vorrei informazioni e maggiori dettagli per realizzare una mia app mobile su iPhone/iPad. <br/><br/> Distinti saluti."];
    
	[picker setMessageBody:emailBody isHTML:YES];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


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



- (IBAction)openWebBrowser:(id)sender{
    
    myBrowserController = [[MyBrowserViewController alloc] init];
    
    
    NSDictionary * dictionarySelection = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"http://www.vagabro.it", @"urlSite",
                            @"vagabro.it", @"title", nil];
    
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.dictionarySelection = dictionarySelection;
    [self.navigationController pushViewController:myBrowserController animated:YES];
    
    //rilasciamo il controller
    [myBrowserController release];
     myBrowserController = nil;
    
    [dictionarySelection release];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.view;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
