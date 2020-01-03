//
//  UIImageView+HDExtension.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/29.
//

#import "UIImageView+HDExtension.h"

#import <objc/runtime.h>

#import <AVFoundation/AVFoundation.h>

#if __has_include(<SDWebImage/SDImageCache.h>)
    #import <SDWebImage/SDImageCache.h>
#else
    #import "SDImageCache.h"
#endif


@interface UIImageView (_HDExtension)

@property (readwrite, nonatomic, strong) NSOperation *videoOperation;
@property (readwrite, nonatomic, strong) AVURLAsset *urlAsset;

@end

@implementation UIImageView (_HDExtension)

@dynamic videoOperation;
@dynamic urlAsset;

+ (NSOperationQueue *)video_sharedImageRequestOperationQueue {
    static NSOperationQueue *_video_sharedImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _video_sharedImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        _video_sharedImageRequestOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    });

    return _video_sharedImageRequestOperationQueue;
}

- (NSOperation *)videoOperation {
    return (NSOperation *)objc_getAssociatedObject(self, @selector(videoOperation));
}

- (void) setVideoOperation:(NSOperation *)videoOperation{
    objc_setAssociatedObject(self, @selector(videoOperation), videoOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AVURLAsset *)urlAsset{
    return (AVURLAsset *)objc_getAssociatedObject(self, @selector(urlAsset));
}

- (void)setUrlAsset:(AVURLAsset *)urlAsset{
    objc_setAssociatedObject(self, @selector(urlAsset), urlAsset, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UIImageView (HDExtension)

// This multiplier sets the font size based on the view bounds
static const CGFloat hd_FontResizingProportion = 0.42f;

#pragma mark -
#pragma mark - UIImageView+Reflect

- (void)hd_reflect
{
    CGRect frame = self.frame;
    frame.origin.y += (frame.size.height + 1);

    UIImageView *reflectionImageView = [[UIImageView alloc] initWithFrame:frame];
    self.clipsToBounds = TRUE;
    reflectionImageView.contentMode = self.contentMode;
    [reflectionImageView setImage:self.image];
    reflectionImageView.transform = CGAffineTransformMakeScale(1.0, -1.0);

    CALayer *reflectionLayer = [reflectionImageView layer];

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = reflectionLayer.bounds;
    gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor clearColor] CGColor],
                            (id)[[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] CGColor], nil];

    gradientLayer.startPoint = CGPointMake(0.5,0.5);
    gradientLayer.endPoint = CGPointMake(0.5,1.0);
    reflectionLayer.mask = gradientLayer;

    [self.superview addSubview:reflectionImageView];
}


#pragma mark -
#pragma mark - UIImageView+Letter
- (void)hd_setImageWithString:(NSString *)string {
    [self hd_setImageWithString:string color:nil circular:NO textAttributes:nil];
}

- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color {
    [self hd_setImageWithString:string color:color circular:NO textAttributes:nil];
}

- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular {
    [self hd_setImageWithString:string color:color circular:isCircular textAttributes:nil];
}

- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName {
    [self hd_setImageWithString:string color:color circular:isCircular textAttributes:@{
                                                                                        NSFontAttributeName:[self hd_fontForFontName:fontName],
                                                                                        NSForegroundColorAttributeName: [UIColor whiteColor]
                                                                                        }];
}

- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {
    if (!textAttributes) {
        textAttributes = @{
                           NSFontAttributeName: [self hd_fontForFontName:nil],
                           NSForegroundColorAttributeName: [UIColor whiteColor]
                           };
    }

    NSMutableString *displayString = [NSMutableString stringWithString:@""];

    NSMutableArray *words = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];

    //
    // Get first letter of the first and last word
    //
    if ([words count]) {
        NSString *firstWord = [words firstObject];
        if ([firstWord length]) {
            // Get character range to handle emoji (emojis consist of 2 characters in sequence)
            NSRange firstLetterRange = [firstWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
            [displayString appendString:[firstWord substringWithRange:firstLetterRange]];
        }

        if ([words count] >= 2) {
            NSString *lastWord = [words lastObject];

            while ([lastWord length] == 0 && [words count] >= 2) {
                [words removeLastObject];
                lastWord = [words lastObject];
            }

            if ([words count] > 1) {
                // Get character range to handle emoji (emojis consist of 2 characters in sequence)
                NSRange lastLetterRange = [lastWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
                [displayString appendString:[lastWord substringWithRange:lastLetterRange]];
            }
        }
    }

    UIColor *backgroundColor = color ? color : [self hd_letter_randomColor];

    self.image = [self hd_imageSnapshotFromText:[displayString uppercaseString] backgroundColor:backgroundColor circular:isCircular textAttributes:textAttributes];
}

#pragma mark - Helpers

- (UIFont *)hd_fontForFontName:(NSString *)fontName {

    CGFloat fontSize = CGRectGetWidth(self.bounds) * hd_FontResizingProportion;
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

- (UIColor *)hd_letter_randomColor {

    float red = 0.0;
    while (red < 0.1 || red > 0.84) {
        red = drand48();
    }

    float green = 0.0;
    while (green < 0.1 || green > 0.84) {
        green = drand48();
    }

    float blue = 0.0;
    while (blue < 0.1 || blue > 0.84) {
        blue = drand48();
    }

    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (UIImage *)hd_imageSnapshotFromText:(NSString *)text backgroundColor:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes {

    CGFloat scale = [UIScreen mainScreen].scale;

    CGSize size = self.bounds.size;
    if (self.contentMode == UIViewContentModeScaleToFill ||
        self.contentMode == UIViewContentModeScaleAspectFill ||
        self.contentMode == UIViewContentModeScaleAspectFit ||
        self.contentMode == UIViewContentModeRedraw)
    {
        size.width = floorf(size.width * scale) / scale;
        size.height = floorf(size.height * scale) / scale;
    }

    UIGraphicsBeginImageContextWithOptions(size, NO, scale);

    CGContextRef context = UIGraphicsGetCurrentContext();

    if (isCircular) {
        //
        // Clip context to a circle
        //
        CGPathRef path = CGPathCreateWithEllipseInRect(self.bounds, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }

    //
    // Fill background of context
    //
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));

    //
    // Draw text in the context
    //
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    CGRect bounds = self.bounds;

    [text drawInRect:CGRectMake(bounds.size.width/2 - textSize.width/2,
                                bounds.size.height/2 - textSize.height/2,
                                textSize.width,
                                textSize.height)
      withAttributes:textAttributes];

    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return snapshot;
}


#pragma mark -
#pragma mark - UIImageView+VideoFirstImage

- (void)hd_setVoideWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage{

    if (self.videoOperation) {
        [self.videoOperation cancel];
    }

    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
    if (cacheImage) {
        self.image = cacheImage;
        return ;
    }

    self.videoOperation = [[NSOperation alloc] init];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        __weak __typeof(self)weakSelf = self;
        [self.videoOperation setCompletionBlock:^{

            __strong __typeof(weakSelf)strongSelf = weakSelf;

            strongSelf.urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];//

            //获取视频时长，单位：秒
            NSLog(@"%llu",strongSelf.urlAsset.duration.value / strongSelf.urlAsset.duration.timescale);
            AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:strongSelf.urlAsset];
            generator.appliesPreferredTrackTransform = YES;
            NSError *error = nil;
            CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:NULL error:&error];
            UIImage *image = [UIImage imageWithCGImage: img];

            if (!image) {
                image = placeholderImage;
            }
            else{
                [[SDImageCache sharedImageCache] storeImage:image forKey:url.absoluteString toDisk:YES completion:^{

                }];
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.image = image;
            });

        }];

    });

    [[[self class] video_sharedImageRequestOperationQueue] addOperation:self.videoOperation];
}


#pragma mark -
#pragma mark - UIImageView+BetterFace

#define GOLDEN_RATIO (0.618)
static CIDetector *hd_detector;

char detectorKey;
- (void)setHd_detector:(CIDetector *)detector{
    objc_setAssociatedObject(self,
                             &detectorKey,
                             detector,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CIDetector *)hd_detector
{
    return objc_getAssociatedObject(self, &detectorKey);
}

- (void)hd_setBetterFaceImage:(UIImage *)image performance:(BOOL)performance
{
    self.image = image;
    [self hd_faceDetect:image performance:performance];
}

- (void)hd_faceDetect:(UIImage *)aImage performance:(BOOL)performance
{
    dispatch_queue_t queue = dispatch_queue_create("com.croath.betterface.queue", NULL);
    dispatch_async(queue, ^{
        CIImage* image = aImage.CIImage;
        if (image == nil) { // just in case the UIImage was created using a CGImage revert to the previous, slower implementation
            image = [CIImage imageWithCGImage:aImage.CGImage];
        }
        if (hd_detector == nil) {
            NSDictionary  *opts = [NSDictionary dictionaryWithObject:performance ? CIDetectorAccuracyLow : CIDetectorAccuracyHigh
                                                              forKey:CIDetectorAccuracy];
            hd_detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                             context:nil
                                             options:opts];
        }

        NSArray* features = [hd_detector featuresInImage:image];

        if ([features count] == 0) {
            NSLog(@"no faces");
            dispatch_async(dispatch_get_main_queue(), ^{
                [[self hd_imageLayer] removeFromSuperlayer];
            });
        } else {
            NSLog(@"succeed %lu faces", (unsigned long)[features count]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hd_markAfterFaceDetect:features
                                        size:CGSizeMake(CGImageGetWidth(aImage.CGImage),
                                                        CGImageGetHeight(aImage.CGImage))];
            });
        }
    });
}

-(void)hd_markAfterFaceDetect:(NSArray *)features size:(CGSize)size{
    CGRect fixedRect = CGRectMake(MAXFLOAT, MAXFLOAT, 0, 0);
    CGFloat rightBorder = 0, bottomBorder = 0;
    for (CIFaceFeature *f in features){
        CGRect oneRect = f.bounds;
        oneRect.origin.y = size.height - oneRect.origin.y - oneRect.size.height;

        fixedRect.origin.x = MIN(oneRect.origin.x, fixedRect.origin.x);
        fixedRect.origin.y = MIN(oneRect.origin.y, fixedRect.origin.y);

        rightBorder = MAX(oneRect.origin.x + oneRect.size.width, rightBorder);
        bottomBorder = MAX(oneRect.origin.y + oneRect.size.height, bottomBorder);
    }

    fixedRect.size.width = rightBorder - fixedRect.origin.x;
    fixedRect.size.height = bottomBorder - fixedRect.origin.y;

    CGPoint fixedCenter = CGPointMake(fixedRect.origin.x + fixedRect.size.width / 2.0,
                                      fixedRect.origin.y + fixedRect.size.height / 2.0);
    CGPoint offset = CGPointZero;
    CGSize finalSize = size;
    if (size.width / size.height > self.bounds.size.width / self.bounds.size.height) {
        //move horizonal
        finalSize.height = self.bounds.size.height;
        finalSize.width = size.width/size.height * finalSize.height;
        fixedCenter.x = finalSize.width / size.width * fixedCenter.x;
        fixedCenter.y = finalSize.width / size.width * fixedCenter.y;

        offset.x = fixedCenter.x - self.bounds.size.width * 0.5;
        if (offset.x < 0) {
            offset.x = 0;
        } else if (offset.x + self.bounds.size.width > finalSize.width) {
            offset.x = finalSize.width - self.bounds.size.width;
        }
        offset.x = - offset.x;
    } else {
        //move vertical
        finalSize.width = self.bounds.size.width;
        finalSize.height = size.height/size.width * finalSize.width;
        fixedCenter.x = finalSize.width / size.width * fixedCenter.x;
        fixedCenter.y = finalSize.width / size.width * fixedCenter.y;

        offset.y = fixedCenter.y - self.bounds.size.height * (1-GOLDEN_RATIO);
        if (offset.y < 0) {
            offset.y = 0;
        } else if (offset.y + self.bounds.size.height > finalSize.height){
            offset.y = finalSize.height = self.bounds.size.height;
        }
        offset.y = - offset.y;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        CALayer *layer = [self hd_imageLayer];
        layer.frame = CGRectMake(offset.x,
                                 offset.y,
                                 finalSize.width,
                                 finalSize.height);
        layer.contents = (id)self.image.CGImage;
    });
}

- (CALayer *)hd_imageLayer {
    for (CALayer *layer in [self.layer sublayers]) {
        if ([[layer name] isEqualToString:@"BETTER_LAYER_NAME"]) {
            return layer;
        }
    }

    CALayer *layer = [CALayer layer];
    [layer setName:@"BETTER_LAYER_NAME"];
    layer.actions = @{@"contents": [NSNull null],
                      @"bounds": [NSNull null],
                      @"position": [NSNull null]};
    [self.layer addSublayer:layer];
    return layer;
}

@end
