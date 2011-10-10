//
//  iVagabroAppDelegate.h
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 Eustema. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iVagabroAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
