//
//  BaseUITableViewCell.h
//  SecondHouseBroker
//
//  Created by Harry on 15-8-4.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDBaseUITableViewCell.h"

@interface HDBaseUITableViewCell ()

/**
 *  上横线
 */
@property (strong, nonatomic)  UIView *topLineView;

/**
 *  下横线,都是用来分隔cell的
 */
@property (strong, nonatomic)  UIView *bottomLineView;

@property (nonatomic, assign) CGFloat sizeOnePx;

@end

@implementation HDBaseUITableViewCell

+ (CGFloat)cellHeightWithCellData:(id)cellData{
    return [self cellHeightWithCellData:cellData boundWidth:[UIScreen mainScreen].bounds.size.width];
}

+ (CGFloat)cellHeightWithCellData:(id)cellData boundWidth:(CGFloat)width{
    return 44.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self internalInit];

        _cellType = HDBaseTableViewCellNone;
        _separateLineOffset = 0;
        _sizeOnePx = 1.0 / [UIScreen mainScreen].scale;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
}

-(void)internalInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _lineColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];

    _topLineView = [[UIView alloc] init];
    _topLineView.backgroundColor = _lineColor;
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = _lineColor;
    [self.contentView addSubview:_topLineView];
    [self.contentView addSubview:_bottomLineView];

    //初始化的时候隐藏线
    _topLineView.hidden = YES;
    _bottomLineView.hidden = YES;
}


- (void)setCellData:(id)MSCellData{
    [self setCellData:MSCellData delegate:nil];
}

- (void)setCellData:(id)MSCellData delegate:(id)delegate{
    _hdCellData = MSCellData;
    _hdDelegate = delegate;
}

- (void)setSeperatorLine:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger)numberOfRowsInSection{
    if (numberOfRowsInSection == 1) {
        self.cellType = HDBaseTableViewCellSingle;
    }
    else {
        if (indexPath.row == 0) {
            self.cellType = HDBaseTableViewCellAtFirst;
        }
        else if (indexPath.row == numberOfRowsInSection - 1) {
            self.cellType = HDBaseTableViewCellAtLast;
        }
        else {
            self.cellType = HDBaseTableViewCellAtMiddle;
        }
    }
}

-(void)setCellType:(HDBaseTableViewCellType)type{
    _cellType = type;
    switch (_cellType) {
        case HDBaseTableViewCellNone:
            _topLineView.hidden = YES;
            _bottomLineView.hidden = YES;
            break;

        case HDBaseTableViewCellAtFirst:
        case HDBaseTableViewCellNormal:
        case HDBaseTableViewCellAtMiddle:
            _topLineView.hidden = NO;
            _bottomLineView.hidden = YES;
            break;

        case HDBaseTableViewCellAtLast:
        case HDBaseTableViewCellSingle:
            _topLineView.hidden = NO;
            _bottomLineView.hidden = NO;
            break;

        default:
            break;
    }

    [self setNeedsLayout];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _topLineView.backgroundColor = _lineColor;
    _bottomLineView.backgroundColor = _lineColor;
}

-(void)layoutSubviews {
    [super layoutSubviews];

    switch (_cellType) {
        case HDBaseTableViewCellNone:
            _topLineView.frame = CGRectMake(_separateLineOffset, 0.0, self.frame.size.width - _separateLineOffset, _sizeOnePx);
            _bottomLineView.frame = CGRectMake(_separateLineOffset, self.bounds.size.height - _sizeOnePx, self.frame.size.width - _separateLineOffset, _sizeOnePx);
            break;

        case HDBaseTableViewCellAtFirst:
            _topLineView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, _sizeOnePx);
            _bottomLineView.frame = CGRectMake(_separateLineOffset, self.bounds.size.height - _sizeOnePx, self.frame.size.width - _separateLineOffset, _sizeOnePx);
            break;

        case HDBaseTableViewCellAtMiddle:
        case HDBaseTableViewCellNormal:
            _topLineView.frame = CGRectMake(_separateLineOffset, 0.0, self.frame.size.width - _separateLineOffset, _sizeOnePx);
            _bottomLineView.frame = CGRectMake(_separateLineOffset, self.bounds.size.height - _sizeOnePx, self.frame.size.width - _separateLineOffset, _sizeOnePx);
            break;

        case HDBaseTableViewCellAtLast:
            _topLineView.frame = CGRectMake(_separateLineOffset, 0.0, self.frame.size.width - _separateLineOffset, _sizeOnePx);
            _bottomLineView.frame = CGRectMake(0.0, self.bounds.size.height - _sizeOnePx, self.frame.size.width, _sizeOnePx);
            break;

        case HDBaseTableViewCellSingle:
            _topLineView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, _sizeOnePx);
            _bottomLineView.frame = CGRectMake(0.0, self.bounds.size.height - _sizeOnePx, self.frame.size.width, _sizeOnePx);
            break;

        default:
            break;
    }
}


@end
