//
//  EventViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 12/11/11.
//  Copyright 2012 lubannaiuolu. All rights reserved.
//

#import "EventViewController.h"
#import "iVagabroAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "UIImageView+Cached.h"
#import "UIImage+Scale.h"
#import "Utils.h"

@implementation EventViewController

@synthesize eventSelected,primaryLabel,secondaryLabel, detail1Label, detail2Label, detail3Label, detail4Label, myImageView, spinner, progressAlert;


- (void)applyStyleUIView {
    
    [UIView beginAnimations:nil context:NULL]; [UIView setAnimationDuration: 1.0]; [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO]; //your code [UIView commitAnimations];
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

-(void) stopLoadingWhenComplete{
    
}

-(void) caricaDati{
   
    //thread secondario
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init]; 
    
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *titolo =  [[[NSString alloc] initWithString:[appDelegate.dictionarySelection objectForKey:@"titolo"]]autorelease];
    self.primaryLabel.text = titolo;
    
    NSString *descrizione =  [[[NSString alloc] initWithString:[appDelegate.dictionarySelection objectForKey:@"descrizione"]]autorelease];
    self.secondaryLabel.text = descrizione;
    
    NSString *quando =  [appDelegate.dictionarySelection objectForKey:@"quando"];
    self.detail1Label.text = quando;
    
    //NSString *locale =  [appDelegate.dictionarySelection objectForKey:@"locale"];
    NSString *dove =  [[[NSString alloc] initWithString:[appDelegate.dictionarySelection objectForKey:@"dove"]]autorelease];
    //dove = [dove stringByAppendingString:locale];
    self.detail2Label.text = dove;
    
    NSString *info =  [[[NSString alloc] initWithString:[appDelegate.dictionarySelection objectForKey:@"info"]]autorelease];
    self.detail3Label.text = info;
    
    NSString *sitoweb =  [[[NSString alloc] initWithString:[appDelegate.dictionarySelection objectForKey:@"sitoweb"]]autorelease];
    self.detail4Label.text = sitoweb;
    
    NSURL *url = [NSURL URLWithString:[appDelegate.dictionarySelection objectForKey:@"icon"]];
    
    if(url!=nil && ![Utils IsEmpty:[appDelegate.dictionarySelection objectForKey:@"icon"] ]){
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage* image = [[UIImage alloc] initWithData:data];
        [self.myImageView setImage:image forState:UIControlStateNormal];
        CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
        CGFloat values[4] = {0, 0, 0, 1.0}; 
        CGColorRef grey = CGColorCreate(space, values); 
        self.myImageView.layer.borderColor = grey;
        CGColorRelease(grey);
        CGColorSpaceRelease(space);
        
        float sw=1;
        float sh=1;
        self.myImageView.transform=CGAffineTransformMakeScale(sw,sh);
        [image release];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [spinner stopAnimating];
    [progressAlert dismissWithClickedButtonIndex:0 animated:TRUE];
   
    [pool release];

}




- (void) loadData {
    
    
    //[Utils testConnectionThread];
    
    progressAlert = [[UIAlertView alloc] initWithTitle:@"Caricamento dati"
                                               message:@"Attendere prego..."
                                              delegate: self
                                     cancelButtonTitle: nil
                                     otherButtonTitles: nil];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
    [progressAlert addSubview:spinner];
    [spinner startAnimating];
    
    [progressAlert show];
    [progressAlert release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
    
    /* Operation Queue init (autorelease) */
    
   /* NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                        initWithTarget:self
                                        selector:@selector(caricaDati) 
                                        object:nil];
    [queue addOperation:operation]; 
    [operation release];   */ 
    
}


- (void)viewDidLoad
{   
    [super viewDidLoad];
    
    //primo thread (quello principale)
    [self performSelectorOnMainThread:@selector(loadData) withObject:nil waitUntilDone:NO];
    
    //secondo thread
    [self performSelector:@selector(caricaDati) withObject:nil afterDelay:0.25];
   
}




-(IBAction)openImage:(id)sender{
   
    if(![Utils IsEmpty:[appDelegate.dictionarySelection objectForKey:@"icon"]]){
    
        imageView = [[ImageViewController alloc] initWithNibName:@"ImageView" bundle:[NSBundle mainBundle]];
	
        appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    
        NSMutableString *urlSelection = [appDelegate.dictionarySelection objectForKey:@"icon"];
        appDelegate.urlSelection = urlSelection;
    
        NSMutableString *nameSelection = [appDelegate.dictionarySelection objectForKey:@"titolo"];
        appDelegate.nameSelection = nameSelection;
    
        //Facciamo visualizzare la vista con i dettagli
        [self.navigationController pushViewController:imageView animated:YES];
	
        //rilasciamo il controller
        [imageView release];
        imageView = nil;
    
        //[urlSelection release];
        //[nameSelection release];
    }
        
}


-(IBAction)openMap:(id)sender{
    
    mapView = [[MapViewController alloc] initWithNibName:@"MapView" bundle:[NSBundle mainBundle]];
	
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];

    
/*    NSMutableString *urlSelection = [appDelegate.dictionarySelection objectForKey:@"icon"];
    appDelegate.urlSelection = urlSelection;
    
    NSMutableString *nameSelection = [appDelegate.dictionarySelection objectForKey:@"titolo"];
    appDelegate.nameSelection = nameSelection;
*/
    
	//Facciamo visualizzare la vista con i dettagli
	[self.navigationController pushViewController:mapView animated:YES];
	
	//rilasciamo il controller
    [mapView release];
    mapView = nil;
    
    //[urlSelection release];
    //[nameSelection release];
    
}


-(void) viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}


//metodo che scatta dopo la conferma per il salvataggio dell'evento nel calendario
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
    
        EKEventStore *eventStore = [[EKEventStore alloc] init];
    
        EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
        NSString *titolo = @"Gabriele Tamburini-";
        titolo = [titolo stringByAppendingString:[appDelegate.dictionarySelection objectForKey:@"titolo"]];
        NSString *dove = [appDelegate.dictionarySelection objectForKey:@"locale"];
        dove = [dove stringByAppendingString:@"-"]; 
        dove = [dove stringByAppendingString:[appDelegate.dictionarySelection objectForKey:@"dove"]];

        event.title     = titolo;
        [event setLocation:dove];

    
        //converto la stringa in data
        NSString *quando = [appDelegate.dictionarySelection objectForKey:@"promemoria"];
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"d MMM yyyy HH:mm"];
    
        // set locale to something English
        /*NSLocale *enLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en"] autorelease];
        [dateFormat1 setLocale:enLocale];
        */
        NSDate *date1 = [dateFormat1 dateFromString:quando];
    
        event.startDate = date1;
        
        NSDate *date2 = [[NSDate alloc] initWithTimeInterval:600 sinceDate:event.startDate];
        event.endDate   = date2;
        
        [event setAllDay:TRUE];
        
        //ripetizione
        /*EKRecurrenceRule *rule = [[EKRecurrenceRule alloc] 
                                  initRecurrenceWithFrequency:EKRecurrenceFrequencyDaily 
                                  interval:1
                                  end:[EKRecurrenceEnd recurrenceEndWithEndDate:date]];
        [event setRecurrenceRule:rule];
         */
        
        
        [date2 release];
        [dateFormat1 release];
        
        NSMutableArray *myAlarmsArray = [[NSMutableArray alloc] init];
        
        EKAlarm *alarm1 = [EKAlarm alarmWithRelativeOffset:-3600]; // 1 Hour
        EKAlarm *alarm2 = [EKAlarm alarmWithRelativeOffset:-86400]; // 1 Day
        
        [myAlarmsArray addObject:alarm1];
        [myAlarmsArray addObject:alarm2];
        
        event.alarms = myAlarmsArray;
        
        
    
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err]; 
        [myAlarmsArray release];
        [eventStore release];
    }
    
    else{
    
        
    }
    
}



//funzione che salva un evento nel calendario
- (IBAction)saveEventInCalendar:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Vuoi inserire tale evento in promemoria?"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"No"
                          otherButtonTitles:@"Si", nil];
    [alert show];
    [alert release];
    
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

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
    NSString *title = [appDelegate.dictionarySelection objectForKey:@"titolo"];
	NSString *subject = @"Gabriele Tamburini - ";
    subject = [subject stringByAppendingString:title];
    
	[picker setSubject:subject];
	
    
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
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(![Utils IsEmpty:[appDelegate.dictionarySelection objectForKey:@"icon"]]){
    
        NSURL *imageURL = [NSURL URLWithString:[appDelegate.dictionarySelection objectForKey:@"icon"]];
   
    
        NSData *myData = [NSData dataWithContentsOfURL:imageURL];
	[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:title];
	
    }
	// Fill out the email body text
	NSString *emailBody = @"Sei stato invitato all'evento di <b>Gabriele Tamburini</b>:<br/><br/>";
     emailBody =  [emailBody stringByAppendingString:@"<b>"];
    emailBody = [emailBody stringByAppendingString:title];
    emailBody =  [emailBody stringByAppendingString:@"</b><br/>"];
    emailBody =  [emailBody stringByAppendingString:[appDelegate.dictionarySelection objectForKey:@"descrizione"]];
    emailBody =  [emailBody stringByAppendingString:@"<br/><u>"];
    emailBody =  [emailBody stringByAppendingString:[appDelegate.dictionarySelection objectForKey:@"quando"]];
    emailBody =  [emailBody stringByAppendingString:@"</u><br/>"];
    emailBody =  [emailBody stringByAppendingString:[appDelegate.dictionarySelection objectForKey:@"locale"]];
    emailBody =  [emailBody stringByAppendingString:@"<br/>"];
    emailBody =  [emailBody stringByAppendingString:[appDelegate.dictionarySelection objectForKey:@"dove"]];
    emailBody =  [emailBody stringByAppendingString:@"<br/>"];
    emailBody =  [emailBody stringByAppendingString:@"<a href=\"www.vagabro.it\">www.vagabro.it</a>"];
    emailBody =  [emailBody stringByAppendingString:@"<br/><br/>"];
    emailBody =  [emailBody stringByAppendingString:@"Scarica anche tu l'app <b>iVagabro</b> dall'Apple Store!"];
    emailBody =  [emailBody stringByAppendingString:@"<br/>"];
    
	[picker setMessageBody:emailBody isHTML:YES];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


- (void) waitForData {
    
    
    //[Utils testConnectionThread];
    
    progressAlert = [[UIAlertView alloc] initWithTitle:@"Caricamento dati"
                                               message:@"Attendere prego..."
                                              delegate: self
                                     cancelButtonTitle: nil
                                     otherButtonTitles: nil];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
    [progressAlert addSubview:spinner];
    [spinner startAnimating];
    
    [progressAlert show];
    [progressAlert release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
    
    /* Operation Queue init (autorelease) */
    
    /* NSOperationQueue *queue = [NSOperationQueue new];
     NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
     initWithTarget:self
     selector:@selector(caricaDati) 
     object:nil];
     [queue addOperation:operation]; 
     [operation release];   */ 
    
}

-(void) condividi{
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init]; 
    
    
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
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [spinner stopAnimating];
    [progressAlert dismissWithClickedButtonIndex:0 animated:TRUE];
    [pool release];
    
}

-(IBAction)showPicker:(id)sender
{
	// This sample can run on devices running iPhone OS 2.0 or later  
	// The MFMailComposeViewController class is only available in iPhone OS 3.0 or later. 
	// So, we must verify the existence of the above class and provide a workaround for devices running 
	// earlier versions of the iPhone OS. 
	// We display an email composition interface if MFMailComposeViewController exists and the device can send emails.
	// We launch the Mail application on the device, otherwise.
    
    //primo thread (quello principale)
    [self performSelectorOnMainThread:@selector(waitForData) withObject:nil waitUntilDone:NO];
    
    //secondo thread
    [self performSelector:@selector(condividi) withObject:nil afterDelay:0.25];

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




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    //[eventSelected release];
    [super dealloc];
}

@end
