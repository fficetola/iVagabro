//
//  SecondViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "SecondViewController.h"
#import "PhotoController.h"
#import "Utils.h"
#import "TableCellViewController.h"
#import "UIImageView+Cached.h"


@implementation SecondViewController

@synthesize lista;
@synthesize listaOggetti;
@synthesize appDelegate;

@synthesize spinner;
@synthesize progressAlert;




- (void) caricaLista{
    self.navigationItem.title = @"Opere";
    
    //carico le categorie
    NSString *indirizzo = @"http://www.lubannaiuolu.net/ivagabro/getMyJobs.plist";
    
    listaOggetti = [[NSMutableArray alloc] initWithArray:[Utils downloadPlist:indirizzo]];

    
        
    /* reload the table */
    //[self.tableView reloadData];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [spinner stopAnimating];
    [progressAlert dismissWithClickedButtonIndex:0 animated:TRUE];
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
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [NSThread sleepForTimeInterval:2];
    [self performSelectorOnMainThread:@selector(caricaLista) withObject:nil waitUntilDone:NO];
    [pool drain];
       
    
}

-(void) awakeFromNib{
        
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"update_20.png"] style:UIBarButtonItemStylePlain target:self action:@selector(loadData)];          
    self.navigationItem.rightBarButtonItem = anotherButton;
    [anotherButton release];
    
}



- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    //chiamo solo una volta il metodo
    if(listaOggetti==nil || [listaOggetti count]==0)[self loadData];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
         return NO;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%d",[listaOggetti count]);
    return [listaOggetti count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2)
    {
        [cell setBackgroundColor:[UIColor colorWithRed:0.80 green:.85 blue:0.86 alpha:1]];
    }
    else [cell setBackgroundColor:[UIColor colorWithRed:.88 green:.88 blue:.88 alpha:1]];   
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TableCellView";
    
     /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
     }
      */
    TableCellViewController *cell = (TableCellViewController *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TableCellView" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (TableCellViewController *) currentObject;
				break;
			}
		}
	}

	NSDictionary *cellData = [listaOggetti objectAtIndex:indexPath.row];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.primaryLabel.text = [cellData objectForKey:@"name"];
    cell.secondaryLabel.text = @"2 Hours";
    
    NSURL *url = [NSURL URLWithString:[cellData objectForKey:@"image"]];
    cell.myImageView.layer.masksToBounds = YES;
    cell.myImageView.layer.cornerRadius = 5.0;
    cell.myImageView.layer.borderWidth = 1.0f;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat values[4] = {0, 0, 0, 1.0}; 
    CGColorRef grey = CGColorCreate(space, values); 
    cell.myImageView.layer.borderColor = grey;
    CGColorRelease(grey);
    CGColorSpaceRelease(space);

    [cell.myImageView loadFromURL:url];
    float sw=1;
    float sh=1;
    cell.myImageView.transform=CGAffineTransformMakeScale(sw,sh);


    
	return cell;
}



/* setta l'altezza della cella*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91.0;
}




#pragma mark -
#pragma mark Table view delegate


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

-(void) loadAlbum{
    
    //thread secondario
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init]; 
    
    viewPhotos = [[PhotoController alloc] init];
	//viewPhotos.idSection = idSection;
	//viewPhotos.nameSelection = nameSelection;
	
	//Facciamo visualizzare la vista con i dettagli
	[self.navigationController pushViewController:viewPhotos animated:YES];
	
	//rilasciamo il controller
	[viewPhotos release];
    viewPhotos = nil;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [spinner stopAnimating];
    [progressAlert dismissWithClickedButtonIndex:0 animated:TRUE];
    
    [pool release];

    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
	NSDictionary *cellData = [listaOggetti objectAtIndex:indexPath.row];
	
	NSMutableString *idSelection = [[NSMutableString alloc] initWithString:[cellData objectForKey:@"id"]];
	NSMutableString *nameSelection = [[NSMutableString alloc] initWithString:[cellData objectForKey:@"name"]];
    
    
    
	appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.idSelection = idSelection;
    appDelegate.nameSelection = nameSelection;

	
    //primo thread (quello principale)
    [self performSelectorOnMainThread:@selector(waitForData) withObject:nil waitUntilDone:NO];
    
    //secondo thread
    [self performSelector:@selector(loadAlbum) withObject:nil afterDelay:0.25];

	
	/*UIAlertView *popUp = [[UIAlertView alloc] initWithTitle:@"Hai selezionato:" message:[cellData objectForKey:@"id"] delegate:self cancelButtonTitle:@"OK"
	 otherButtonTitles:nil];
	 [popUp show];
	 [popUp release];*/
	 
	
	[idSelection release];
	[nameSelection release];
    //[dictionary release];
    //[cellData release];
}





- (void)dealloc {
	[lista release];
    [listaOggetti dealloc];
    [spinner dealloc];
    [progressAlert dealloc];
    //[viewPhotos release];
    [super dealloc];
    
}


@end
