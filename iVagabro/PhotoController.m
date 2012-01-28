#import "PhotoController.h"
#import "MockPhotoSource.h"
#import "Utils.h"


@implementation PhotoController

@synthesize listaPhotos;
@synthesize appDelegate;
@synthesize idSelection;
@synthesize nameSelection;

- (void)viewDidLoad {
	
	//url della directory sul server con le foto
	//NSString *directoryPhotos = @"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/";
	//NSString *directoryThumbs = @"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/";
	
    appDelegate = (iVagabroAppDelegate *)[[UIApplication sharedApplication] delegate];
    idSelection = appDelegate.idSelection;
    
	//concateno alla URL il parametro idBoard
	NSString *indirizzo = @"http://www.lubannaiuolu.net/ivagabro/getPhotosInSection";
	indirizzo = [indirizzo stringByAppendingString:idSelection];
    indirizzo = [indirizzo stringByAppendingString:@".plist"];
    
  	//crea un oggetto URL
	//NSURL *url = [NSURL URLWithString:indirizzo];
	
	//prendo i dati dal server
	//listaPhotos = [[NSMutableArray alloc]initWithContentsOfURL:url];
    
    listaPhotos = [[NSMutableArray alloc]initWithArray:[Utils downloadPlist:indirizzo]];

	
	
	//popolo la lista locale delle foto con le singole info
    NSMutableArray *photosArray2 = [NSMutableArray array]; 
	
	//itero sul singolo elemento presente nella lista foto
	for (NSDictionary *element in listaPhotos) {
		
        NSString *prefixThumb = [element objectForKey:@"thumbUrl"];
		NSString *filePhoto = [element objectForKey:@"photoUrl"];
		NSString *titolo = [element objectForKey:@"title"];
		
		NSString *pathPhoto = filePhoto;
		
		NSMutableString *pathThumb = [[NSMutableString alloc] initWithString:prefixThumb];
        
		int width = [[element objectForKey:@"width"]intValue];
		int height = [[element objectForKey:@"height"]intValue];
		
		//se non trovo il thumbs, lo cerco con altra estensione
	/*	NSURL *url = [NSURL URLWithString:pathThumb];
		NSData *imageData = [NSData dataWithContentsOfURL:url];
		if ([imageData length] ==0) {
	 
	 */
            
	/*		NSArray *filenameSplitted = [fileThumb componentsSeparatedByString: @"."];	
			NSString *filenameWithoutExtensions = [filenameSplitted objectAtIndex: 0];			
			NSString *fileThumbWithExtension = [filenameWithoutExtensions stringByAppendingString:@".JPG"];
			NSString *pathThumb2 = [directoryThumbs stringByAppendingString:fileThumbWithExtension];	
*/
			//se non lo trovo con estensione JPG, lo cerco con estensione jpg
	/*		if ([fileManager fileExistsAtPath:pathThumb2] == NO) {
				fileThumbWithExtension = [filenameWithoutExtensions stringByAppendingString:@".jpg"];
				
			}*/
			
	/*		pathThumb = [NSMutableString stringWithString:[directoryThumbs stringByAppendingString:fileThumbWithExtension]];
		}
	*/
		
		
		MockPhoto *mockPhoto = [[[MockPhoto alloc]
								 initWithURL:pathPhoto
								 smallURL:pathThumb
								 size:CGSizeMake(width, height)
								 caption:titolo] autorelease];
		
		//NSMutableString *idSection = [[NSMutableString alloc] initWithString:[element objectForKey:@"id"]];
		[photosArray2 addObject:mockPhoto]; 
		
		//[thumb release];
       // [fileThumb release];
        [pathThumb release];
		
        
	}
	

	NSMutableString *titolo = appDelegate.nameSelection;	
	
  self.photoSource = [[[MockPhotoSource alloc]
    initWithType:MockPhotoSourceNormal
    //initWithType:MockPhotoSourceDelayed
    // initWithType:MockPhotoSourceLoadError
    // initWithType:MockPhotoSourceDelayed|MockPhotoSourceLoadError
    title:titolo
    photos: photosArray2
    photos2:nil
//  photos2:[[NSArray alloc] initWithObjects:
//    [[[MockPhoto alloc]
//      initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg"
//      smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg"
//      size:CGSizeMake(800, 533)] autorelease],
//    nil]

  ]autorelease];
	
  
    //[titolo release];
	//[photosArray2 release];
    
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
}


- (void)dealloc {
	
    [super dealloc];
   }

@end
