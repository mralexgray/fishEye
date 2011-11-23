//
//  FishEyeView.m
//  FishEyeDemo
//
//  Created by haiwei li on 11-11-22.
//  Copyright (c) 2011年 13awan. All rights reserved.
//

#import "FishEyeView.h"



@interface FishEyeView (hide)

- (void)resetPosition;

@end

@implementation FishEyeView (hide)

- (void)resetPosition{
    
    float viewH = m_Height * EYE_COUNT;
    startY = (self.frame.size.height - viewH) / 2;
    
    [UIView beginAnimations: @"FishEyeAnimation" context: NULL];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.3];
    
    for (int i = 0; i < EYE_COUNT; ++i){

        alphabets[i].frame = CGRectMake(0, startY + i * m_Height, labelWidth, m_Height);
        
        alphabets2[i].frame = CGRectMake(0, startY + i * m_Height, labelWidth, m_Height);
    }
    
    [UIView commitAnimations];
}

@end


@implementation FishEyeView


- (void)dealloc{
    
    
    
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void) awakeFromNib
{

}

- (void) initializeWithNames:(NSMutableArray *)_nameArray 
                 withMinSize:(CGSize)_minSize
                 withMaxRate:(float)_maxRate
             withActionCount:(int)_actionCount;
{
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    for (int i =0; i!= EYE_COUNT; ++i)
    {
        alphabets2[i] = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview: alphabets2[i]];
        
        
        alphabets[i] = [[UIImageView alloc] initWithFrame:CGRectZero];
        alphabets[i].contentMode = UIViewContentModeScaleAspectFill;
        alphabets[i].image = [UIImage imageNamed:[NSString stringWithFormat:@"eye_item_%d.png", i]];
        [self addSubview: alphabets[i]];
        
    }
    m_Width = _minSize.width;
    m_Height = _minSize.height;
    
    
    m_MaxDisc = 110.0f;
    m_MinRate = 1.0f;
    m_MinDisc = m_Width / 2;
    m_MaxRate = 3.0f;
    
    
    a = (m_MinRate - m_MaxRate)/(m_MaxDisc - m_MinDisc);
    b = m_MinRate - a * m_MaxDisc;
    
    [self resetPosition];
    
}

- (void)calFishEyeWithPosition:(CGPoint)position {
    
    float _disc;
    float _per;
    float _rate;
    
    for (int i = 0; i < EYE_COUNT; ++i){
        if (position.y > alphabets2[i].frame.origin.y && position.y <= alphabets2[i].frame.origin.y + m_Height ) {
            indexTmp = i;
            _per = (position.y - alphabets2[i].frame.origin.y) * m_MaxRate;
            break;
        }else if(i == 0){
            if(position.y < alphabets2[i].frame.origin.y){
                [self resetPosition];
                return;
            }
        }else if(i == EYE_COUNT - 1){
            if(position.y > alphabets2[i].frame.origin.y + alphabets2[i].frame.size.height){
                [self resetPosition];
                return;
            }
        }
    }
    
    if (YES) {
        [UIView beginAnimations: @"FishEyeAnimation" context: NULL];
        [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration: 0.3];
    }
    
    
    
    NSLog(@"i = %d", indexTmp);
    
    alphabets[indexTmp].frame = CGRectMake(0, position.y - _per, m_Width * m_MaxRate, m_Height * m_MaxRate);
    
    float offset = 110;
    
    for (int i = indexTmp - 1; i > -1; i--) {
        if (i < indexTmp - 3) {
            alphabets[i].frame = CGRectMake(0, alphabets2[indexTmp].center.y - m_Height * abs(i - indexTmp) - offset - m_Height, m_Width, m_Height);
        }else{
            _disc = abs(alphabets2[i].center.y - position.y );
            
            _rate = a * _disc + b;
            alphabets[i].frame = CGRectMake(0, alphabets[i + 1].frame.origin.y - m_Height * _rate, m_Width * _rate, m_Height * _rate);
        }
        
    }
    for (int i = indexTmp + 1; i < EYE_COUNT; i++) {
        if (i > indexTmp + 3) {
            alphabets[i].frame = CGRectMake(0, alphabets2[indexTmp].center.y + m_Width * abs(i - indexTmp) + offset, m_Width, m_Height);
        }else{
            _disc = abs(alphabets2[i].center.y - position.y );
                        
            _rate = a * _disc + b;  
            alphabets[i].frame = CGRectMake(0, alphabets[i - 1].frame.origin.y + alphabets[i - 1].frame.size.height, m_Width * _rate, m_Height * _rate);
        }        
    }
    if (YES) {
        [UIView commitAnimations];
    }
//    
//    if (index != indexTmp &&[selectionDelegate respondsToSelector: @selector(indexAt:withString:andpoint:)])
//    {
//        index = indexTmp;
//        NSString *  _c = [cAlphaString substringWithRange: NSMakeRange(index, 1)];
//        [selectionDelegate indexAt : index withString:_c andpoint:position];
//    }

}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch * _touch = [touches anyObject];
    
    CGPoint lastPoint = [_touch locationInView: self];
    
    [self calFishEyeWithPosition:lastPoint];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resetPosition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
        
//    if ([selectionDelegate respondsToSelector: @selector(endMove)])
//    {
//        [selectionDelegate endMove];
//    }
    [self resetPosition];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * _touch = [touches anyObject];
    
    CGPoint lastPoint = [_touch locationInView: self];   
    
    [self calFishEyeWithPosition:lastPoint];
}


@end
