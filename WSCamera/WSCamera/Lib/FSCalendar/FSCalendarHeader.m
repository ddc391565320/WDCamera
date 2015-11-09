//
//  FSCalendarHeader.m
//  Pods
//
//  Created by Wenchao Ding on 29/1/15.
//
//

#import "FSCalendarHeader.h"
#import "FSCalendar.h"
#import "UIView+FSExtension.h"
#import "NSDate+FSExtension.h"
#import "NSCalendar+FSExtension.h"
#import "InternationalControl.h"

#define kBlueText [UIColor colorWithRed:14/255.0 green:69/255.0 blue:221/255.0 alpha:1.0]

@interface FSCalendarHeader () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (copy, nonatomic) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (weak, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;

@property (copy, nonatomic) NSDate *minimumDate;
@property (copy, nonatomic) NSDate *maximumDate;

- (void)updateAlphaForCell:(UICollectionViewCell *)cell;

@end

@implementation FSCalendarHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _dateFormat = @"MMMM yyyy";
    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateFormat = _dateFormat;
    _minDissolveAlpha = 0.2;
    _scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _minimumDate = [NSDate fs_dateWithYear:1970 month:1 day:1];
    _maximumDate = [NSDate fs_dateWithYear:2099 month:12 day:31];

    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewFlowLayout.minimumInteritemSpacing = 0;
    collectionViewFlowLayout.minimumLineSpacing = 0;
    self.collectionViewFlowLayout = collectionViewFlowLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds
                                                          collectionViewLayout:_collectionViewFlowLayout];
    collectionView.scrollEnabled = NO;
    collectionView.userInteractionEnabled = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionView addObserver:self forKeyPath:@"contentSize"
                        options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    self.collectionView = collectionView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _collectionView && [keyPath isEqualToString:@"contentSize"]) {
        [_collectionView removeObserver:self forKeyPath:@"contentSize"];
        CGFloat scrollOffset = self.scrollOffset;
        _scrollOffset = 0;
        self.scrollOffset = scrollOffset;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionViewFlowLayout.itemSize = CGSizeMake(self.fs_width * 0.5,
                                                    self.fs_height);
    _collectionView.frame = self.bounds;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = [_maximumDate fs_monthsFrom:_minimumDate] + 1;
    return count;
}

- (NSString *)getNewDateString:(NSString *)dateString {
    BOOL isEn = YES;
    if ([[InternationalControl userLanguage] isEqualToString:@"en"]) {
        isEn = YES;
    } else {
        isEn = NO;
    }
    NSString *newDateString = nil;
    NSArray *monthEn = @[@"January", @"February", @"March", @"April", @"May", @"June",
                         @"July", @"August", @"September", @"October", @"November", @"December"];
    NSArray *monthGB = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月",
                         @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
    
    for (int i = 0; i < [monthEn count]; i++) {
        NSString *enString = [monthEn objectAtIndex:i];
        NSString *gbString = [monthGB objectAtIndex:i];
        if ([dateString hasPrefix:enString]) {
            if (isEn == YES) {
                newDateString = dateString;
            } else {
                newDateString = [dateString stringByReplacingOccurrencesOfString:enString withString:gbString];
            }
            break;
        }
        if ([dateString hasPrefix:gbString]) {
            if (isEn == YES) {
                newDateString = [dateString stringByReplacingOccurrencesOfString:gbString withString:enString];
            } else {
                newDateString = dateString;
            }
            break;
        }
    }
    return newDateString;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
        titleLabel.tag = 100;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel];
    }
    titleLabel.font = self.titleFont;
    titleLabel.textColor = self.titleColor;
    NSDate *date = [_minimumDate fs_dateByAddingMonths:indexPath.item];
    NSString *newDateString = [self getNewDateString:[_dateFormatter stringFromDate:date]];
    titleLabel.text = newDateString;

    [self updateAlphaForCell:cell];
    
    return cell;
}

#pragma mark - Setter & Getter

- (void)setScrollOffset:(CGFloat)scrollOffset {
    if (_scrollOffset != scrollOffset) {
        _scrollOffset = scrollOffset;
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            _collectionView.contentOffset = CGPointMake((_scrollOffset - 0.5) * _collectionViewFlowLayout.itemSize.width, 0);
        } else {
            _collectionView.contentOffset = CGPointMake(0, _scrollOffset * _collectionViewFlowLayout.itemSize.height);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *cells = _collectionView.visibleCells;
            [cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self updateAlphaForCell:obj];
            }];
        });
    }
}

- (void)setDateFormat:(NSString *)dateFormat {
    if (![_dateFormat isEqualToString:dateFormat]) {
        _dateFormat = [dateFormat copy];
        _dateFormatter.dateFormat = dateFormat;
        [self reloadData];
    }
}

- (void)setMinDissolveAlpha:(CGFloat)minDissolveAlpha {
    if (_minDissolveAlpha != minDissolveAlpha) {
        _minDissolveAlpha = minDissolveAlpha;
        [self reloadData];
    }
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    if (_scrollDirection != scrollDirection) {
        _scrollDirection = scrollDirection;
        _collectionViewFlowLayout.scrollDirection = scrollDirection;
        CGPoint newOffset = CGPointMake(scrollDirection == UICollectionViewScrollDirectionHorizontal
                                        ? (_scrollOffset - 0.5) *_collectionViewFlowLayout.itemSize.width : 0,
                                        scrollDirection == UICollectionViewScrollDirectionVertical
                                        ? _scrollOffset * _collectionViewFlowLayout.itemSize.height : 0);
        _collectionView.contentOffset = newOffset;
        if (scrollDirection == UICollectionViewScrollDirectionVertical) {
            _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, self.fs_width * 0.25, 0, self.fs_width * 0.25);
        } else {
            _collectionViewFlowLayout.sectionInset = UIEdgeInsetsZero;
        }
        [_collectionView reloadData];
    }
}

#pragma mark - Public

- (void)reloadData {
    [_collectionView reloadData];
}

#pragma mark - Private

- (void)updateAlphaForCell:(UICollectionViewCell *)cell {
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        CGFloat position = [cell convertPoint:CGPointMake(CGRectGetMidX(cell.bounds),
                                                          CGRectGetMidY(cell.bounds)) toView:self].x;
        CGFloat center = CGRectGetMidX(self.bounds);
        cell.contentView.alpha = 1.0 - (1.0 -_minDissolveAlpha) * ABS(center - position)
        / _collectionViewFlowLayout.itemSize.width;
    } else {
        CGFloat position = [cell convertPoint:CGPointMake(CGRectGetMidX(cell.bounds),
                                                          CGRectGetMidY(cell.bounds)) toView:self].y;
        CGFloat center = CGRectGetMidY(self.bounds);
        cell.contentView.alpha = 1.0 - (1.0 - _minDissolveAlpha) * ABS(center - position)
        / _collectionViewFlowLayout.itemSize.height;
    }
}

@end
