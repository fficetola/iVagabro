#import "Three20/Three20.h"
#import "iVagabroAppDelegate.h"

@interface PhotoController : TTThumbsViewController {
	
	NSMutableArray *listaPhotos;
	iVagabroAppDelegate *appDelegate;
	NSMutableString *idSelection;
	NSMutableString *nameSelection;
	
}

@property (nonatomic, retain) NSMutableArray *listaPhotos;
@property (nonatomic, retain) iVagabroAppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableString *idSelection;
@property (nonatomic, retain) NSMutableString *nameSelection;

@end
