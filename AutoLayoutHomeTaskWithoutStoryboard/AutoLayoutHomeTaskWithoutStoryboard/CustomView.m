//
//  CustomView.m
//  AutoLayoutHomeTaskWithoutStoryboard
//
//  Created by Dmitriy Tarelkin on 27/6/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)addButtonWithConstraints {
    
    _button = [[UIButton alloc] init];
    [_button setTitle:@"Resize" forState:UIControlStateNormal];
    _button.clipsToBounds = YES;
    _button.translatesAutoresizingMaskIntoConstraints = false;
    
    [self addSubview:_button];
    
    
    NSLayoutConstraint *centerXConstraint = [_button.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
    centerXConstraint.identifier = @"ButtonCenterXConstraint";
    
    NSLayoutConstraint *centerYConstraint = [_button.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
    centerYConstraint.identifier = @"ButtonCenterYConstraint";
    
    NSLayoutConstraint *widthConstraint = [_button.widthAnchor constraintEqualToConstant:100.0];
    widthConstraint.identifier = @"ButtonWidthConstraint";
    
    NSLayoutConstraint *heightConstraint = [_button.heightAnchor constraintEqualToConstant:50.0];
    heightConstraint.identifier = @"ButtonHeightConstraint";
    
    [NSLayoutConstraint activateConstraints:@[widthConstraint, heightConstraint, centerXConstraint, centerYConstraint]];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
