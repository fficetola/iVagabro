#import "Three20/Three20.h"
#import "LuBannAppAppDelegate.h"

@interface PhotoTest2Controller : TTThumbsViewController {
	
	NSMutableArray *listaPhotos;
	LuBannAppAppDelegate *appDelegate;
	NSMutableString *idSection;
	NSMutableString *nameSection;
	
}

@property (nonatomic, retain) NSMutableArray *listaPhotos;
@property (nonatomic, retain) LuBannAppAppDelegate *appDelegate;
@property (nonatomic, retain) NSMutableString *idSection;
@property (nonatomic, retain) NSMutableString *nameSection;

@end
