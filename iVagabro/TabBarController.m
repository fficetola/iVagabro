#import "TabBarController.h"
#import "iVagabroAppDelegate.h"
#import "Utils.h"

@implementation TabBarController

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

-(void)tabBar:(UITabBarController*)tabBar didSelectViewController:(UIViewController*)viewController{
	 

}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
     
    if([self selectedIndex] == 0 || [self selectedIndex] == 2  || [self selectedIndex] == 3 || [self selectedIndex] == 4){
        return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ||
                interfaceOrientation == UIInterfaceOrientationPortrait);
    }
    
    return YES;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.selectedViewController viewWillAppear:NO];
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    //[Utils testConnectionThread];
    
  /*  UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   [self.view addSubview:spinner];
   spinner.center = self.view.center;
   [spinner startAnimating];
   */ 
     
    

    
   }
@end
