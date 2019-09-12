#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HDBaseProject.h"
#import "HDBaseCellViewModel.h"
#import "HDBaseModel.h"
#import "HDBasePresenter.h"
#import "HDBaseRepository.h"
#import "HDBaseRepositoryProtcol.h"
#import "HDBaseUITableViewCell.h"
#import "HDBaseUITableViewController.h"
#import "HDBaseUIWebViewController.h"
#import "HDBaseViewController.h"
#import "HDBaseViewControllers.h"
#import "HDReminderView.h"
#import "HDTableViewConverter.h"
#import "HDCategorys.h"
#import "NSCollection+HDExtension.h"
#import "NSObject+HDExtension.h"
#import "NSString+HDExtension.h"
#import "UIButton+HDExtension.h"
#import "UIColor+HDExtension.h"
#import "UIControl+HDExtension.h"
#import "UIControl+JKBlock.h"
#import "UIDevice+HDExtension.h"
#import "UIImage+HDExtension.h"
#import "UIImageView+HDExtension.h"
#import "UILabel+HDExtension.h"
#import "UITableView+HDExtension.h"
#import "UITextField+HDExtension.h"
#import "UITextView+HDExtension.h"
#import "UIView+HDExtension.h"
#import "UIView+Helpers.h"
#import "UIView+JKCustomBorder.h"
#import "HDCustomCache.h"
#import "HDDDLog.h"
#import "HDFPSLabel.h"
#import "HDFrameworkBundleImage.h"
#import "HDGlobalMethods.h"
#import "HDGlobalVariable.h"
#import "HDNetStatusManager.h"
#import "AFNetworkActivityLogger.h"
#import "HDError.h"
#import "HDNetworking.h"
#import "HDRequestConvertManager.h"
#import "HDRequestManagerConfig.h"
#import "TOActivityChrome.h"
#import "TOActivitySafari.h"
#import "TOWebViewController.h"
#import "UIImage+TOWebViewControllerIcons.h"

FOUNDATION_EXPORT double HDBaseProjectVersionNumber;
FOUNDATION_EXPORT const unsigned char HDBaseProjectVersionString[];

