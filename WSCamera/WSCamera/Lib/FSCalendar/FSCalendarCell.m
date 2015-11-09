//
//  FSCalendarCell.m
//  Pods
//
//  Created by Wenchao Ding on 12/3/15.
//
//

#import "FSCalendarCell.h"
#import "FSCalendar.h"
#import "UIView+FSExtension.h"
#import "NSDate+FSExtension.h"

#define kAnimationDuration 0.15
// 获得RGB颜色
#define CPRGBColor(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0]

@interface FSCalendarCell ()

@property (strong,   nonatomic) CAShapeLayer *backgroundLayer;
@property (strong,   nonatomic) CAShapeLayer *eventLayer;
@property (readonly, nonatomic) BOOL         today;
@property (readonly, nonatomic) BOOL         weekend;

@property (nonatomic, weak) UILabel *line1;
@property (nonatomic, weak) UILabel *line2;
@property (nonatomic, weak) UILabel *line3;
@property (nonatomic, weak) UILabel *line4;

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary;

@end

@implementation FSCalendarCell

#pragma mark - Init and life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textColor = [UIColor darkTextColor];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        subtitleLabel.textAlignment = NSTextAlignmentCenter;
        subtitleLabel.font = [UIFont systemFontOfSize:10];
        subtitleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:subtitleLabel];
        self.subtitleLabel = subtitleLabel;
        
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
        _backgroundLayer.hidden = YES;
        [self.contentView.layer insertSublayer:_backgroundLayer atIndex:0];
        
        _eventLayer = [CAShapeLayer layer];
        _eventLayer.backgroundColor = [UIColor clearColor].CGColor;
        _eventLayer.fillColor = [UIColor cyanColor].CGColor;
        _eventLayer.path = [UIBezierPath bezierPathWithOvalInRect:_eventLayer.bounds].CGPath;
        _eventLayer.hidden = YES;
        [self.contentView.layer insertSublayer:_eventLayer atIndex:1];
        
        UILabel *line1 = [[UILabel alloc] init];
        line1.backgroundColor = CPRGBColor(239, 239, 235, 1);
        self.line1 = line1;
        [self.contentView addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] init];
        line2.backgroundColor = CPRGBColor(239, 239, 235, 1);
        self.line2 = line2;
        [self.contentView addSubview:line2];
        
        UILabel *line3 = [[UILabel alloc] init];
        line3.backgroundColor = CPRGBColor(239, 239, 235, 1);
        self.line3 = line3;
        [self.contentView addSubview:line3];
        
        UILabel *line4 = [[UILabel alloc] init];
        line4.backgroundColor = CPRGBColor(239, 239, 235, 1);
        self.line4 = line4;
        [self.contentView addSubview:line4];
       
    }
    return self;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    CGFloat titleHeight = self.bounds.size.height * 5.0 / 6.0;
    CGFloat diameter = MIN(self.bounds.size.height * 5.0 / 6.0, self.bounds.size.width);
    _backgroundLayer.frame = CGRectMake((self.bounds.size.width - diameter) / 2,
                                        (titleHeight-diameter) / 2 + 2,
                                        diameter,
                                        diameter);
    CGFloat eventSize = _backgroundLayer.frame.size.height / 6.0;
    
    _eventLayer.frame = CGRectMake(_backgroundLayer.frame.origin.x + _backgroundLayer.frame.size.width * 0.05,_backgroundLayer.frame.origin.y + _backgroundLayer.frame.size.height * 0.4,eventSize * 0.8, eventSize * 0.8);
    
    _eventLayer.path = [UIBezierPath bezierPathWithOvalInRect:_eventLayer.bounds].CGPath;

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.line1.frame = CGRectMake(0, 0, 1, height);
    self.line2.frame = CGRectMake(0, height, width, 1);
    self.line3.frame = CGRectMake(width, 0, 1, height);
    self.line4.frame = CGRectMake(0, 0, width, 1);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [CATransaction setDisableActions:YES];
}

#pragma mark - Setters

- (void)setDate:(NSDate *)date
{
    if (![_date isEqualToDate:date]) {
        _date = date;
    }
    [self configureCell];
}

- (void)setHasEvent:(BOOL)hasEvent
{
    if (_hasEvent != hasEvent) {
        _hasEvent = hasEvent;
        _eventLayer.hidden = !hasEvent;
    }
}

- (void)showAnimation
{
    _backgroundLayer.hidden = NO;
    _backgroundLayer.path = [UIBezierPath bezierPathWithOvalInRect:_backgroundLayer.bounds].CGPath;
    _backgroundLayer.fillColor = [self colorForCurrentStateInDictionary:_backgroundColors].CGColor;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomOut.fromValue = @0.3;
    zoomOut.toValue = @1.2;
    zoomOut.duration = kAnimationDuration/4*3;
    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomIn.fromValue = @1.2;
    zoomIn.toValue = @1.0;
    zoomIn.beginTime = kAnimationDuration/4*3;
    zoomIn.duration = kAnimationDuration/4;
    group.duration = kAnimationDuration;
    group.animations = @[zoomOut, zoomIn];
    [_backgroundLayer addAnimation:group forKey:@"bounce"];
    [self configureCell];
}

- (void)hideAnimation
{
    _backgroundLayer.hidden = YES;
    [self configureCell];
}

#pragma mark - Private

- (void)configureCell
{
    if (self.isPlaceholder) {
        self.contentView.backgroundColor = CPRGBColor(246, 246, 246, 1);
    }
    else
    {
        self.contentView.backgroundColor = CPRGBColor(255, 255, 255, 1);
    }
    if (self.isWeekend)
    {
        _titleLabel.textColor = CPRGBColor(251, 125, 0,1);
    }
    else
    {
        _titleLabel.textColor = CPRGBColor(116, 116, 116,1);
    }
    
    _titleLabel.text = [NSString stringWithFormat:@"%@",@(_date.fs_day)];
    _subtitleLabel.text = _subtitle;
//    _titleLabel.textColor = [self colorForCurrentStateInDictionary:_titleColors];
    _subtitleLabel.textColor = [self colorForCurrentStateInDictionary:_subtitleColors];
    
    _backgroundLayer.fillColor = [self colorForCurrentStateInDictionary:_backgroundColors].CGColor;
    
    CGFloat titleHeight = [_titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    if (_subtitleLabel.text) {
        _subtitleLabel.hidden = NO;
        CGFloat subtitleHeight = [_subtitleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.subtitleLabel.font}].height;
        CGFloat height = titleHeight + subtitleHeight;
        _titleLabel.frame = CGRectMake(0,
                                       (self.contentView.fs_height*5.0/6.0-height)*0.5,
                                       self.fs_width,
                                       titleHeight);
        
        _subtitleLabel.frame = CGRectMake(0,
                                          _titleLabel.fs_bottom - (_titleLabel.fs_height-_titleLabel.font.pointSize),
                                          self.fs_width,
                                          subtitleHeight);
    } else {
        _titleLabel.frame = CGRectMake(0, 0, self.fs_width, floor(self.contentView.fs_height*5.0/6.0));
        _subtitleLabel.hidden = YES;
    }
    _backgroundLayer.hidden = !self.selected && !self.isToday;
    _backgroundLayer.path = _cellStyle == FSCalendarCellStyleCircle ?
    [UIBezierPath bezierPathWithOvalInRect:_backgroundLayer.bounds].CGPath :
    [UIBezierPath bezierPathWithRect:_backgroundLayer.bounds].CGPath;
    _eventLayer.fillColor = _eventColor.CGColor;
}

- (BOOL)isPlaceholder {
    return ![_date fs_isEqualToDateForMonth:_month];
}

- (BOOL)isToday {
    return [_date fs_isEqualToDateForDay:_currentDate];
}

- (BOOL)isWeekend {
    return self.date.fs_weekday == 1 || self.date.fs_weekday == 7;
}

- (UIColor *)colorForCurrentStateInDictionary:(NSDictionary *)dictionary {
    if (self.isSelected)
    {
        return dictionary[@(FSCalendarCellStateSelected)];
    }
    if (self.isToday) {
        return dictionary[@(FSCalendarCellStateToday)];
    }
    if (self.isPlaceholder)
    {
        return CPRGBColor(230, 230, 230, 1);
    }
    if (self.isWeekend && [[dictionary allKeys] containsObject:@(FSCalendarCellStateWeekend)])
    {
        return dictionary[@(FSCalendarCellStateWeekend)];
    }
    return dictionary[@(FSCalendarCellStateNormal)];
}

@end
