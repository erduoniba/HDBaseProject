//
//  HDViewController.m
//  HDBaseProject
//
//  Created by Harry on 09/15/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HDViewController.h"

#import "HTTPManager.h"

@interface HDViewController ()

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [HTTPManager getWeixinJingxuanPageIndex:1 success:^(id responseObject) {
        
    } failure:^(NSString *errorResult) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
