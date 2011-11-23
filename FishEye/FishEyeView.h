//
//  FishEyeView.h
//  FishEyeDemo
//
//  Created by haiwei li on 11-11-22.
//  Copyright (c) 2011年 13awan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EYE_COUNT 24



@protocol selectDelegate;


@interface FishEyeView : UIView{
    
    id <selectDelegate> selectionDelegate;
    
    UIImageView * alphabets[EYE_COUNT];
    UIImageView * alphabets2[EYE_COUNT];

    int index;
    int indexTmp;
    //----------
    //鼠标最大响应距离，最小响应距离
    float m_MaxDisc;
    float m_MinDisc;
    //图标最大缩放比例，最小缩放比例
    float m_MaxRate;
    float m_MinRate;
    //图标初始大小
    float m_Width;
    float m_Height;
    float m_A;
    float m_B;
    float m_Offset;
    
    float m_StartY;
    

}
@property (nonatomic, assign)id <selectDelegate> selectionDelegate;

- (void) initializeWithNames:(NSMutableArray *)_nameArray 
                 withMinSize:(CGSize)_minSize
                 withMaxRate:(float)_maxRate
             withActionCount:(int)_actionCount;

@end

@protocol selectDelegate <NSObject>

- (void)indexAt:(NSInteger)index;

@end
