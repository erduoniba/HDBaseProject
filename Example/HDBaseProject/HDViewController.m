//
//  HDViewController.m
//  HDBaseProject
//
//  Created by Harry on 09/15/2015.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "HDViewController.h"

#import "HDViewViewController2.h"

#import "HDLogDemo.h"

@interface HDViewController ()
{
    UILabel *lb;
}

@end

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    DDLogWarn(@"DDLogWarn");
    HDLogTest(@"tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt");
    HDLogTest2(@"tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt22");
    HDLogFileTest1(@"xxxxxxxxxxxxxxxx");
    HDLogFileTest2(@"xxxxxxxxxxxxxxxx22");
    
    self.title = @"asd";
    self.view.backgroundColor = [UIColor grayColor];
    
    UIColor *c1 = [UIColor colorWithHexAlphaString:@"0x11333333"];
    UIColor *c2 = [UIColor colorWithHexAlphaString:@"0x333333"];
    UIColor *c3 = [UIColor colorWithHexAlphaString:@"#11333333"];
    UIColor *c4 = [UIColor colorWithHexAlphaString:@"#333333"];

    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(100, 100, 200, 200);
    [bt setTitle:@"cook" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    bt.titleLabel.textColor = [UIColor orangeColor];
    bt.backgroundColor = [UIColor yellowColor];

    [bt hd_setTouchAreaInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
    [bt hd_setSoundNamed:@"mu.caf" forControlEvent:UIControlEventTouchUpInside];
    [bt addTarget:self action:@selector(actionTap:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:bt];

    UIImage *image = [UIImage imageNamed:@"l2.jpg"];
    image = [image hd_flipVertical];
    image = [image hd_flipVertical];
    image = [image hd_flipHorizontal];
    image = [image hd_flipHorizontal];
    
    image = [image hd_fixOrientation];
    image = [image hd_imageRotatedByDegrees:90];

    UIImage *image2 = [UIImage imageNamed:@"service_order"];
    image = [image hd_mergeImage:image2 mergeImageAtTop:YES];

    CGFloat smallValue = image.size.height;
    if (image.size.height > image.size.width) {
        smallValue = image.size.width;
    }

    image = [image hd_imageCroppedToRect:CGRectMake(0, 0, smallValue, smallValue)];
    image = [image hd_imageWithCornerRadius:smallValue / 2.0];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 350, 150, 150)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.view addSubview:imageView];

    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 600, 150, 150)];
    [imageView2 hd_setBetterFaceImage:image performance:YES];
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    imageView2.clipsToBounds = YES;
    imageView2.backgroundColor = [UIColor orangeColor];

    [self.view addSubview:imageView2];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIImage *img = [UIImage hd_captureWithView:self.view];
        NSLog(@"img : %@", [NSValue valueWithCGSize:img.size]);
    });

    lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 510, self.view.frame.size.width - 20, 90)];
    lb.numberOfLines = 0;
    lb.textColor = [UIColor whiteColor];
    lb.text = @"美居是美的集团面向消费者的官方应用，同时也是基于M-Smart系统推出的智能家电管理应用。通过美居，可以实现五大核心功能：1、家电管理：可将美的旗下全品类智能家电产品连接，各品类产品体验入口均一致，实现产品的智能管控一体化";
    lb.text = @"京东（股票代码：JD），中国自营式电商企业，创始人刘强东担任京东集团董事局主席兼首席执行官 [1]  。旗下设有京东商城、京东金融、拍拍网、京东智能、O2O及海外事业部等。2013年正式获得虚拟运营商牌照。2014年5月在美国纳斯达克证券交易所正式挂牌上市。 2016年6月与沃尔玛达成深度战略合作，1号店并入京东。";
    [lb hd_setColumnSpace:5];
    NSAttributedString *attString = [lb hd_setRowSpace:10];
    CGSize size = [lb hd_suggestSizeForAttributedString:attString width:lb.frame.size.width];
    lb.frame = CGRectMake(10, 510, self.view.frame.size.width - 20, size.height);

    
    lb.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lb];

    [HDSafeCollection hd_safeCollectionEnable:YES];
    [HDSafeCollection hd_safeCollectionLogEnable:YES];


//    NSArray *arr = @[@"2", @"3"];
//    NSString *ss = [arr objectAtIndex:10];
//
//    NSMutableArray *arrr = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
//    [arrr addObject:nil];
//    [arrr insertObject:@"1" atIndex:10];
//    [arrr removeObjectAtIndex:20];
//    [arrr replaceObjectAtIndex:1 withObject:nil];
//
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:@"1" forKey:@"xxx"];
//    dic[@"yy"] = nil;
//    dic[@"yyy"] = @"asdas";
//    [dic setObject:nil forKey:@"zz"];
//    [dic removeObjectForKey:@"xxxx"];
//
//
//    NSString *string = @"hello";
//    unichar charr = [string characterAtIndex:2];
//    NSString *ccc = [string substringWithRange:NSMakeRange(4, 4)];

//    NSString *sss = [NSString stringWithFormat:@"asda"];
//    NSString *ss = @"asda";
//    NSString *s1 = [NSString stringWithString:@"asda"];
//
//    NSMutableString *mString = [NSMutableString stringWithString:@"abc"];
//    [mString appendString:@"d"];
////    [mString appendString:nil];
//
//    [mString appendFormat:@"%@", @"f"];
//    [mString appendFormat:@"%@", nil];
//
//    [mString setString:@"xxxx"];
//    [mString setString:nil];
//
//    [mString insertString:@"ooo" atIndex:10];
//    [mString insertString:nil atIndex:0];
    
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
////        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
////        [self.view addSubview:view];
//
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;;
//    });
    
    
    
}

- (void)injected {
    lb.text = @"jj22j";
    NSLog(@"injected");
}

- (void)injected2 {
    lb.text = @"jjj222";
    NSLog(@"injected2");
}

- (void)backgroundAction {
    HDBaseViewController *vc = HDBaseViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)actionTap:(UIButton *)bt {
    NSLog(@"xx");
    [bt hd_shake:10 withDelta:15 speed:0.05 shakeDirection:HDShakedDirectionVertical];

    lb.textColor = [[UIColor whiteColor] hd_colorByDarkeningColorWithValue:0.2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        lb.textColor = [UIColor whiteColor];
    });
    
    [self backgroundAction];
    
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
