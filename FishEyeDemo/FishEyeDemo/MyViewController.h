//
//  MyViewController.h
//  FishEyeDemo
//
//  Created by haiwei li on 11-11-22.
//  Copyright (c) 2011年 13awan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FishEyeView.h"

@interface MyViewController : UIViewController<selectDelegate>{
    
}
@property (nonatomic, retain) IBOutlet FishEyeView * fishEyeView;
@end
