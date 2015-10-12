//
//  mineTableViewCell.m
//  Hair
//
//  Created by 冰刀画的圈。 on 15/10/10.
//  Copyright (c) 2015年 dzx. All rights reserved.
//

#import "mineTableViewCell.h"

@implementation mineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self  textpersoon];
}
-(void)textpersoon
{
    _text1.textColor = [UIColor blackColor];
    _text1.clearButtonMode = UITextFieldViewModeAlways;
    _text1.clearsOnBeginEditing = YES;
    _text1.adjustsFontSizeToFitWidth = YES;
    _text1.backgroundColor = [UIColor clearColor];
    _text1.borderStyle = UITextBorderStyleNone;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_edit)
    {
        _text1.enabled = YES;
    }else
    {
        _text1.enabled = NO;
    }
}
@end
