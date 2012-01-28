//
//  Utils.h
//  LuBannApp
//
//  Created by Francesco Ficetola on 18/09/11.
//  Copyright 2011 Eustema. All rights reserved.
//


@interface Utils : NSObject

+ (id)readPlist:(NSData *)plistData;
+ (void) testConnection;
+ (NSMutableArray *)downloadPlist:(NSString *)url;
+ (void) testConnectionThread;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
+ (BOOL) NSStringIsValidEmail:(NSString *)checkString;
@end


