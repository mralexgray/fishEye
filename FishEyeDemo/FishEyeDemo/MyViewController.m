//
//  MyViewController.m
//  FishEyeDemo
//
//  Created by haiwei li on 11-11-22.
//  Copyright (c) 2011年 13awan. All rights reserved.
//

#import "MyViewController.h"

@implementation MyViewController

@synthesize fishEyeView;

- (void)dealloc{
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    int count = 24;
    NSMutableArray * nameArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; ++i) {
        [nameArray addObject:[NSString stringWithFormat:@"eye_item_%d.png", i]];
    }
    CGSize minSize = CGSizeMake(30, 30);
    
    [fishEyeView initializeWithNames:nameArray 
                         withMinSize:minSize 
                         withMaxRate:3.0f 
                     withActionCount:7];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
