//
//  FishEyeView.h
//  FishEyeDemo
//
//  Created by haiwei li on 11-11-22.
//  Copyright (c) 2011年 13awan. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef struct _eyeViewInfo {
//    
//    CGRect rect;
//    CGPoint center;
//    
//} EyeViewInfo;

@interface FishEyeView : UIView{
    
    NSMutableArray * eyeViews;
    NSMutableArray * eyeViewsHide;

    //鱼眼索引
    int index;

    //图标最大缩放比例，最小缩放比例
    float m_MaxRate;
    float m_MinRate;
    
    //影响到的数量（奇数）
    int m_MaxCount;
    
    //图标初始大小
    float m_Width;
    float m_Height;
    
    //系数
    float a;
    float b;
    
    BOOL horizontal;
    
    float startY;
    float startX;
}
- (void) initializeWithNames:(NSMutableArray *)_nameArray 
                 withMinSize:(CGSize)_minSize
                 withMaxRate:(float)_maxRate
             withActionCount:(int)_actionCount;

@end
