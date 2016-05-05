//
//  ZMWAssistiveTouchView.m
//  TeaLeaves
//
//  Created by 张美文 on 16/4/23.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ZMWAssistiveTouchView.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@interface ZMWAssistiveTouchView()
{
    UILabel *_label;
}
@end

@implementation ZMWAssistiveTouchView

static ZMWAssistiveTouchView *_touchView;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _touchView = [super allocWithZone:zone];
    });
    return _touchView;
}

+ (instancetype)sharedZMWAssistiveTouchView{
    if (_touchView) {
        return _touchView;
    }
    return nil;
}


+ (instancetype)sharedZMWAssistiveTouchViewCGRect:(CGRect)frame titleName:(NSString *)title
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _touchView = [[self alloc] initWithFrame:frame titleName:title];
    });
    return _touchView;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _touchView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame titleName:(NSString *)name
{
    if(self = [super initWithFrame:frame])
    {
        CGFloat radius = 0;
        CGRect newFrame = frame;
        if (frame.size.width < frame.size.height) {
            radius = frame.size.width*0.5;
            newFrame.size.height = frame.size.width;
        }else{
            radius = frame.size.height*0.5;
            newFrame.size.width = frame.size.height;
        }
        self.frame = newFrame;
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        self.windowLevel = UIWindowLevelAlert;
        self.rootViewController = [[UIViewController alloc] init];
        [self makeKeyAndVisible];

        _label = [[UILabel alloc]initWithFrame:(CGRect){0, 0,frame.size.width, frame.size.height}];
        _label.text = name;
        _label.textColor = [UIColor whiteColor];
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor lightGrayColor];
        _label.alpha = 0.3;
        (name.length > 2)?(_label.font = [UIFont fontWithName:@"DBLCDTempBlack"  size:17]):(_label.font = [UIFont fontWithName:@"DBLCDTempBlack"  size:23]);
        [self addSubview:_label];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
        
        self.panGesture = pan;
    }
    return self;
}

- (void)setName:(NSString *)name{
    _name = name;
    _label.text = name;
}

-(void)locationChange:(UIPanGestureRecognizer*)p
{
    CGPoint panPoint = [p locationInView:[[UIApplication sharedApplication] keyWindow]];
    if(p.state == UIGestureRecognizerStateBegan)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];
        _label.alpha = 0.8;

    }
    else if (p.state == UIGestureRecognizerStateEnded)
    {
        [self performSelector:@selector(changeColor) withObject:nil afterDelay:2.0];
    }
    if(p.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
        if(panPoint.x <= kScreenWidthTouch/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeightTouch-HEIGHT/2-40 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeightTouch-HEIGHT/2);
                }];
            }
            else if (panPoint.x < WIDTH/2+15 && panPoint.y > kScreenHeightTouch-HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, kScreenHeightTouch-HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y < HEIGHT/2 ? HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, pointy);
                }];
            }
        }
        else if(panPoint.x > kScreenWidthTouch/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x < kScreenWidthTouch-WIDTH/2-20 )
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeightTouch-40-HEIGHT/2 && panPoint.x < kScreenWidthTouch-WIDTH/2-20)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeightTouch-HEIGHT/2);
                }];
            }
            else if (panPoint.x > kScreenWidthTouch-WIDTH/2-15 && panPoint.y < HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidthTouch-WIDTH/2, HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y > kScreenHeightTouch-HEIGHT/2 ? kScreenHeightTouch-HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidthTouch-WIDTH/2, pointy);
                }];
            }
        }
    }
}

-(void)click:(UITapGestureRecognizer*)t
{
    _label.alpha = 0.8;
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:2.0];
    if(_assistiveDelegate && [_assistiveDelegate respondsToSelector:@selector(ZMWAssistiveTouchAction:)])
    {
        [_assistiveDelegate ZMWAssistiveTouchAction:self];
    }
}

-(void)changeColor
{
    [UIView animateWithDuration:1.5 animations:^{
        _label.alpha = 0.3;

    }];
}

@end
