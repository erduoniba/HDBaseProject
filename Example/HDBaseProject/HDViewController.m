//
//  HDViewController.m
//  HDBaseProject
//
//  Created by Harry on 09/15/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HDViewController.h"

#import "HDHTTPManager.h"

#import "HDViewViewController2.h"

@interface HDViewController ()

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [HDHTTPManager getWeixinJingxuanPageIndex:1 success:^(id responseObject) {
        
    } failure:^(NSString *errorResult) {
        
    }];
    
    self.title = @"asd";
    self.view.backgroundColor = [UIColor grayColor];
}
- (IBAction)nextAction:(id)sender {
    [self.navigationController pushViewController:[HDViewViewController2 new] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
