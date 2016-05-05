//
//  ViewController.m
//  ZMWAssistiveTouchView
//
//  Created by 张美文 on 16/5/5.
//  Copyright © 2016年 walter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [ZMWAssistiveTouchView sharedZMWAssistiveTouchView].navigationController = self.navigationController;
}

@end
