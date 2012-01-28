//
//  FirstViewController.m
//  iVagabro
//
//  Created by Francesco Ficetola on 10/10/11.
//  Copyright 2011 lubannaiuolu. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

@synthesize imageView,firstViewContent, secondViewContent, thirdViewContent, contentView;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //gif animata
    CGRect imageframe = CGRectMake(10,85,300,100);
    imageView = [[UIImageView alloc] initWithFrame:imageframe];
    imageView.animationImages = [NSArray arrayWithObjects:    
                                 [UIImage imageNamed:@"home05.jpg"],
                                 [UIImage imageNamed:@"home02.jpg"],
                                 [UIImage imageNamed:@"home03.jpg"],
                                 [UIImage imageNamed:@"home04.jpg"],
                                 [UIImage imageNamed:@"home01.jpg"],
                                 [UIImage imageNamed:@"home06.jpg"],
                                 [UIImage imageNamed:@"home08.jpg"],
                                 [UIImage imageNamed:@"home09.jpg"],
                                 [UIImage imageNamed:@"home12.jpg"],
                                 [UIImage imageNamed:@"home13.jpg"],
                                 [UIImage imageNamed:@"home14.jpg"],
                                 [UIImage imageNamed:@"home15.jpg"],
                                 nil];
    imageView.animationDuration = 60.0f;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    [self.view addSubview: imageView];
    
    
    //qui setto la posizione della vista
    self.firstViewContent = [[FirstViewContentController  alloc]initWithNibName:@"FirstViewContent" bundle:nil];
    [self.contentView insertSubview:firstViewContent.view atIndex:0];
    
    CGRect r = [firstViewContent.view frame];
	r.origin.y = 0.0f;
	[firstViewContent.view setFrame:r];
	[firstViewContent release];
    
}


-(IBAction)switchViews:(id)sender
{
    
    //inizializzo la seconda vista
    if(self.secondViewContent == nil)
    {
        self.secondViewContent = [[SecondViewContentController alloc]initWithNibName:@"SecondViewContent" bundle:nil];
        ;
        
        //qui setto la posizione della vista
        CGRect r = [secondViewContent.view frame];
        r.origin.y = 0.0f;
        [secondViewContent.view setFrame:r];
        [secondViewContent release];
    }
    
    //inizializzo la terza vista
    if(self.thirdViewContent == nil)
    {
        self.thirdViewContent = [[ThirdViewContentController alloc] initWithNibName:@"ThirdViewContent" bundle:nil];
        
        //qui setto la posizione della vista
        CGRect r = [thirdViewContent.view frame];
        r.origin.y = 0.0f;
        [thirdViewContent.view setFrame:r];
        [thirdViewContent release];
    }
    
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration : 1.25];
    [UIView setAnimationCurve : UIViewAnimationCurveEaseInOut];
    
    //switcho alla prima vista (se sto alla terza)
    if(self.thirdViewContent.view.superview != nil && self.firstViewContent.view.superview == nil)
    {
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromRight
                               forView:self.view cache:YES];
        [firstViewContent viewWillAppear:YES];
        [secondViewContent viewWillDisappear:YES];
        [secondViewContent.view removeFromSuperview];
        [thirdViewContent viewWillDisappear:YES];
        [thirdViewContent.view removeFromSuperview];
        
        [self.contentView insertSubview:firstViewContent.view atIndex:0];
        [secondViewContent viewDidDisappear:YES];
        [thirdViewContent viewDidDisappear:YES];
        
        [firstViewContent viewDidAppear:YES];
    }
    //switcho alla seconda vista (se sto sulla prima)
    else if (self.firstViewContent.view.superview != nil && self.secondViewContent.view.superview == nil){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [secondViewContent viewWillAppear:YES];
        
        [firstViewContent viewWillDisappear:YES];
        [thirdViewContent viewWillDisappear:YES];
        
        [firstViewContent.view removeFromSuperview];
        [thirdViewContent.view removeFromSuperview];
        
        [self.contentView insertSubview:secondViewContent.view atIndex:0];
        [firstViewContent viewDidDisappear:YES];
        [thirdViewContent viewDidDisappear:YES];
    }
    //switcho alla terza vista (se sto sulla terza)
    else if(self.secondViewContent.view.superview != nil && self.thirdViewContent.view.superview == nil){
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [thirdViewContent viewWillAppear:YES];
        [secondViewContent viewWillDisappear:YES];
        [firstViewContent viewWillDisappear:YES];
        
        [firstViewContent.view removeFromSuperview];
        [secondViewContent.view removeFromSuperview];
        [self.contentView insertSubview:thirdViewContent.view atIndex:0];
        
        [secondViewContent viewDidDisappear:YES];
        [firstViewContent viewDidDisappear:YES];
        
    }
    
    
    [UIView commitAnimations];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
	return imageView;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
    [imageView release];
    [firstViewContent release];
    [secondViewContent release];
    [thirdViewContent release];
    [contentView release];
}

@end
