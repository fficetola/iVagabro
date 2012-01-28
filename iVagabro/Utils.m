//
//  Utils.m
//  LuBannApp
//
//  Created by Francesco Ficetola on 18/09/11.
//  Copyright 2011 Eustema. All rights reserved.
//


#import "Utils.h"
#import "ASIHTTPRequest.h"


@implementation Utils



+ (id)alloc {
    
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'ClassName' cannot be instantiated!"];
    
    return nil;
    
}


//funzione che converte i plist in formato NSData in NSMutableArray o NSMutableDictionary
+ (id)readPlist:(NSData *)plistData {  
    
    NSString *error;  
    NSPropertyListFormat format;  
    id plist;  
    plist = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];  
    if (!plist) {  
        NSLog(@"Error reading plist from file , error = '%s'",  [error UTF8String]);  
        [error release];  
    }  
    
    return plist;  
}  


//funzione che testa la connessione ad Internet
+ (void) testConnection{
    
    //faccio uscire la rotellina
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
    
    //controllo se c'è rete
    NSError* error = nil;
    NSString * test = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.lubannaiuolu.net"] encoding:NSUnicodeStringEncoding error:&error]; 
    if (test == nil) { 
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Errore di rete" message: @"Connettività ad Internet limitata o assente!" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release]; 
    } 
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO; 
    
}


+ (void) testConnectionThread{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [NSThread sleepForTimeInterval:2];
    [self performSelectorOnMainThread:@selector(testConnection) withObject:nil waitUntilDone:NO];
    [pool release];
}



//download plist in modalità sincrona
+ (NSMutableArray *)downloadPlist:(NSString *)url {
    NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10]; 
    NSURLResponse *resp = nil;
    NSError *err = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&resp error:&err];
    
    if (!err) {
        NSString *errorDescription = nil;
        NSPropertyListFormat format;
        NSMutableArray *samplePlist = [NSPropertyListSerialization propertyListFromData:responseData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&errorDescription];
        
        if (!errorDescription)
            return samplePlist;
        else {
            
            //errore nella chiamata al server
            UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Errore di rete" message: @"Connettività ad Internet limitata o assente!" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            

            [someError show];
            [someError release];
            
            //inizializzo
            NSMutableArray *samplePlist = [NSMutableArray array];

            return samplePlist; 
            
        }
        
        [errorDescription release];              
    }
    else {
        
        //errore nella chiamata al server
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Errore di rete" message: @"Connettività ad Internet limitata o assente!" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        
        [someError show];
        [someError release];
        
        //inizializzo
        //NSMutableArray *samplePlist = [[NSMutableArray alloc]initWithCapacity:0];
        NSMutableArray *samplePlist = [NSMutableArray array];
        return samplePlist; 
        
    }
    
    return nil;
}


//funzione per settare un colore in esadecimale
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity]; 
}  


//validazione della email
+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


+ (NSString *)readKeyInProperties:(NSString *) key
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"data.plist"];
    NSDictionary *plistData = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];
    
    
    NSString *value;
    value = [plistData objectForKey:key];
    
    [plistData release];
    return value;
    /* You could now call the string "value" from somewhere to return the value of the string in the .plist specified, for the specified key. */
}


@end

