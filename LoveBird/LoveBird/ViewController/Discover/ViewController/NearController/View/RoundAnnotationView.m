
#import "RoundAnnotationView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RoundAnnotationView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation RoundAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self setBounds:CGRectMake(0.f, 0.f, AutoSize6(105), AutoSize6(105))];
        [self setContentView];
    }
    return self;
}

- (void)setContentView {

    self.backgroundColor = [UIColor clearColor];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.iconImageView.contentMode = UIViewContentModeScaleToFill;
    self.iconImageView.image = [UIImage imageNamed:@"placeHolder"];
    self.iconImageView.layer.cornerRadius = self.width / 2;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.borderWidth = 1;
    self.iconImageView.layer.masksToBounds = YES;
    [self addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - AutoSize6(26), 0, 0, AutoSize6(34))];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = kFont6(22);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = UIColorFromRGB(0x33d1bf);
    self.titleLabel.clipsToBounds = YES;
    [self addSubview:self.titleLabel];
    
    
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
    CGFloat width = [title getTextWightWithFont:self.titleLabel.font];
    
    self.titleLabel.width = width + AutoSize6(20);
    self.titleLabel.layer.cornerRadius = self.titleLabel.height / 2;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = [imgUrl copy];
    NSString *stringUrl = [imgUrl stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSURL *url = [NSURL URLWithString:stringUrl];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
}


@end
