 //
// Created by l.t.zero on 15/11/5.
// Copyright (c) 2015 Gavin. All rights reserved.
//

#import "UITextField+limit.h"
#import <objc/runtime.h>


@implementation UITextField(LimitTextFiled)

@dynamic limitedLength;

- (void)setTip:(NSString *)tip {
    objc_setAssociatedObject(self, "tip", tip, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)tip {
    return objc_getAssociatedObject(self, "tip");
}

- (void)setLimitedLength:(NSUInteger)limitedLength {
    objc_setAssociatedObject(self, "limitedLength", @(limitedLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (limitedLength > 0){
        [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    }else{
        if( [self actionsForTarget:self forControlEvent:UIControlEventEditingChanged].count > 0){
            [self removeTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
        }
    }
}

- (NSUInteger)limitedLength {
    id length = objc_getAssociatedObject(self, "limitedLength");
    return length? [length unsignedIntValue]:0;
}

- (void)valueChanged:(id)sender{

    if (self.limitedLength <= 0)
        return;

    UITextField *textField = sender;
    NSString *toBeString = textField.text;
    NSString *lang = self.textInputMode.primaryLanguage; // 键盘输入模式

    if ([lang isEqualToString:@"zh-Hans"] || [lang isEqualToString:@"zh-Hant"]
            || [lang isEqualToString:@"zh-CHT"] || [lang isEqualToString:@"zh_CN"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.limitedLength) {
                textField.text = [toBeString substringToIndex:self.limitedLength];
            }
        }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{

        }
    }else if ([lang isEqualToString:@"en-US"]){
        if (toBeString.length > self.limitedLength) {
            textField.text = [toBeString substringToIndex:self.limitedLength];
        }
    }else{// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length <= self.limitedLength) {
            textField.text = toBeString;
        }
    }
}
@end
