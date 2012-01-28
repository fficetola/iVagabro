//
//  MapViewController.h
//  iVagabro
//
//  Created by Francesco Ficetola on 13/11/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "Place.h"
#import "PlaceMark.h"
#import "iVagabroAppDelegate.h"
#import "RegexKitLite.h"


@class DisplayMap;

@interface MapViewController : UIViewController<UIActionSheetDelegate, MKMapViewDelegate,CLLocationManagerDelegate, MKReverseGeocoderDelegate>{

	IBOutlet MKMapView *mapView;
	IBOutlet UISwitch *switchZoom;
	IBOutlet UISwitch *switchScroll;
	IBOutlet UIButton *cmdMiaPosizione;
	IBOutlet UISegmentedControl *segmentTipoMappa;
    CLLocationManager *locationManager;
	UIImageView* routeView;
    
    Place* origine;
    Place* destinazione;
    iVagabroAppDelegate* appDelegate;
	
	NSArray* routes;
	
	UIColor* lineColor;
    
    CLLocationDistance distance;
    MKReverseGeocoder *reverseGeocoder;
    
    }
    

- (id)calculateRoutesDistanceFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t;
- (void) showRouteFrom: (Place*) f to:(Place*) t typePath:(NSString*)type;
- (void) showMap: (Place*) t;
- (IBAction)gestioneZoom:(id)sender;
- (IBAction)gestioneScroll:(id)sender;
- (IBAction)visualizzaMiaPosizione:(id)sender;
- (IBAction)mostraTipoMappa:(id)sender;
- (IBAction)scegliPercorso;

@property (nonatomic, retain) Place* origine;
@property (nonatomic, retain) Place* destinazione;
@property (nonatomic, retain) UIColor* lineColor;

@end
