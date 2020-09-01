//
//  BaseViewController.m
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDBaseViewController.h"

#import "HDGlobalVariable.h"
#import "HDGlobalMethods.h"
#import "UIView+Helpers.h"

@interface HDBaseViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isCanSideBack;

@property (nonatomic, strong) UIActivityIndicatorView *aiView;
@property (nonatomic, strong) HDReminderView *hdReminderView;

@end

@implementation HDBaseViewController

static UIColor *backgroundColor;
static NSString *backImageName;
static UIEdgeInsets backImageEdgeInsets;

+ (void)setBackgroundColor:(UIColor *)color{
    backgroundColor = color;
}

+ (void)setBackImageName:(NSString *)imageName{
    backImageName = imageName;
}

+ (void)setBackImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    backImageEdgeInsets = imageEdgeInsets;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    if (backgroundColor) {
        self.view.backgroundColor = backgroundColor;
    }

    //默认开启滑动返回
    _isCanSideBack = YES;
    NSArray *viewControllers = self.navigationController.viewControllers;
    //不是根VC自动加上返回
    if (viewControllers.count > 1) {
        [self showBackBtn];
    }
    else{
        [self hideBackBtn];
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HDReminderView *)hdReminderView {
    if (!_hdReminderView) {
        _hdReminderView = [[HDReminderView alloc] initWithFrame:self.view.bounds];
        _hdReminderView.userInteractionEnabled = YES;
        [self.view addSubview:_hdReminderView];
        [_hdReminderView centerAlignForSuperview];
    }
    return _hdReminderView;
}

-(UIWindow *)getKeyWindow {
    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            return window;
        }
    }
    return nil;
}

- (AppDelegate *)getAppDelegate{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}

- (UIActivityIndicatorView *)aiView {
    if (!_aiView) {
        _aiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _aiView;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count <= 1 || !_isCanSideBack) {
        return NO;
    }
    return YES;
}

- (void)setCustomTitle:(NSString *)title {
    [self setCustomTitle:title color:UIColorHexFromRGB(0x030303)];
}

- (void)setCustomTitle:(NSString *)title color:(UIColor *)color {
    if (title.length > 10) {
        title = [NSString stringWithFormat:@"%@...", [title substringWithRange:NSMakeRange(0, 10)]];
    }

    UILabel *titleLabel = [HDGlobalMethods createLabel:CGRectMake(0, 0, 120, 20)
                                                 title:title
                                                  font:[UIFont systemFontOfSize:17]
                                               textCol:color];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - 左右自定义按钮
- (UIBarButtonItem *)createBarBackButtonItem:(id)target
                                    selector:(SEL)action
{
    UIImage * img = [UIImage imageNamed:backImageName];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    [button setImage:img forState:UIControlStateNormal];
    [button setImageEdgeInsets:backImageEdgeInsets];
    [button setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [button titleLabel];
    [titleLabel sizeToFit];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return barButtonItem;
}

- (void)hideBackBtn
{
    self.navigationItem.leftBarButtonItems = nil;
    static UIView *clearView = nil;
    if(clearView == nil)
    {
        clearView = [UIView new];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearView];
}

- (void)showBackBtn
{
    [self showBackBtnWithSelector:@selector(gotoBack)];
}

- (void)showBackBtnWithSelector:(SEL)selector
{
    UIBarButtonItem *backItem = [self createBarBackButtonItem:self selector:selector];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
}

- (void)showLeftItemWithTitle:(NSString *)title selector:(SEL) selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [btn setTitleColor:[self themeColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 50, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)showLeftItemWithImage:(UIImage *)image selector:(SEL) selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 32, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)showLeftActivityView {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.aiView];
    self.navigationItem.leftBarButtonItems = @[item];
    [self.aiView startAnimating];
}

- (void)hideLeftActivityView {
    [self.aiView stopAnimating];
}

-(void) showRightItemWithTitle:(NSString *) title selector:(SEL) selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    [btn setTitleColor:[self themeColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 50, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showRightItemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:titleColor ? : [UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:highlightColor ? : [UIColor blackColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, 44, 32)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showRightBarButtonWithImage:(UIImage *)image selector:(SEL)selector
{
    if (image)
    {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (UIButton *)showRightBarButtonWithImage:(UIImage *)image hImage:(UIImage *)hImage selector:(SEL)selector
{
    UIButton *mRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [mRightBtn setAutoresizesSubviews:YES];
    [mRightBtn setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [mRightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [mRightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];
    self.navigationItem.rightBarButtonItems = @[barRButtonItem];
    [mRightBtn setImage:image forState:UIControlStateNormal];
    if (hImage) {
        [mRightBtn setImage:hImage forState:UIControlStateHighlighted];
    }
    return mRightBtn;
}

- (void)showRightItemFixedOffsetWithTitle:(NSString *)itemTitle titleColor:(UIColor *)titleColor highlightTitleColor:(UIColor *)highlightColor itemSize:(CGSize)itemSize selector:(SEL)selector
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, itemSize.width, itemSize.height)];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:itemTitle forState:UIControlStateNormal];
    [rightBtn setTitleColor:titleColor forState:UIControlStateNormal];
    if (highlightColor)
    {
        [rightBtn setTitleColor:highlightColor forState:UIControlStateHighlighted];
    }
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixItem.width = -20.0f;
    
    self.navigationItem.rightBarButtonItems = @[fixItem,rightItem];
}

- (NSArray <UIButton *> *)showRightBarButtonWithImage:(UIImage *)image selector:(SEL)selector
                             image2:(UIImage *)image2 selector2:(SEL)selector2 {
    UIButton *mRightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [mRightBtn setImage:image forState:UIControlStateNormal];
    [mRightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];
 
    UIButton *mRightBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [mRightBtn2 setImage:image2 forState:UIControlStateNormal];
    [mRightBtn2 addTarget:self action:selector2 forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barRButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn2];
    
    UIBarButtonItem *fixItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixItem.width = 15.0f;
    
    self.navigationItem.rightBarButtonItems = @[barRButtonItem2, fixItem, barRButtonItem];
    return @[mRightBtn, mRightBtn2];
}

- (void)leftAction{
    
}

- (void)gotoBack {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if ([self presentingViewController]) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)hidePopGestureRecognizer {
    //关闭ios右滑返回
    _isCanSideBack = NO;
}

//设置下横线隐藏
- (UIImageView *)setUnderLineHidden:(BOOL)hidden
{
    if (self.navigationController) {
        UIImageView *line = [self navigationBarLine:self.navigationController.navigationBar];
        line.hidden = hidden;
        return line;
    }
    return nil;
}

- (UIImageView *)navigationBarLine:(UIView *)view{
    // 符合条件返回控件
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    // 递归查找
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self navigationBarLine:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (UIColor *)themeColor {
    return [UIColor whiteColor];
}

#pragma mark - 提示相关的代码
- (void)showReminderViewWihtType:(HDReminderType)reminderType {
    [self.hdReminderView setReminderType:reminderType];
    self.hdReminderView.hidden = NO;
    [self.view bringSubviewToFront:self.hdReminderView];
}

- (void)showReminderViewWithText:(NSString *)text {
    [self.hdReminderView customReminder:text];
    self.hdReminderView.hidden = NO;
    [self.view bringSubviewToFront:self.hdReminderView];
}

- (void)hideReminderView {
    self.hdReminderView.hidden = YES;
}

@end
