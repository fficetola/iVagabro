//
//  MapViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 13/11/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "MapViewController.h"
#import "DisplayMap.h"
#import "RegexKitLite.h"
#import "iVagabroAppDelegate.h"

@interface MapViewController()

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded;
-(void) updateRouteView;
-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) from to: (CLLocationCoordinate2D) to typePath:(NSString*)type;
-(void) centerMap;

@end

@implementation MapViewController

//@synthesize lineColor,from,to;

@synthesize lineColor, origine, destinazione;


- (IBAction)gestioneZoom:(id)sender{
	//if (switchZoom.on){
		mapView.zoomEnabled=TRUE;
	/*} else {
		mapView.zoomEnabled=FALSE;
	}*/
    
}

- (IBAction)gestioneScroll:(id)sender{
	//if (switchScroll.on){
		mapView.scrollEnabled=TRUE;
	/*} else {
		mapView.scrollEnabled=FALSE;
	}*/
    
}

- (IBAction)visualizzaMiaPosizione:(id)sender{
	mapView.showsUserLocation=TRUE;
}

- (IBAction)mostraTipoMappa:(id)sender{
	if ([segmentTipoMappa selectedSegmentIndex]==0) {
		mapView.mapType = MKMapTypeStandard;
	} else if ([segmentTipoMappa selectedSegmentIndex]==1) {
		mapView.mapType = MKMapTypeSatellite;
	} else if ([segmentTipoMappa selectedSegmentIndex]==2) {
		mapView.mapType = MKMapTypeHybrid;
	}
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



-(IBAction) scegliPercorso
{
	//NSLog(@"ActionSheetViewController::alert");
	appDelegate = (iVagabroAppDelegate*)[[UIApplication sharedApplication]delegate];
    

	UIActionSheet *actionsheet = [[UIActionSheet alloc] 
                                  initWithTitle:@"Vuoi calcolare il percorso?"
                                  delegate:self 
                                  cancelButtonTitle:@"Annulla" 
                                  destructiveButtonTitle:nil
                                  otherButtonTitles: @"Percorso in macchina",@"Percorso a piedi",
                                  nil
								  ];
	//[actionsheet showInView:[self view]];
	[actionsheet showInView:appDelegate.window];
    [actionsheet release];
    
   
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSLog(@"button %i clicked", buttonIndex );
    
    //calcolo il percorso
    switch (buttonIndex) {
		case 0: [self showRouteFrom:origine to:destinazione typePath:nil]; break;
		case 1: [self showRouteFrom:origine to:destinazione typePath:@"w"]; break;
		default: break;
         
	}
    
    
    /** INIZIO CALCOLO DELLA DISTANZA AEREA **/
    /*PlaceMark* from = [[[PlaceMark alloc] initWithPlace:origine] autorelease];
    PlaceMark* to = [[[PlaceMark alloc] initWithPlace:destinazione] autorelease];
    
    
    [self calculateRoutesDistanceFrom:from.coordinate to:to.coordinate];  
     */
    
    /** FINE CALCOLO DELLA DISTANZA AEREA **/
    
}





#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"Mappa";
    
    //mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    mapView.showsUserLocation = YES;
    //[mapView setDelegate:self];
    //[self addSubview:mapView];
    routeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
    routeView.userInteractionEnabled = NO;
    [mapView addSubview:routeView];
    
    self.lineColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:1.0];
    
    [mapView setDelegate:self];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    
    
    //Recupero la posizione corrente con il LOCATION MANAGER (vedi il metodo didUpdateLocation)
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
	
   
	
	destinazione = [[Place alloc] init];
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
	destinazione.name = [appDelegate.dictionarySelection objectForKey:@"locale"];
	destinazione.description = [appDelegate.dictionarySelection objectForKey:@"dove"];    
    double latitudine =  [[appDelegate.dictionarySelection objectForKey:@"latitudine"]doubleValue];
	destinazione.latitude = latitudine;
    double longitudine =  [[appDelegate.dictionarySelection objectForKey:@"longitudine"]doubleValue];
	destinazione.longitude = longitudine;
    
    [self showMap:destinazione];
    
    /**** INIZIO CALCOLO DELLA DISTANZA AEREA ****/
    
     //[reverseGeocoder start];
    
    /**** FINE CALCOLO DELLA DISTANZA AEREA ****/

	
    //[self showRouteFrom:origine to:destinazione typePath:@"h"];
    
    /*Region and Zoom
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    region.span=span;
    CLLocationCoordinate2D location=mapView.userLocation.coordinate;
    region.center=location;
    */
    /*Geocoder Stuff*/
  
    //mapView.mapType = MKMapTypeSatellite;
    
 /*   [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
     MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
    region.center.latitude = 41.93156;
    region.center.longitude = 12.528963;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapView setRegion:region animated:YES]; */
    
   
    
    /*DisplayMap *ann = [[DisplayMap alloc] init]; 
    ann.title = @" Kolkata";
    ann.subtitle = @"Mahatma Gandhi Road"; 
    ann.coordinate = region.center; 
    [mapView addAnnotation:ann];
    [ann release];
    
    
    //LOCATION MANAGER
    lm = [[CLLocationManager alloc] init];
    if ([lm locationServicesEnabled]) {
        lm.delegate = self;
        lm.desiredAccuracy = kCLLocationAccuracyBest;
        lm.distanceFilter = 1000.0f;
        [lm startUpdatingLocation];
    }*/
    
   
    
    
}




//questo metodo trova la posizione corrente del GPS
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D here =  newLocation.coordinate;
    NSLog(@"%f  %f ", here.latitude, here.longitude);
    
	origine = [[Place alloc] init];
	origine.name = @"Tu";
	origine.description = @"Tu sei qui!";
   
	origine.latitude =  here.latitude;
	origine.longitude = here.longitude;
}



/*-(void) calculateDistanceBetweenTwoPoints:(CLLocationCoordinate2D *)pointAAnnotation toPoint:(CLLocationCoordinate2D*) pointBAnnotation{
    
    CLLocationCoordinate2D pointACoordinate = pointAAnnotation;
    CLLocation *pointALocation = [[CLLocation alloc] initWithLatitude:pointACoordinate.latitude longitude:pointACoordinate.longitude];
    CLLocationCoordinate2D pointBCoordinate = pointBAnnotation;
    CLLocation *pointBLocation = [[CLLocation alloc] initWithLatitude:pointBCoordinate.latitude longitude:pointBCoordinate.longitude];
    double distanceMeters = [pointALocation getDistanceFrom:pointBLocation];
    double distanceMiles = (distanceMeters / 1609.344);
}*/


-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = nil; 
    if(annotation != mapView.userLocation) 
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
        
        pinView.pinColor = MKPinAnnotationColorRed; 
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    } 
    else {
        [mapView.userLocation setTitle:@"Sei qui!"];
    }
    return pinView;
}


/*- (id) initWithFrame:(CGRect) frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		mapView.showsUserLocation = YES;
		[mapView setDelegate:self];
		//[self addSubview:mapView];
		routeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
		routeView.userInteractionEnabled = NO;
		[mapView addSubview:routeView];
		
		self.lineColor = [UIColor colorWithWhite:0.2 alpha:0.5];
	}
	return self;
}

*/



-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
	NSInteger lat=0;
	NSInteger lng=0;
	while (index < len) {
		NSInteger b;
		NSInteger shift = 0;
		NSInteger result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude = [[[NSNumber alloc] initWithFloat:lat * 1e-5] autorelease];
		NSNumber *longitude = [[[NSNumber alloc] initWithFloat:lng * 1e-5] autorelease];
		printf("[%f,", [latitude doubleValue]);
		printf("%f]", [longitude doubleValue]);
		CLLocation *loc = [[[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]] autorelease];
		[array addObject:loc];
	}
	
	return array;
}




-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t typePath:(NSString*)type{
	
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
	
    //type=h (percorso in macchina-evita strade principali "Avoid Highways")
    //type=t (percorso in macchina-evita pedaggi "Avoid Tolls")
    //type=w (percorso a piedi)
    //type=null (nil) (percorso in macchina)
    
     
	NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?dirflg=%@&output=dragdir&saddr=%@&daddr=%@", type, saddr, daddr];
	NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
	NSLog(@"api url: %@", apiUrl);
	NSError *error = nil;
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSASCIIStringEncoding error:&error];
	
    
    NSLog(@"apiResponse: %@", apiResponse);
    
    //Recupero la distanza in metri
    NSString *tooltip = [apiResponse stringByMatching:@"tooltipHtml:\\\" ([^\\\"]*)\\\"" capture:1L];
    
    tooltip = [tooltip stringByReplacingOccurrencesOfString:@"\\x26#160;"
                                                  withString:@" "];
    
    //visualizzo a video la distanza e il tempo di percorrenza
    //stampo il risultato a video
    if(tooltip!=nil){
        UILabel *distanceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 24)] autorelease];
        distanceLabel.font = [UIFont fontWithName:@"Arial" size: 12.0];
        //distanceLabel.shadowColor = [UIColor blackColor];
        distanceLabel.shadowOffset = CGSizeMake(1,1);
        distanceLabel.textColor = [UIColor blueColor];
        distanceLabel.text = [NSString stringWithFormat:@"Distanza/Tempo: %@", tooltip];
        //distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textAlignment = UITextAlignmentCenter;
        [self.view addSubview:distanceLabel]; 
    }
    
    
    NSString* encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
    
    if(encodedPoints!=nil && [encodedPoints length] > 0){
        
        NSMutableString *encodedPointsMutable = [[NSMutableString alloc] initWithString:encodedPoints];
        
        NSArray * array = [self decodePolyLine:encodedPointsMutable];
        [encodedPointsMutable release];
        
        return array;

    }
    else
    {
        return nil;
    }
                              
	
	
}




-(void) centerMap {
	MKCoordinateRegion region;
    
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 90;
	CLLocationDegrees minLon = 180;
	for(int idx = 0; idx < routes.count; idx++)
	{
		CLLocation* currentLocation = [routes objectAtIndex:idx];
		if(currentLocation.coordinate.latitude > maxLat)
			maxLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.latitude < minLat)
			minLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.longitude > maxLon)
			maxLon = currentLocation.coordinate.longitude;
		if(currentLocation.coordinate.longitude < minLon)
			minLon = currentLocation.coordinate.longitude;
	}
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
	
	[mapView setRegion:region animated:YES];
}



/*
 questa funzione disegna un solo punto (la destinazione) sulla mappa
 */
 
-(void) showMap: (Place*) t{
    
    [mapView setMapType:MKMapTypeStandard];
    [mapView setZoomEnabled:YES];
    [mapView setScrollEnabled:YES];
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
    region.center.latitude = t.latitude;
    region.center.longitude = t.longitude;
    region.span.longitudeDelta = 0.01f;
    region.span.latitudeDelta = 0.01f;
    [mapView setRegion:region animated:YES]; 
    
    
    //inserisco l'annotation per la destinazione
   /* DisplayMap *annotationDestination = [[DisplayMap alloc] init]; 
    annotationDestination.title = destinazione.name;
    annotationDestination.subtitle = destinazione.description;
    annotationDestination.coordinate = region.center; 
    [mapView addAnnotation:annotationDestination];
    [annotationDestination release];
    */
    PlaceMark* to = [[[PlaceMark alloc] initWithPlace:t] autorelease];
    [mapView addAnnotation:to];
    
    
}

/*
 questa funzione disegna il tracciato tra l'origine e la destinazione sulla mappa
 */
-(void) showRouteFrom: (Place*) f to:(Place*) t typePath:(NSString*)type{
	
	if(routes) {
		[mapView removeAnnotations:[mapView annotations]];
		[routes release];
	}
	
	PlaceMark* from = [[[PlaceMark alloc] initWithPlace:f] autorelease];
	PlaceMark* to = [[[PlaceMark alloc] initWithPlace:t] autorelease];
	
	[mapView addAnnotation:from];
	[mapView addAnnotation:to];
  	
	routes = [[self calculateRoutesFrom:from.coordinate to:to.coordinate typePath:type] retain];
	if(routes != nil){
        [self updateRouteView];
        [self centerMap]; 
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Errore"
                              message:@"Spiacenti, non è stato possibile calcolare il percorso!"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil];
        [alert show];
        [alert release];
    }
    
	
}




-(void) updateRouteView {
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
	CGContextRef context = 	CGBitmapContextCreate(nil, 
												  routeView.frame.size.width, 
												  routeView.frame.size.height, 
												  8, 
												  4 * routeView.frame.size.width,
												  space,
												  kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(space);
    
	CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
	CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
	CGContextSetLineWidth(context, 3.0);
	
	for(int i = 0; i < routes.count; i++) {
		CLLocation* location = [routes objectAtIndex:i];
		CGPoint point = [mapView convertCoordinate:location.coordinate toPointToView:routeView];
		
		if(i == 0) {
			CGContextMoveToPoint(context, point.x, routeView.frame.size.height - point.y);
		} else {
			CGContextAddLineToPoint(context, point.x, routeView.frame.size.height - point.y);
		}
	}
	
	CGContextStrokePath(context);
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	UIImage* img = [UIImage imageWithCGImage:image];
	
	routeView.image = img;
	CGContextRelease(context);
    context = nil;
    CGImageRelease(image);
    
}


/** calcolo del percorso in metri **/
- (id)calculateRoutesDistanceFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t
{
    
    CLLocation *locationFrom = [[CLLocation alloc] initWithLatitude:f.latitude longitude:f.longitude];
    CLLocation *locationTo = [[CLLocation alloc] initWithLatitude:t.latitude longitude:t.longitude];
    distance = [locationFrom distanceFromLocation:locationTo];
    reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:t];
    reverseGeocoder.delegate = self;
    
    //converto i metri in KM
    //distance = distance/1000;
    
    //stampo il risultato a video
    UILabel *distanceLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 320, 24)] autorelease];
    
    distanceLabel.text = [NSString stringWithFormat:@"Distanza aerea (in metri): %.0f", distance];
    [self.view addSubview:distanceLabel];
       
    [locationFrom release];
    [locationTo release];
    
    return self;
}



- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    NSDictionary *addressData = placemark.addressDictionary;
    CGFloat y = 50;
    for (NSString *key in [addressData allKeys]) {
        if ([key compare:@"FormattedAddressLines"] != NSOrderedSame) {
            UILabel *newRow = [[[UILabel alloc] initWithFrame:CGRectMake(5, y, 310, 24)] autorelease];
            newRow.text = [NSString stringWithFormat:@"%@: %@", key, [addressData objectForKey:key]];
            [self.view addSubview:newRow];
            y += 24;
        }
    }
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	UILabel *geocoderFail = [[[UILabel alloc] initWithFrame:CGRectMake(5, 50, 310, 24)] autorelease];
	geocoderFail.text = @"Reverse geocoding fallito";
	[self.view addSubview:geocoderFail];
}




#pragma mark mapView delegate functions
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	routeView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	[self updateRouteView];
	routeView.hidden = NO;
	[routeView setNeedsDisplay];
}


-(void) viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}


- (void)dealloc {
	if(routes) {
		[routes release];
	}
    
    //[origine release];
    //[destinazione release];
	[mapView release];
	[routeView release];
    [locationManager release];
    [super dealloc];
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



@end
