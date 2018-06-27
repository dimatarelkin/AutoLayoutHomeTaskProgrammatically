//
//  CustomView.h
//  AutoLayoutHomeTaskWithoutStoryboard
//
//  Created by Dmitriy Tarelkin on 27/6/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
@property(retain, nonatomic) UIButton* button;

-(void)addButtonWithConstraints;

@end
