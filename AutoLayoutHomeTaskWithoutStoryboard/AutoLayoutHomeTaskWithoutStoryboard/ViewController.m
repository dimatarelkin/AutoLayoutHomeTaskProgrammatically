//
//  ViewController.m
//  AutoLayoutHomeTaskWithoutStoryboard
//
//  Created by Dmitriy Tarelkin on 27/6/18.
//  Copyright © 2018 Dmitriy Tarelkin. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()
@property (retain, nonatomic) CustomView* redView;
@property (retain, nonatomic) CustomView* blueView;

@property (weak, nonatomic) NSLayoutConstraint* width;
@property (weak, nonatomic) NSLayoutConstraint* height;

@property (retain, nonatomic) NSMutableArray* commonConstraints;
@property (retain, nonatomic) NSMutableArray* compactConstraints;
@property (retain, nonatomic) NSMutableArray* regularConstraints;

@property (assign, nonatomic) NSInteger redTap;
@property (assign, nonatomic) NSInteger blueTap;

-(void)addConstraintsToView;
@end




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redTap = 0;
    self.blueTap = 0;
    
    //add view and target for redView button
    _redView = [[CustomView alloc] init];
    _redView.layer.cornerRadius = 30;
    _redView.backgroundColor = [UIColor redColor];
    [_redView addButtonWithConstraints];
    [_redView.button addTarget:self
                        action:@selector(resizeButtonTapped:)
              forControlEvents:UIControlEventTouchUpInside];
   
    //add view and target for BlueView button
    _blueView = [[CustomView alloc] init];
    _blueView.layer.cornerRadius = 30;
    _blueView.backgroundColor = [UIColor blueColor];
    [_blueView addButtonWithConstraints];
    [_blueView.button addTarget: self
                         action:@selector(resizeButtonTapped:)
               forControlEvents:UIControlEventTouchUpInside];
    
    self.redView.translatesAutoresizingMaskIntoConstraints = false;
    self.blueView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_redView];
    [self.view addSubview:_blueView];
    
    [self addConstraintsToView];
    
}

- (void)resizeButtonTapped:(UIButton *)sender {
    
    if (sender.superview == _redView) {
        
        if (self.redTap == 0) {
            [self changeViewConstraint:_redView];
            NSLog(@"resize red to smaller");
            self.redTap = -1;
            self.blueTap = 1;
            
        } else if (self.redTap == -1) {
            [self changeViewConstraint:_blueView];
            NSLog(@"resize red to Bigger");
            self.redTap = 0;
            self.blueTap = 0;
            
        } else if (self.redTap == 1) {
            [self changeViewConstraint:_redView];
            NSLog(@"red tap == 1");
            self.redTap = 0;
            self.blueTap = 0;
        }
        
        
    } else if(sender.superview == _blueView) {
        
        if (self.blueTap == 0) {
            [self changeViewConstraint:_blueView];
            NSLog(@"resize blue to smaller");
            self.blueTap = -1;
            self.redTap = 1;
            
        } else if(self.blueTap == -1) {
            [self changeViewConstraint:_redView];
            NSLog(@"resize blue to bigger");
            self.blueTap = 0;
            self.redTap = 0;
            
        } else if (self.blueTap == 1){
            [self changeViewConstraint:_blueView];
            NSLog(@"blue tap == 1");
            self.blueTap = 0;
            self.redTap = 0;
        }
        
    }
    
}

-(void)addConstraintsToView {
    
    UILayoutGuide* layoutGuide = self.view.safeAreaLayoutGuide;
    
//add common constraints (3,4,5,13)
    //3
    NSLayoutConstraint* blueViewTrailingConstraint = [self.blueView.trailingAnchor
    constraintEqualToAnchor:layoutGuide.trailingAnchor constant:-30];
    blueViewTrailingConstraint.identifier = @"blueViewTrailingConstraint";
    //4
    NSLayoutConstraint* redViewLeadingConstraint = [self.redView.leadingAnchor
    constraintEqualToAnchor:layoutGuide.leadingAnchor constant:30];
    redViewLeadingConstraint.identifier = @"redViewLeadingConstraint";
    //5
    NSLayoutConstraint* redViewTopConstraint = [self.redView.topAnchor
    constraintEqualToAnchor:layoutGuide.topAnchor constant:30];
    redViewTopConstraint.identifier = @"redViewTopConstraint";
    //13
    NSLayoutConstraint* blueViewBottomConstraint = [self.blueView.bottomAnchor
    constraintEqualToAnchor:layoutGuide.bottomAnchor constant:-30];
    blueViewBottomConstraint.identifier = @"blueViewBottomConstraint";
    
    //group constraints
    self.commonConstraints = [NSMutableArray arrayWithObjects:
                              blueViewTrailingConstraint,redViewLeadingConstraint,
                              redViewTopConstraint, blueViewBottomConstraint, nil];
    //activate
    [NSLayoutConstraint activateConstraints:self.commonConstraints];
    
  
//add compact width constraints (2,8,10,12)
    //2
    NSLayoutConstraint* redViewTrailingConstraintCompact = [self.redView.trailingAnchor
    constraintEqualToAnchor:layoutGuide.trailingAnchor constant:-30];
    redViewTrailingConstraintCompact.identifier = @"redViewTrailingConstraintCompact";
    //8
    NSLayoutConstraint* redViewBottomCosntraintCompact = [self.redView.bottomAnchor
    constraintEqualToAnchor:self.blueView.topAnchor constant: -30];
    redViewBottomCosntraintCompact.identifier = @"redViewBottomCosntraintCompact";
    //10
    NSLayoutConstraint* blueViewLeadingConstraintCompact = [self.blueView.leadingAnchor
    constraintEqualToAnchor:layoutGuide.leadingAnchor constant: 30];
    blueViewLeadingConstraintCompact.identifier = @"blueViewLeadingConstraintCompact";
    //12
    self.height = [self.blueView.heightAnchor
    constraintEqualToAnchor:self.redView.heightAnchor];
    self.height.identifier = @"heightCompact";
    
    //group constraints
    self.compactConstraints = [NSMutableArray arrayWithObjects:
                               redViewTrailingConstraintCompact, redViewBottomCosntraintCompact,
                               blueViewLeadingConstraintCompact, self.height, nil];
    
//add regular width constraints (1,6,7,9)
    //1
    NSLayoutConstraint* redViewBottomConstraintRegular = [self.redView.bottomAnchor
    constraintEqualToAnchor:layoutGuide.bottomAnchor constant:-30];
    redViewBottomConstraintRegular.identifier = @"redViewBottomConstraintRegular";
    //6
    self.width = [self.blueView.widthAnchor
    constraintEqualToAnchor:self.redView.widthAnchor];
    self.width.identifier = @"widthRegular";
    //7
    NSLayoutConstraint* blueViewTopConstraintRegular = [self.blueView.topAnchor
    constraintEqualToAnchor:layoutGuide.topAnchor constant:30];
    blueViewTopConstraintRegular.identifier = @"blueViewTopConstraintRegular";
    //9
    NSLayoutConstraint* blueViewLeadingConstraintRegular = [self.blueView.leadingAnchor
    constraintEqualToAnchor:self.redView.trailingAnchor constant:30];
    blueViewLeadingConstraintRegular.identifier = @"blueViewLeadingConstraintRegular";
    
    //group constraints
    self.regularConstraints = [NSMutableArray arrayWithObjects:
                               redViewBottomConstraintRegular, self.width,
                               blueViewTopConstraintRegular, blueViewLeadingConstraintRegular, nil];
 
  
    
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    self.height.constant = 0;
    self.width.constant = 0;
    if (self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
        [NSLayoutConstraint deactivateConstraints:self.regularConstraints];
        [NSLayoutConstraint activateConstraints:self.compactConstraints];
    } else if(self.view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        [NSLayoutConstraint deactivateConstraints:self.compactConstraints];
        [NSLayoutConstraint activateConstraints:self.regularConstraints];
    }
}

-(void)changeViewConstraint:(UIView*)view {
    
    NSInteger constant;
    if ([view isEqual:_blueView]) {
        constant = 300;
    } else {
        constant = -300;
    }
    
    
    //for iPhone
    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact &&
        self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        _height.constant -= constant;
        [self layoutWithAimation];
        
    } else if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular &&
               self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        _width.constant -= constant;
        [self layoutWithAimation];
        
    } else if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular &&
               self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        _height.constant -= constant;
        [self layoutWithAimation];
        
    } else if ((self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact &&
                self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact)) {
        _height.constant -= constant/2;
        [self layoutWithAimation];
        
    }
    
}

- (void)layoutWithAimation {
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}



@end
