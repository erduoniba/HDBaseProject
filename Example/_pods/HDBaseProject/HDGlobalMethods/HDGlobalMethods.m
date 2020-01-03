//
//  GlobalMethods.m
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDGlobalMethods.h"

#import "HDGlobalVariable.h"

#if __has_include(<HDBaseProject/UIColor+HDExtension.h>)
    #import <HDBaseProject/UIColor+HDExtension.h>
#else
    #import "UIColor+HDExtension.h"
#endif

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import <MediaPlayer/MediaPlayer.h>

@implementation HDGlobalMethods

+ (NSString *)getDateString:(NSDate *)date withFormat:(NSString*)format
{
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"GMT+8:00"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:tzGMT];
    [dateFormatter setDateFormat:format];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

//时间转换 传人时间戳和样式字符串 如@"YYYY-MM-dd HH:mm"
+ (NSString *)stringFromTimeIntervalSince1970:(CGFloat)time dateFormat:(NSString *)format
{
    if (time <= 0) {
        return @"";
    }
    //设置时间显示格式:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    //时间戳转时间的方法
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}


+ (UIButton *)createButton:(CGRect)frame title:(NSString *)title font:(UIFont *)font textCol:(UIColor *)textColor{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:textColor forState:UIControlStateNormal];
    [bt setTitleColor:[textColor hd_colorByDarkeningColorWithValue:0.12] forState:UIControlStateHighlighted];
    [bt.titleLabel setFont:font];
    return bt;
}

+(UIButton *)createBackButton:(UIImage *)image1 hilight:(UIImage *)image2 {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *normalImg = image1;
    UIImage *hightLightImg = image2;
    [btn setImage:normalImg forState:UIControlStateNormal];
    [btn setImage:hightLightImg forState:UIControlStateHighlighted];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 0 + 30, 30.0f)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) {
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -11, 0, +11.0f);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2);
    }
    return btn;
}

+ (UILabel *)createLabel:(CGRect)frame title:(NSString *)title font:(UIFont *)font textCol:(UIColor *)textColor{
    UILabel *lb = [[UILabel alloc] initWithFrame:frame];
    lb.text = title;
    lb.font = font;
    lb.textColor = textColor;
    lb.numberOfLines = 0;
    return lb;
}

+ (CGSize)getSizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size{
    
    if (!string || string.length == 0) {
        
        return CGSizeZero;
    }else{
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string
                                                                             attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        return rect.size;
    }
}


+(CGSize)getTextRect:(NSString *)text fontsize:(int)fontsize maxWidth:(int)maxWidth
{
	//测量文本宽高
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontsize] forKey:NSFontAttributeName];
	NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
	
	CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
									 options:option
								  attributes:attributes
									 context:nil];
	return rect.size;
}

+(CGSize)getTextRect:(NSString *)text fontsize:(int)fontsize
{
	return [self getTextRect:text fontsize:fontsize maxWidth:MAXFLOAT];
}



static NSBundle *gsBundle = nil;
+ (NSBundle *)resourceBundle:(NSString *)bundleName{
    if (!gsBundle)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:bundleName
                                                         ofType:@"bundle"];
        gsBundle = [NSBundle bundleWithPath: path];
    }
    
    return gsBundle;
}
+ (UIImage *)imageNamed:(NSString *)name{
    UIImage * img;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
    {
        img = [UIImage imageNamed:name inBundle:[self resourceBundle:@"Resources"] compatibleWithTraitCollection:nil];
    }
    else
    {
        CGFloat scale_screen = [UIScreen mainScreen].scale;
        if (scale_screen >= 2)
        {
            if ([name rangeOfString:@"."].length >0)
            {
                
            }
            else
            {
                name = [name stringByAppendingString:@".png"];
            }
        }
        img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[self resourceBundle:@"Resources"] bundlePath],name]];
    }
    
    if (!img) {
        img = [UIImage imageNamed:name];
    }
    
    return img;
}


+ (NSString *)hd_md5Encrypt:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",r[i]];
    }
    
    return ret;
}

+ (NSString *)hd_aes128Encrypt:(NSString *)plainText key:(NSString *)key {
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        return [self hexStringForData:resultData];
    }
    free(buffer);
    return nil;
}

+ (NSString *)hd_aes128Decrypt:(NSString *)encryptText key:(NSString *)key {
    DLog(@"encryptText = %@, %@",encryptText, key);
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSData *data = [self dataForHexString:encryptText];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);

    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

//NSData 转换成 16进制小写字符串
+ (NSString *)hexStringForData:(NSData *)data {
    if (data == nil) {
        return nil;
    }
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    return hexString;
}

//16进制小写字符串 转换成 NSData
+ (NSData *)dataForHexString:(NSString *)hexString {
    if (hexString == nil) {
        return nil;
    }
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;

        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        }

        else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        }

        else if ('A' <= *ch && *ch <= 'F') {
            byte = *ch - 'A' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            }
            else if('A' <= *ch && *ch <= 'F')
            {
                byte += *ch - 'A' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}


/**
 *  通过经纬度获取该经纬度的地理信息
 *
 *  @param location        目标经纬度
 *  @param handlePlaceName 回调 经纬度对应的 地理信息
 */
+ (void )getPlaceNameWithLocation:(CLLocation *)location finish:(void (^)(NSString *))handlePlaceName{
    
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    
    if(location.coordinate.latitude > 0 && location.coordinate.longitude > 0){
        CLGeocoder *geo = [[CLGeocoder alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
                
                if ( error == nil && placemarks && [placemarks count] > 0){
                    
                    CLPlacemark *placeMark = [placemarks objectAtIndex:0];
                    NSDictionary *placeDic = placeMark.addressDictionary;
                    
                    NSMutableString *mString = [NSMutableString new];
                    if ([placeDic[@"City"] length] > 0) {
                        [mString appendString:placeDic[@"City"]];
                    }
                    if ([placeDic[@"SubLocality"] length] > 0) {
                        [mString appendString:placeDic[@"SubLocality"]];
                    }
                    if ([placeDic[@"Street"] length] > 0) {
                        [mString appendString:placeDic[@"Street"]];
                    }
            
                    if (mString.length == 0){
                        mString = [NSMutableString stringWithString:@"定位失败"];
                    }
                    
                    if (mString){
                        DLog(@"当前地理位置: %@", mString);
                    }
                    
                    handlePlaceName(mString);
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
            }];
            
        });
    }else{
        handlePlaceName(@"获取地理位置失败");
    }
}

/**
 *  通过经纬度获取该经纬度的地理信息
 *
 *  @param location        目标经纬度
 *  @param handlePlaceName 回调 经纬度对应的 城市名称
 */
+ (void )getCityNameWithLocation:(CLLocation *)location finish:(void (^)(NSString *))handlePlaceName{
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    
    if(location.coordinate.latitude > 0 && location.coordinate.longitude > 0){
        CLGeocoder *geo = [[CLGeocoder alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
                
                if ( error == nil && placemarks && [placemarks count] > 0){
                    
                    CLPlacemark *placeMark = [placemarks objectAtIndex:0];
                    NSDictionary *placeDic = placeMark.addressDictionary;
                    NSString *bmCityName = placeDic[@"City"];
                    if (!bmCityName){
                        bmCityName = placeMark.administrativeArea;
                    }
                    
                    if (bmCityName){
                        DLog(@"当前地理位置: %@", bmCityName);
                    }
                    
                    handlePlaceName(bmCityName);
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
            }];
            
        });
    }else{
        handlePlaceName(@"获取地理位置失败");
    }
}


+ (NSDateFormatter*) dateformatterForFormatter:(NSString*) formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return dateFormatter;
}

+ (BOOL) isImageTypeWithUrl:(NSString *)url{
    
    BOOL image = NO;
    
    if ([url containsString:@".png"] ||
        [url containsString:@".PNG"] ||
        [url containsString:@".jpg"] ||
        [url containsString:@".JPG"] ||
        [url containsString:@".jpeg"] ||
        [url containsString:@".JPEG"] ||
        [url containsString:@".bmp"] ||
        [url containsString:@".BMP"]) {
        image = YES;
    }
    
    return image;
}

+ (void)fFirstVideoFrame:(NSString *)path{
    
    // 1. 添加播放状态的监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 2. 截屏完成通知
    [nc addObserver:self selector:@selector(captureFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
    MPMoviePlayerController *mp = [[MPMoviePlayerController alloc]
                                   initWithContentURL:[NSURL fileURLWithPath:path]];
    [mp requestThumbnailImagesAtTimes:@[@(0.5)] timeOption:MPMovieTimeOptionNearestKeyFrame];
    [mp stop];
}

- (void)captureFinished:(NSNotification *)notification
{
    // 3. 通知得到图片,需要代理或者其他方式获取
    UIImage *image = notification.userInfo[MPMoviePlayerThumbnailImageKey];
    NSLog(@"%@", image);
}

+(UIImage *)getImage:(NSString *)videoURL{
    
    //视频地址
    NSURL *url = [[NSURL alloc] initWithString:videoURL];//initFileURLWithPath:videoURL] autorelease];
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];//
    
    //获取视频时长，单位：秒
    NSLog(@"%llu",urlAsset.duration.value/urlAsset.duration.timescale);
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:NULL error:&error];
    UIImage *image = [UIImage imageWithCGImage: img];
    
    if (!image) {
        image = GET_IMAGE_NAME(@"movie");
    }
    
    return image;
}

+ (void) lowQuailtyWithInputURL:(NSURL*)inputURL
                      outputURL:(NSURL*)outputURL
                   blockHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    session.shouldOptimizeForNetworkUse = YES;
    session.outputURL = outputURL;
    session.outputFileType = AVFileTypeQuickTimeMovie;
    [session exportAsynchronouslyWithCompletionHandler:^(void)
     {
         handler(session);
     }];
}

+ (NSString *)sha1:(NSString *)input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

//传2个字符串以及样式 返回一个NSMutableAttributedString
+ (NSMutableAttributedString *)hd_getNewColorStr:(NSString *)headStr
                                        headFont:(UIFont *)headFont
                                       headColor:(UIColor *)headColor
                                         lastStr:(NSString *)lastStr
                                        lastFont:(UIFont *)lastFont
                                       lastColor:(UIColor *)lastColor {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",headStr,lastStr]];
    [str addAttribute:NSForegroundColorAttributeName value:headColor range:NSMakeRange(0,headStr.length)];
    [str addAttribute:NSForegroundColorAttributeName value:lastColor range:NSMakeRange(headStr.length, lastStr.length)];
    [str addAttribute:NSFontAttributeName value:headFont range:NSMakeRange(0,headStr.length)];
    [str addAttribute:NSFontAttributeName value:lastFont range:NSMakeRange(headStr.length, lastStr.length)];
    return str;
}

@end
