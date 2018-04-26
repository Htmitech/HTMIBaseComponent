//
//  HTMIViewController.m
//  HTMIBaseComponent
//
//  Created by lqwang521 on 02/02/2018.
//  Copyright (c) 2018 lqwang521. All rights reserved.
//

#import "HTMIViewController.h"
#import "NSString+Hash.h"
#import "UIFont+HTMIFont.h"
#import "NSDictionary+LocaleLog.h"
#import "NSArray+LocaleLog.h"


@interface HTMIViewController ()

@end

@implementation HTMIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *test =  [NSDictionary dictionaryWithObjectsAndKeys:@"test1",@"key1",@"test2",@"key1", nil];
    [test descriptionWithLocale:nil];
    NSLog(@"%@",test);
    
    NSArray *array =  [NSArray arrayWithObjects:@"test1",@"key1",@"test2",@"key1", nil];
    [array descriptionWithLocale:nil];
    NSLog(@"%@",array);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

@end
