//
//  iVagabroAppDelegate.h
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iVagabroAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{


    NSMutableString *idSelection;
    NSMutableString *nameSelection;
    NSMutableString *urlSelection;
    NSDictionary *dictionarySelection;
    UITabBarController *tabBarController;

}


@property (nonatomic, retain) NSMutableString *idSelection;
@property (nonatomic, retain) NSMutableString *nameSelection; 
@property (nonatomic, retain) NSMutableString *urlSelection; 
@property (nonatomic, retain) NSDictionary *dictionarySelection;




@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
