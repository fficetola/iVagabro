//  UIImageView+Cached.h
//
//  Created by Lane Roathe
//  Copyright 2009 Ideas From the Deep, llc. All rights reserved.

@interface UIImageView (Cached)

-(void)loadFromURL:(NSURL*)url;

-(void)loadFromURL:(NSURL*)url afterDelay:(float)delay;

@end

