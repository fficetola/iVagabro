#import "TabBarController.h"
#import "CatalogController.h"
#import "Utils.h"

@implementation TabBarController

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

-(void)tabBar:(UITabBarController*)tabBar didSelectViewController:(UIViewController*)viewController{
	 

}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Always returning YES means the view will rotate to accomodate any orientation.
    
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
