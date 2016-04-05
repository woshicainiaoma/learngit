//
//  CHPlaceholderTextView.m
//  百思不得其姐
//
//  Created by 陈欢 on 16/4/5.
//  Copyright © 2016年 陈欢. All rights reserved.
//

#import "CHPlaceholderTextView.h"

@interface CHPlaceholderTextView()

@property (nonatomic, weak) UILabel *placeholderLable;

@end
@implementation CHPlaceholderTextView

- (UILabel *)placeholderLable
{
    if (!_placeholderLable) {
        UILabel *placeholderlable = [[UILabel alloc] init];
        placeholderlable.numberOfLines = 0;
        

        placeholderlable.x = 4;
        placeholderlable.y = 7;
       // placeholderlable.backgroundColor = [UIColor redColor];
        [self addSubview:placeholderlable];
        _placeholderLable = placeholderlable;
    }
    return _placeholderLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        [CHNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [CHNoteCenter removeObserver:self];
}

- (void)textDidChange
{
    self.placeholderLable.hidden = self.hasText;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLable.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLable.text = placeholder;
    
    [self setNeedsLayout];
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLable.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholderLable.width = self.width - 2 * self.placeholderLable.x;
    [self.placeholderLable sizeToFit];
}








@end
