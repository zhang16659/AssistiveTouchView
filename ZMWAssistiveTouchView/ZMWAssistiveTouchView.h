//
//  ZMWAssistiveTouchView.h
//  TeaLeaves
//
//  Created by 张美文 on 16/4/23.
//  Copyright © 2016年 walter. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidthTouch [[UIScreen mainScreen] bounds].size.width
#define kScreenHeightTouch [[UIScreen mainScreen] bounds].size.height

@protocol ZMWAssistiveTouchDelegate;
@interface ZMWAssistiveTouchView : UIWindow

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property(nonatomic,unsafe_unretained)id<ZMWAssistiveTouchDelegate> assistiveDelegate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UINavigationController *navigationController;

+ (instancetype)sharedZMWAssistiveTouchView;
+ (instancetype)sharedZMWAssistiveTouchViewCGRect:(CGRect)frame titleName:(NSString *)title;
@end

@protocol ZMWAssistiveTouchDelegate <NSObject>
@optional
/**
 *  悬浮窗点击事件
 *
 *  @param view self
 */
-(void)ZMWAssistiveTouchAction:(ZMWAssistiveTouchView *)view;

@end
