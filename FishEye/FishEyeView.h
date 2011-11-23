//
//  FishEyeView.h
//  FishEyeDemo
//
//  Created by haiwei li on 11-11-22.
//  Copyright (c) 2011年 13awan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EYE_COUNT 24

//@interface VVImageView : UIImageView {
//    float m_Rate;//缩放比例
//    float m_Disc;//中心到鼠标的距离
//}
//@property(nonatomic) float m_Rate;
//@property(nonatomic) float m_Disc;
//@end


@interface FishEyeView : UIView{
    
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
    float a;
    float b;
    
    float startY;
    
    float labelWidth;
    

}

- (void) initializeWithNames:(NSMutableArray *)_nameArray 
                 withMinSize:(CGSize)_minSize
                 withMaxRate:(float)_maxRate
             withActionCount:(int)_actionCount;

@end
