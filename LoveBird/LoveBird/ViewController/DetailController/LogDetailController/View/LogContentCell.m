//
//  LogContentCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogContentCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BirdDetailController.h"

@interface LogContentCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *birdLabel;

@property (nonatomic, strong) UILabel *tagLabel;


@end

@implementation LogContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(10), SCREEN_WIDTH - AutoSize6(60), AutoSize6(0))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorTextColor333333;
        self.birdLabel.font = kFont6(26);
        self.birdLabel.numberOfLines = 0;
        [self.contentView addSubview:self.birdLabel];
        
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(0), SCREEN_WIDTH - AutoSize6(60), AutoSize6(0))];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        self.iconImageView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_iconImageView];
        
        self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(0), SCREEN_WIDTH - AutoSize6(60), AutoSize6(0))];
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        self.tagLabel.textColor = kColorTextColor333333;
        self.tagLabel.font = kFont6(22);
        self.tagLabel.backgroundColor = UIColorFromRGB(0xececec);
        self.tagLabel.layer.cornerRadius = 3;
        self.tagLabel.clipsToBounds = YES;
        [self.contentView addSubview:self.tagLabel];

        self.tagLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumptoBirdDetail)];
        [self.tagLabel addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)jumptoBirdDetail {
    BirdDetailController *birdDetail = [[BirdDetailController alloc] init];
    birdDetail.cspCode = self.contentModel.csp_code;
    [[UIViewController currentViewController].navigationController pushViewController:birdDetail animated:YES];
}

- (void)leftImageviewClick {
    if (self.selectBlock) {
        self.selectBlock(self.contentModel);
    }
}


- (void)setContentModel:(LogPostBodyModel *)contentModel {
    _contentModel = contentModel;
    
    if (![contentModel.content isBlankString]) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentModel.content];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:AutoSize6(7)];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentModel.content.length)];
        self.birdLabel.attributedText = attributedString;
        
        CGFloat height = [contentModel.content getTextHeightWithFont:self.birdLabel.font withWidth:(SCREEN_WIDTH - AutoSize6(60)) att:paragraphStyle];
        self.birdLabel.height = height;
    } else {
        self.birdLabel.height = 0;
    }
    
    if (contentModel.imgUrl.length) {
        if (contentModel.imgWidth > 0) {
            CGFloat imageHeight = (contentModel.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / contentModel.imgWidth);
            _iconImageView.height = imageHeight;
            
            CGFloat birdHeight = contentModel.content.length ? AutoSize6(10) : 0;
            
            _iconImageView.top = self.birdLabel.bottom + birdHeight;
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
            _iconImageView.userInteractionEnabled = YES;
            [_iconImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftImageviewClick)]];

            self.tagLabel.frame = CGRectZero;
            if (contentModel.imgTag.length) {
                self.tagLabel.text = contentModel.imgTag;
                CGFloat width = [contentModel.imgTag getTextWightWithFont:self.tagLabel.font];
                self.tagLabel.frame = CGRectMake(_iconImageView.right - width - AutoSize6(20) , _iconImageView.bottom + AutoSize6(10), width + AutoSize6(20), AutoSize6(40));
            } else {
                self.tagLabel.frame = CGRectZero;
            }
        } else {
            _iconImageView.height = 0;
            self.tagLabel.height = 0;
        }
        
    } else {
        _iconImageView.height = 0;
        self.tagLabel.height = 0;
        self.birdLabel.top = AutoSize6(20);
    }
}



+ (CGFloat)getHeightWithContentModel:(LogPostBodyModel *)model {
    CGFloat height = 0;
    
    if (!model.content.length && !model.imgUrl.length) {
        return height;
    }
    
    height += AutoSize6(10);
    if (![model.content isBlankString]) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:AutoSize6(7)];
        
        CGFloat contentheight = [model.content getTextHeightWithFont:kFont6(26) withWidth:(SCREEN_WIDTH - AutoSize6(60)) att:paragraphStyle];
        height += contentheight;
    }
    
    if (model.imgUrl.length) {
        
        CGFloat birdHeight = model.content.length ? AutoSize6(10) : 0;

        height += birdHeight;
        height += (model.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / model.imgWidth);
        
        if (model.imgTag.length) {
            height += AutoSize6(50);
            
            // 留白
            height += AutoSize6(10);

        } else {
            
            // 留白
            height += AutoSize6(10);
        }
    } else {
        
        // 文字 上下留20 剧中
        height += AutoSize6(30);
    }
    return height;
}



//- (void)setBodyModel:(LogPostBodyModel *)bodyModel {
//    _bodyModel = bodyModel;
//    
//    //    self.birdLabel.text = bodyModel.message;
//    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bodyModel.message];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:AutoSize6(7)];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, bodyModel.message.length)];
//    self.birdLabel.attributedText = attributedString;
//    [self.birdLabel sizeToFit];
//    
//    CGFloat height = [bodyModel.message getTextHeightWithFont:self.birdLabel.font withWidth:(SCREEN_WIDTH - AutoSize6(60)) att:paragraphStyle];
//    self.birdLabel.height = height;
//    
//    if (bodyModel.isImg) {
//        
//        if (bodyModel.message.length) {
//            _iconImageView.top = self.birdLabel.bottom + AutoSize6(5);
//        } else {
//            _iconImageView.top = self.birdLabel.bottom;
//        }
//        
//        CGFloat imageHeight = (bodyModel.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / bodyModel.imgWidth);
//        _iconImageView.height = imageHeight;
//        
//        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:bodyModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
//        
//        if (bodyModel.imgTag.length) {
//            self.tagLabel.text = bodyModel.imgTag;
//            CGFloat width = [bodyModel.imgTag getTextWightWithFont:self.tagLabel.font];
//            self.tagLabel.frame = CGRectMake(_iconImageView.right - width - AutoSize6(40) , _iconImageView.bottom + AutoSize6(20), width + AutoSize6(40), AutoSize6(40));
//        } else {
//            self.tagLabel.height = 0;
//        }
//        
//    } else {
//        
//        if (height < AutoSize6(80)) {
//            height = AutoSize6(80);
//        }
//        self.birdLabel.height = height;
//        
//        _iconImageView.height = 0;
//        self.tagLabel.height = 0;
//    }
//}
//
//+ (CGFloat)getHeightWithModel:(LogPostBodyModel *)model {
//    CGFloat height = 0;
//    
//    if (!model.message.length && !model.imgUrl.length) {
//        return 0;
//    }
//    
//    height = [model.message getTextHeightWithFont:kFont6(26) withWidth:(SCREEN_WIDTH - AutoSize6(60))];
//    
//    if (model.message.length) {
//        if (model.isImg) {
//            height += AutoSize6(5);
//        } else {
//            height += AutoSize6(0);
//            if (height < AutoSize6(80)) {
//                height = AutoSize6(80);
//            }
//        }
//    }
//    
//    if (model.isImg) {
//        height += (model.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / model.imgWidth);
//        
//        if (model.imgTag.length) {
//            height += AutoSize6(60);
//        }
//    }
//    return height;
//}


@end
