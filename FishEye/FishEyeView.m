//
//  FishEyeView.m
//  FishEyeDemo
//
//  Created by haiwei li on 11-11-22.
//  Copyright (c) 2011年 13awan. All rights reserved.
//

#import "FishEyeView.h"



@interface FishEyeView (hide)

- (void)reSetPosition;

@end

@implementation FishEyeView (hide)

- (void)reSetPosition{
    
    int count = eyeViews.count;
    float viewW = m_Width * count;
    startX = (self.frame.size.width - viewW) / 2;
    
    [UIView beginAnimations: @"FishEyeAnimation" context: NULL];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 0.3];
    
    UIImageView * _imgTmp;
    for (int i = 0; i < count; ++i){
        
        _imgTmp = [eyeViews objectAtIndex:i];
        _imgTmp.frame = CGRectMake(startX + i * m_Width, 0, m_Width, m_Height);
    }
    
    [UIView commitAnimations];
}

@end


@implementation FishEyeView

- (void)dealloc{
    
    if (eyeViews) {
        for (UIImageView * imgView in eyeViews) {
            [imgView release];
        }
    }
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        horizontal = (frame.size.width > frame.size.height);
        
    }
    return self;
}

- (void) awakeFromNib
{
    horizontal = (self.frame.size.width > self.frame.size.height);
}

- (void) initializeWithNames:(NSMutableArray *)_nameArray 
                 withMinSize:(CGSize)_minSize
                 withMaxRate:(float)_maxRate
             withActionCount:(int)_actionCount;
{
    self.backgroundColor = [UIColor clearColor];
    
    int count = _nameArray.count;
    
    m_Width = _minSize.width;
    m_Height = _minSize.height;
    
    eyeViewsHide = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; ++i) {
        UIImageView * _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_Width, m_Height)];
        _imageView.image = [UIImage imageNamed:[_nameArray objectAtIndex:i]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [eyeViewsHide addObject:_imageView];
        [self addSubview:_imageView];
    }
    
    
    eyeViews = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; ++i) {
        UIImageView * _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, m_Width, m_Height)];
        _imageView.image = [UIImage imageNamed:[_nameArray objectAtIndex:i]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [eyeViews addObject:_imageView];
        [self addSubview:_imageView];
    }
    
    m_MaxRate = _maxRate;    
    m_MinRate = 1.0f;
    a = (m_MinRate - m_MaxRate)/(4 * m_Width);
    b = m_MinRate - a * 4 * m_Width;
    
    
    [self reSetPosition];
    
    for (int i = 0; i < count; ++i) {
        UIImageView * _imageView = [eyeViews objectAtIndex:i];
        UIImageView * _imageViewHide = [eyeViewsHide objectAtIndex:i];
        _imageViewHide.frame = _imageView.frame;
    }
}

- (void)calFishEyeWithPosition:(CGPoint)position {
    
    float _disc;
    float _per;
    int count = eyeViews.count;
    int indexTmp;
    
    UIImageView * _imageView;
    UIImageView * _imageViewHide;
    
    for (int i = 0; i < count; ++i){
        
        _imageView = [eyeViews objectAtIndex:i];
        _imageViewHide = [eyeViewsHide objectAtIndex:i];
        
        if (position.x > _imageViewHide.frame.origin.x && position.x <= _imageViewHide.frame.origin.x + m_Width ) {
            indexTmp = i;
            _per = (position.x - _imageViewHide.frame.origin.x) * m_MaxRate;
            break;
        }else if(i == 0){
            if(position.x < _imageViewHide.frame.origin.x){
                [self reSetPosition];
                return;
            }
        }else if(i == count - 1){
            if(position.x > _imageViewHide.frame.origin.x + _imageViewHide.frame.size.height){
                [self reSetPosition];
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
    _imageView = [eyeViews objectAtIndex:indexTmp];
    _imageView.frame = CGRectMake(0, position.x - _per, labelWidth, FONT_SIZE_WITH_SPACE * m_MaxRate);
    
    float offset = 55;
    
    for (int i = indexTmp - 1; i > -1; i--) {
        _imageView = [eyeViews objectAtIndex:i];
        if (i < indexTmp - 3) {
           
            _imageView.frame = CGRectMake(0, _imageViewHide[indexTmp].center.y - FONT_SIZE_WITH_SPACE * abs(i - indexTmp) - offset - FONT_SIZE_WITH_SPACE, labelWidth, FONT_SIZE_WITH_SPACE);
        }else{
            _disc = abs(_imageViewHide.center.y - position.x );
            
            _imageView.m_Disc = _disc;
            _imageView.m_Rate = a * _imageView.m_Disc + b;
            
            int fontSize = FONT_SIZE_WITH_SPACE * _imageView.m_Rate;   

            _imageView.frame = CGRectMake(0, alphabets[i + 1].frame.origin.x - fontSize, labelWidth, fontSize);
        }
        
    }
    for (int i = indexTmp + 1; i < count; i++) {
        if (i > indexTmp + 3) {
            alphabets[i].font = [UIFont boldSystemFontOfSize:FONT_SIZE_WITH_SPACE];
            alphabets[i].frame = CGRectMake(0, _imageViewHide[indexTmp].center.y + FONT_SIZE_WITH_SPACE * abs(i - indexTmp) + offset, labelWidth, FONT_SIZE_WITH_SPACE);
        }else{
            _disc = abs(_imageViewHide.center.y - position.x );
            
            alphabets[i].m_Disc = _disc;
            alphabets[i].m_Rate = a * alphabets[i].m_Disc + b;
            int fontSize = FONT_SIZE_WITH_SPACE * alphabets[i].m_Rate;   
            alphabets[i].font = [UIFont boldSystemFontOfSize:fontSize];
            alphabets[i].frame = CGRectMake(0, alphabets[i - 1].frame.origin.x + alphabets[i - 1].frame.size.height, labelWidth, fontSize);
        }        
    }
    if (YES) {
        [UIView commitAnimations];
    }
    
    if (index != indexTmp &&[selectionDelegate respondsToSelector: @selector(indexAt:withString:andpoint:)])
    {
        index = indexTmp;
        NSString *  _c = [cAlphaString substringWithRange: NSMakeRange(index, 1)];
        [selectionDelegate indexAt : index withString:_c andpoint:position];
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch * _touch = [touches anyObject];
    
    CGPoint lastPoint = [_touch locationInView: self];
    
    [self calFishEyeWithPosition:lastPoint];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reSetPosition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
        
//    if ([selectionDelegate respondsToSelector: @selector(endMove)])
//    {
//        [selectionDelegate endMove];
//    }
    [self reSetPosition];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * _touch = [touches anyObject];
    
    CGPoint lastPoint = [_touch locationInView: self];   
    
    [self calFishEyeWithPosition:lastPoint];
}


@end
