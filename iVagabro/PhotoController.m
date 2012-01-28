#import "PhotoTest2Controller.h"
#import "MockPhotoSource.h"
#import "Utils.h"


@implementation PhotoTest2Controller

@synthesize listaPhotos;
@synthesize appDelegate;
@synthesize idSection;
@synthesize nameSection;

- (void)viewDidLoad {
	
	//url della directory sul server con le foto
	NSString *directoryPhotos = @"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/";
	NSString *directoryThumbs = @"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/";
	
    appDelegate = (LuBannAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    idSection = appDelegate.idSection;
    
    NSLog(@"VIEW DID LOAD IN PHOTOCONTROLLER - IDSECTION: %@.", idSection);

	
	//concateno alla URL il parametro idBoard
	NSString *indirizzo = @"http://www.lubannaiuolu.net/lubannapp/getPhotosInSection.php?id_section=";
	indirizzo = [indirizzo stringByAppendingString:idSection];
	
	//crea un oggetto URL
	//NSURL *url = [NSURL URLWithString:indirizzo];
	
	//prendo i dati dal server
	//listaPhotos = [[NSMutableArray alloc]initWithContentsOfURL:url];
    listaPhotos = [[NSMutableArray alloc]initWithArray:[Utils downloadPlist:indirizzo]];

	
	
	//popolo la lista locale delle foto con le singole info
    NSMutableArray *photosArray2 = [NSMutableArray array]; 
	
	//itero sul singolo elemento presente nella lista foto
	for (NSDictionary *element in listaPhotos) {
		
        NSString *prefixThumb = @"t_";
		NSString *filePhoto = [element objectForKey:@"file"];
		NSString *titolo = [element objectForKey:@"name"];
		
		NSString *pathPhoto = [directoryPhotos stringByAppendingString:filePhoto];
		
			
		//controllo l'estensione: se è png devo trovare il thumb in jpg
		NSArray *filenameSplitted = [filePhoto componentsSeparatedByString: @"."];
		NSString *filenameWithoutExtension = [filenameSplitted objectAtIndex: 0];
		NSString *extensionPhoto = [filenameSplitted objectAtIndex: 1];
		
		NSString *fileThumb = nil;
        
       
        if([extensionPhoto isEqualToString:@"png"] || [extensionPhoto isEqualToString:@"gif"] || [extensionPhoto isEqualToString:@"bmp"]){
			fileThumb = [[NSString alloc] initWithString:[[prefixThumb stringByAppendingString:filenameWithoutExtension] stringByAppendingString: @".jpg"]];
		}
		else{
			fileThumb = [[NSString alloc] initWithString:[prefixThumb stringByAppendingString:filePhoto]];
		}
		 
		
		
		NSMutableString *pathThumb = [[NSMutableString alloc] initWithString:[directoryThumbs stringByAppendingString:fileThumb]];	
		
        
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
        [fileThumb release];
        [pathThumb release];
		
        
	}
	
	//[array addObject:@ "Hello" ]; 
	
	
 
 /*  NSMutableArray* photosArray =[[NSMutableArray alloc] initWithObjects:
	 [[[MockPhoto alloc]
	   initWithURL:@"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/a_3522.png"
	   smallURL:@"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/a_3522.png"
	   size:CGSizeMake(460, 633)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/a_3522.png"
	   smallURL:@"http://www.lubannaiuolu.net/mkportal/modules/gallery/album/a_3522.png"
	   size:CGSizeMake(460, 633)
	   caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
	   smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"A hike."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
	   size:CGSizeMake(383, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
	   size:CGSizeMake(407, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
	   size:CGSizeMake(500, 406)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
	   smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
	   size:CGSizeMake(500, 372)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
	   size:CGSizeMake(960, 1280)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
	   smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"A hike."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
	   size:CGSizeMake(383, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
	   size:CGSizeMake(407, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
	   size:CGSizeMake(500, 406)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
	   smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
	   size:CGSizeMake(500, 372)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
	   size:CGSizeMake(960, 1280)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
	   smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"A hike."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
	   size:CGSizeMake(383, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
	   size:CGSizeMake(407, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
	   size:CGSizeMake(500, 406)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
	   smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
	   size:CGSizeMake(500, 372)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
	   size:CGSizeMake(960, 1280)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
	   smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"A hike."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
	   size:CGSizeMake(383, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
	   size:CGSizeMake(407, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
	   size:CGSizeMake(500, 406)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7.jpg"
	   smallURL:@"http://farm2.static.flickr.com/1004/3174172875_1e7a34ccb7_t.jpg"
	   size:CGSizeMake(500, 372)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2300/2179038972_65f1e5f8c4_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
	   size:CGSizeMake(960, 1280)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
	   smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
	   size:CGSizeMake(320, 480)
	   caption:@"A hike."] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
	   smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
	   size:CGSizeMake(320, 480)] autorelease],
	 
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e.jpg"
	   smallURL:@"http://farm3.static.flickr.com/2358/2179913094_3a1591008e_t.jpg"
	   size:CGSizeMake(383, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3162/2677417507_e5d0007e41_t.jpg"
	   size:CGSizeMake(391, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3334/3334095096_ffdce92fc4_t.jpg"
	   size:CGSizeMake(407, 500)] autorelease],
	 [[[MockPhoto alloc]
	   initWithURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889.jpg"
	   smallURL:@"http://farm4.static.flickr.com/3118/3122869991_c15255d889_t.jpg"
	   size:CGSizeMake(500, 406)] autorelease],
	 nil
	 ];
	
  	*/

	NSMutableString *titolo = nameSection;	
	
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
}


- (void)dealloc {
	
    [super dealloc];
   }

@end
