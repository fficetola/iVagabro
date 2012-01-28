//
//  ThirdViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "ThirdViewController.h"
#import "PhotoController.h"
#import "Utils.h"
#import "EventTableCellViewController.h"
#import "UIImageView+Cached.h"

@implementation ThirdViewController

@synthesize  lista, listaOggetti, listaSezioni, appDelegate, spinner, progressAlert;


- (void) caricaLista{
    self.navigationItem.title = @"Eventi ed Esposizioni";
    
    
    //carico le categorie
    NSString *indirizzoSezioni = @"http://www.lubannaiuolu.net/ivagabro/getEventSections.plist";
    
    listaSezioni = [[NSMutableArray alloc] initWithArray:[Utils downloadPlist:indirizzoSezioni]];
     
    listaOggetti = [[NSMutableArray alloc] init];
    
    
    //scorro la lista delle categorie e recupero le board per ciascuna di esse
    for (int i=0; i<[listaSezioni count]; i++){
        
        NSDictionary *dictionaryCategoryTemp = [listaSezioni objectAtIndex:i];
        NSString *idSection = [dictionaryCategoryTemp objectForKey:@"id"];
        
        
        //recupero la lista delle board per la categoria corrente
        //NSString *plisStructure = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
        NSString *indirizzoSection = @"http://www.lubannaiuolu.net/ivagabro/getEvents";
        indirizzoSection = [indirizzoSection stringByAppendingString:idSection];
        indirizzoSection = [indirizzoSection stringByAppendingString:@".plist"];
        //crea un oggetto URL
        //NSURL *urlBoard = [NSURL URLWithString:indirizzoBoard];
        
        lista = [[NSMutableArray alloc]initWithArray:[Utils downloadPlist:indirizzoSection]];
        
        //lista = [[NSMutableArray alloc]initWithContentsOfFile:plisStructure];
        NSDictionary *dictBoard = [NSDictionary dictionaryWithObject:lista forKey:@"Elementi"];
        
        [listaOggetti addObject:dictBoard];
         
        
        //[dictBoard release];
        
        
    }  
    
        
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
    
    UITableView *tableViewTemp = [[UITableView alloc] initWithFrame:self.tableView.frame 
                                  style:UITableViewStyleGrouped];
    self.tableView =  tableViewTemp;
    [tableViewTemp release];
   
    
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

#pragma mark -
#pragma mark Table view data source
//setta il numero di sezioni della tabella
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
    
    /*          [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
     [self performSelectorOnMainThread:@selector(caricaListaGallery) withObject:nil waitUntilDone:TRUE];    
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
     */              
    
    return [listaOggetti count];
    
    
    
    //return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    NSDictionary *dictionary = [listaOggetti objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Elementi"];
    //[dictionary release];
    
	return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
    
    NSDictionary *dictionarySections = [listaSezioni objectAtIndex:section];
	NSString *titleSections = [dictionarySections objectForKey:@"titolo"];
    
    
    return titleSections;
}

- (NSInteger)realRowNumberForIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
    
	NSInteger retInt = 0;
	if (!indexPath.section){
		return indexPath.row;
	}
	for (int i=0; i<indexPath.section;i++){
		retInt += [tableView numberOfRowsInSection:i];
	}
    
    
	return retInt + indexPath.row;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    NSInteger realRow = [self realRowNumberForIndexPath:indexPath inTableView:tableView];
	cell.backgroundColor = (realRow%2)?[UIColor colorWithRed:0.80 green:.85 blue:0.86 alpha:1]:[UIColor colorWithRed:.88 green:.88 blue:.88 alpha:1];
    
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TableCellView";
    
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
     }
     */
    EventTableCellViewController *cell = (EventTableCellViewController *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventTableCellView" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (EventTableCellViewController *) currentObject;
				break;
			}
		}
	}
    
    NSDictionary *dictionary = [listaOggetti objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"Elementi"];
	NSDictionary *cellData = [array objectAtIndex:indexPath.row];
 
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.primaryLabel.text = [cellData objectForKey:@"titolo"];
    cell.secondaryLabel.text = [cellData objectForKey:@"descrizione"];
    
    cell.detail1Label.text = [cellData objectForKey:@"quando"];
    cell.detail2Label.text = [cellData objectForKey:@"dove"];
    
    
    NSURL *url = [NSURL URLWithString:[cellData objectForKey:@"iconSmall"]];
    cell.myImageView.layer.masksToBounds = YES;
    //cell.myImageView.layer.cornerRadius = 5.0;
    //cell.myImageView.layer.borderWidth = 4.0f;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat values[4] = {0, 0, 0, 1.0}; 
    CGColorRef grey = CGColorCreate(space, values); 
    cell.myImageView.layer.borderColor = grey;
    CGColorRelease(grey);
    CGColorSpaceRelease(space);
    
    
    if(url!=nil && ![Utils IsEmpty:[NSURL URLWithString:[cellData objectForKey:@"iconSmall"]]]){
         
        [cell.myImageView loadFromURL:url];
        float sw=1;
        float sh=1;
        cell.myImageView.transform=CGAffineTransformMakeScale(sw,sh);
    }
    else{
        UIImage* myImage = [UIImage imageNamed:@"calendar.png"];
        [cell.myImageView setImage:myImage];
        float sw=1;
        float sh=1;
        cell.myImageView.transform=CGAffineTransformMakeScale(sw,sh);
    }
    
    
	return cell;
}



// Methods to load and cache an image from a URL on a separate thread
-(void)loadFromURL:(NSURL *)url
{
	[self performSelectorInBackground:@selector(cacheFromURL:) withObject:url]; 
}

-(void)loadFromURL:(NSURL*)url afterDelay:(float)delay
{
	[self performSelector:@selector(loadFromURL:) withObject:url afterDelay:delay];
}


/* setta l'altezza della cella*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 91.0;
}




#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    
    NSDictionary *dictionary = [listaOggetti objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"Elementi"];
	NSDictionary *cellData = [array objectAtIndex:indexPath.row];
    
    
	//NSMutableString *idSelection = [[NSMutableString alloc] initWithString:[cellData objectForKey:@"evento"]];
	//NSMutableString *nameSelection = [[NSMutableString alloc] initWithString:[cellData objectForKey:@"nome"]];
	
	
	appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    //appDelegate.idSelection = idSelection;
	appDelegate.dictionarySelection = cellData;
    
	eventView = [[EventViewController alloc] init];
	  //viewPhotos.idSection = idSection;
	//viewPhotos.nameSelection = nameSelection	
	//Facciamo visualizzare la vista con i dettagli
	[self.navigationController pushViewController:eventView animated:YES];
	
	//rilasciamo il controller
	[eventView release];
    eventView = nil;
	
;
    
	/*UIAlertView *popUp = [[UIAlertView alloc] initWithTitle:@"Hai selezionato:" message:[cellData objectForKey:@"id"] delegate:self cancelButtonTitle:@"OK"
	 otherButtonTitles:nil];
	 [popUp show];
	 [popUp release];*/
    
	
	//[idSelection release];
	//[nameSelection release];
    //[dictionary release];
    //[cellData release  
}

- (void)dealloc {
	[lista release];
    [listaOggetti dealloc];
    [listaSezioni dealloc];
    [spinner dealloc];
    [progressAlert dealloc];
    //[viewPhotos release];
    [super dealloc];
    
}

@end
