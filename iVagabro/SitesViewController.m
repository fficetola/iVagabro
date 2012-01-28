//
//  FourthViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "SitesViewController.h"
#import "PhotoController.h"
#import "Utils.h"
#import "BonusTableCellViewController.h"
#import "UIImageView+Cached.h"

@implementation SitesViewController
@synthesize appDelegate,listaOggetti,spinner,progressAlert;


- (void) caricaLista{
    self.navigationItem.title = @"Bonus Link";
    
    //carico le categorie
    NSString *indirizzo = @"http://www.lubannaiuolu.net/ivagabro/getSites%@.plist";
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *cellData = appDelegate.dictionarySelection;
	NSMutableString *idSelection = [[NSMutableString alloc] initWithString:[cellData objectForKey:@"id"]];

    indirizzo = [NSString stringWithFormat:indirizzo, idSelection];
    
    
    
    listaOggetti = [[NSMutableArray alloc] initWithContentsOfURL:[NSURL URLWithString:(NSString*)indirizzo]];
    
    NSLog(@"%@", listaOggetti);
    
    
    
    /* reload the table */
    //[self.tableView reloadData];
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [spinner stopAnimating];
    [progressAlert dismissWithClickedButtonIndex:0 animated:TRUE];
    
    [idSelection release];
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
    // Return YES for supported orientations
    return YES;
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
    
    static NSString *CellIdentifier = @"BonusTableCellView";
    
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
     }
     */
    BonusTableCellViewController *cell = (BonusTableCellViewController *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"BonusTableCellView" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (BonusTableCellViewController *) currentObject;
				break;
			}
		}
	}
    
	NSDictionary *cellData = [listaOggetti objectAtIndex:indexPath.row];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.primaryLabel.text = [cellData objectForKey:@"title"];
    cell.secondaryLabel.text = [cellData objectForKey:@"description"];
    
   // NSURL *url = [NSURL URLWithString:[cellData objectForKey:@"image"]];
    cell.myImageView.layer.masksToBounds = YES;
    cell.myImageView.layer.cornerRadius = 5.0;
    cell.myImageView.layer.borderWidth = 4.0f;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat values[4] = {0, 0, 0, 1.0}; 
    CGColorRef grey = CGColorCreate(space, values); 
    cell.myImageView.layer.borderColor = grey;
    CGColorRelease(grey);
    CGColorSpaceRelease(space);
    
    
    //se apro un video
    if ([[cellData objectForKey:@"type"]isEqualToString:@"video"]) {
        cell.myImageView.image = [UIImage imageNamed:@"video.png"];
    }
    else {
        
        cell.myImageView.image = [UIImage imageNamed:@"agenda.png"];

    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    
	NSDictionary *cellData = [listaOggetti objectAtIndex:indexPath.row];
    
	//NSMutableString *idSelection = [[NSMutableString alloc] initWithString:[cellData objectForKey:@"id"]];
	NSMutableString *titleSelection = [[NSMutableString alloc] initWithString:[cellData objectForKey:@"title"]];
    
    //appDelegate.idSelection = idSelection;
    appDelegate.nameSelection = titleSelection;


	
    //se apro un video
    if ([[cellData objectForKey:@"type"]isEqualToString:@"video"]) {
        
        appDelegate.dictionarySelection = cellData;
        
        youTubeView = [[YouTubeViewController alloc] init];
        
        
        [self.navigationController pushViewController:youTubeView animated:YES];
        
        //rilasciamo il controller
        [youTubeView release];
        youTubeView = nil;
        

    }
    else if([[cellData objectForKey:@"type"]isEqualToString:@"site"]){
        
        appDelegate.dictionarySelection = cellData;
        
        myBrowserView = [[MyBrowserViewController alloc] init];
        
        
        [self.navigationController pushViewController:myBrowserView animated:YES];
        
        //rilasciamo il controller
        [myBrowserView release];
        myBrowserView = nil;
    }
    
    [titleSelection release];
	//[idSelection release];
	
	//viewPhotos.idSection = idSection;
	
	
	//Facciamo visualizzare la vista con i dettagli
	    
	/*UIAlertView *popUp = [[UIAlertView alloc] initWithTitle:@"Hai selezionato:" message:[cellData objectForKey:@"id"] delegate:self cancelButtonTitle:@"OK"
	 otherButtonTitles:nil];
	 [popUp show];
	 [popUp release];*/
    
	
	
    //[dictionary release];
    //[cellData release];
}

-(void) dealloc{
    
    [listaOggetti dealloc];
    //[spinner dealloc];
    //[progressAlert dealloc];
    //[viewPhotos release];
    [super dealloc];
}

@end
