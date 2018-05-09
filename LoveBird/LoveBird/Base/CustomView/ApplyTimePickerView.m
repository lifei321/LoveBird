//
//  ApplyTimePickerDetailView.m
//
//  Created by ShanCheli on 2017/9/18.
//

#import "ApplyTimePickerView.h"
#import "AppStyleMacro.h"
#import "AppDateManager.h"

@interface ApplyTimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) NSInteger daysOfCurrentMonth;

@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSDate *toDate;

/**
 *日期格式@“2000-01-01”
 *默认起始日期@“2000-01-01”
 *默认截止日期@“2050-12-31”
 */
@property (nonatomic, strong) NSString *fromDateString;
@property (nonatomic, strong) NSString *toDateString;
@property (nonatomic, strong) NSString *currentDateString;

//yyyy-mm-dd
@property (nonatomic, strong) NSString *selectDateString;

//当前选中的年份
@property (nonatomic, strong) NSString *selectYearString;


@end

@implementation ApplyTimePickerView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *coverView = [[UIView alloc] initWithFrame:frame];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.4;
        coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleClick)];
        [coverView addGestureRecognizer:tapGes];
        [self addSubview:coverView];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, frame.size.height - AutoSize(150), SCREEN_WIDTH, AutoSize(150))];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerView];
        
        UIToolbar *toolbar = [[UIToolbar alloc]init];
        toolbar.barTintColor = kBackGroundColorEDEDED;
        UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(DoneClick)];
        toolbar.items = @[item0, item1, item2];
        toolbar.frame = CGRectMake(0, self.pickerView.top - AutoSize(40), SCREEN_WIDTH, AutoSize(40));
        [self addSubview:toolbar];
        
        self.fromDateString = @"1900-01-01";
        self.toDateString = [[AppDateManager shareManager] getDateWithNSDate:[NSDate date] formatSytle:DateFormatYMD];
        self.currentDateString = @"2010-01-01";
        
        self.fromDate = [self dateFromString:self.fromDateString];
        self.toDate = [self dateFromString:self.toDateString];
        
        [self.pickerView reloadAllComponents];
        [self chooseCurrentDate];
    }
    return self;
}


#pragma mark -- 选择当前默认日期函数
- (void)chooseCurrentDate {
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * conponent = [cal components:unitFlags fromDate:[self dateFromString:self.currentDateString]];
    NSInteger month = [conponent month];
    
    NSDateComponents * comCenter = [cal components:unitFlags fromDate:self.fromDate toDate:[self dateFromString:self.currentDateString] options:0];
    
    [self.pickerView selectRow:comCenter.year inComponent:0 animated:YES];
    [self.pickerView selectRow:month - 1 inComponent:1 animated:YES];
//    [self.pickerView selectRow:day - 1 inComponent:2 animated:YES];
}


- (void)DoneClick {
    if (self.handler) {
        if (self.selectDateString.length == 0) {
            self.selectDateString = @"2010-01";
        }
        self.handler(self, self.selectDateString);
    }
}
- (void)cancleClick {
    if (self.handler) {
        self.handler(self, nil);
    }
}

#pragma mark -- UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    if (self.toDateString.length) {
        self.toDate = [self dateFromString:self.toDateString];
    } else {
        self.toDate = [NSDate date];
    }
    NSDateComponents * conponent = [cal components:unitFlags fromDate:self.fromDate toDate:self.toDate options:0];
    NSInteger year = [conponent year];
    
    NSDateComponents* comp = [cal components:unitFlags fromDate:self.toDate];
    NSString *currentYear = [NSString stringWithFormat:@"%ld", comp.year];
    NSInteger month = comp.month;
    NSInteger day = comp.day;

    switch (component) {
        case 0:
            return (year + 1);
            break;
        case 1:
            {
                if ([currentYear isEqualToString:self.selectYearString]) {
                    return month;
                }
                return 12;
            }
            break;
        case 2:
            {
                if ([currentYear isEqualToString:self.selectYearString]) {
                    return day;
                }
                return 31;
            }
            break;
        default:
            break;
    }
    return 12;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return AutoSize(295) / 2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return AutoSize(40);
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    //隐藏框
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    
    if (component == 0) {
        NSCalendar * cal=[NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents * conponent= [cal components:unitFlags fromDate:self.fromDate];
        return [NSString stringWithFormat:@"%04ld年",(long)[conponent year] + row];
    } else if (component == 1) {
        return [NSString stringWithFormat:@"%02ld月",(long)1+row];
    } else if (component == 2) {
        return [NSString stringWithFormat:@"%02ld日",(long)1+row];
    }
    
    return @"";
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:kFont(17)];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self pickerViewLoaded:component];
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * comFrom = [cal components:unitFlags fromDate:self.fromDate];
    NSDateComponents * comEnd = [cal components:unitFlags fromDate:self.toDate];
    
    if ([self.pickerView selectedRowInComponent:0] == 0 && [self.pickerView selectedRowInComponent:1] < comFrom.month - 1) {
        [self.pickerView selectRow:comFrom.month - 1 inComponent:1 animated:YES];
    }
    
    if (comFrom.year + [self.pickerView selectedRowInComponent:0] > comEnd.year) {
        [self.pickerView selectRow:comEnd.year inComponent:0 animated:YES];
    }
    if (comFrom.year+[self.pickerView selectedRowInComponent:0] >= comEnd.year && [self.pickerView selectedRowInComponent:1] > comEnd.month-1) {
        [self.pickerView selectRow:comEnd.month-1 inComponent:1 animated:YES];
    }
    
    self.selectDateString  = [NSString stringWithFormat:@"%ld-%02ld",(long)comFrom.year + (long)[self.pickerView selectedRowInComponent:0],(long)[self.pickerView selectedRowInComponent:1] + 1];
    self.selectYearString = [NSString stringWithFormat:@"%ld", (long)comFrom.year + (long)[self.pickerView selectedRowInComponent:0]];
    [pickerView reloadAllComponents];
}
- (void)pickerViewLoaded: (NSInteger)component {
    
    NSUInteger max = 16384;
    NSUInteger base10 = (max / 2) - (max / 2) % (component ? 4 : 24);
    [self.pickerView selectRow:[self.pickerView selectedRowInComponent:component] % (component ? 4 : 24) + base10 inComponent:component animated:NO];
}

#pragma mark -- 时间相关函数
//获取当前时间若干年、月、日之后的时间
- (NSDate *)dateWithFromDate:(NSDate *)date years:(NSInteger)years months:(NSInteger)months days:(NSInteger)days {
    NSDate  * latterDate;
    if (date) {
        latterDate = date;
    }else{
        latterDate = [NSDate date];
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                          fromDate:latterDate];
    
    [comps setYear:years];
    [comps setMonth:months];
    [comps setDay:days];
    
    return [calendar dateByAddingComponents:comps toDate:latterDate options:0];
}

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
- (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    return comp.day;
}
//字符串转日期
- (NSDate *)dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}


@end
