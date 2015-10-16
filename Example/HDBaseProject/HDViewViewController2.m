//
//  HDViewViewController2.m
//  HDBaseProject
//
//  Created by Harry on 15/10/15.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "HDViewViewController2.h"

@interface HDViewViewController2 ()

@end

@implementation HDViewViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"列表";
    
    [self addRefreshView];
    [self addLoadMoreView];
}

- (void)requestData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.pageIndex == 0) {
            [self.dataArr removeAllObjects];
            
            for (int i=0; i<10; i++) {
                [self.dataArr addObject:@"111"];
            }
        }
        else{
            for (int i=0; i<10; i++) {
                [self.dataArr addObject:@"111"];
            }
        }
        
        
        [self refreshEnd];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
