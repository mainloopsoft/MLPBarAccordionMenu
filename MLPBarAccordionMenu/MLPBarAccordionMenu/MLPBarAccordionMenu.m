//
//  MLPBarAccordionMenu.m
//  MLPBarAccordionMenu
//
//  Created by Javier Figueroa on 4/12/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPBarAccordionMenu.h"
#import "MLPBarAccordionCell.h"
#import <QuartzCore/QuartzCore.h>

#define kCellSize 70
#define kCellPad 4

#define DEGREES_TO_RADIANS(x) (M_PI * x / 180.0)

static NSString *cellIdentifier = @"MLPBarAccordionCell";

@implementation MLPBarAccordionMenuItem

@end

@interface MLPBarAccordionMenu()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) UIView *view;

@end

@implementation MLPBarAccordionMenu

- (BOOL)isCollapsed
{
    return self.view.superview == nil;
}

- (id)init
{
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setItemSize:CGSizeMake(kCellSize, kCellSize)];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:aFlowLayout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"MLPBarAccordionCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    }
    
    self.clipsToBounds = NO;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0,3);
    self.layer.shadowOpacity = 0.8;
    self.bounces = NO;
    self.scrollEnabled = NO;
    
    return self;
}

- (id)initWithItems:(NSArray*)menuItems
{
    self = [self init];
    if (self) {
        self.menuItems = menuItems;
    }
    
    return self;
}

- (void)toggleBetweenNavigationBar:(UINavigationController*)navigationController andView:(UIView*)view
{
    [self animateButton:self.barButton];
    
    if (self.superview != nil) {
        [self hide];
    }else{
        [self showBetweenNavigationBar:navigationController andView:view];
    }
}

- (void)showBetweenNavigationBar:(UINavigationController*)navigationController andView:(UIView*)view
{
    self.navigationController = navigationController;
    self.view = view;
    
    UINavigationBar *navBar = navigationController.navigationBar;
    NSInteger navBarHeight = navBar.frame.size.height;
    NSInteger rows = (self.menuItems.count+4-1)/4;
    NSInteger height = (rows * kCellSize) + (rows * kCellPad) + kCellPad;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    if (![UIApplication sharedApplication].statusBarHidden){
        NSInteger statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        navBarHeight += statusBarHeight;
    }
    
    self.frame = CGRectMake(0, -height + navBarHeight, screenWidth, height);
    
    [navigationController.view insertSubview:self belowSubview:navBar];
    
    
    //Animate popup
    [UIView animateWithDuration:0.3
                     animations:^{
                         view.frame = CGRectApplyAffineTransform(view.frame, CGAffineTransformMakeTranslation(0, height));
                         self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(0, height));
                         
                     }
                     completion:^(BOOL finished){
                         if(finished){
                         }
                     }];
}

- (void)hide
{
    if (self.view != nil && self.navigationController != nil) {
        UIView *view = self.view;
        UINavigationController *navigationController = self.navigationController;
        
        self.navigationController = nil;
        self.view = nil;
        
        UINavigationBar *navBar = navigationController.navigationBar;
        NSInteger navBarHeight = navBar.frame.size.height;
        NSInteger rows = (self.menuItems.count+4-1)/4;
        NSInteger height = (rows * kCellSize) + (rows * kCellPad) + kCellPad;
        
        if (![UIApplication sharedApplication].statusBarHidden){
            NSInteger statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
            navBarHeight += statusBarHeight;
        }
        
        //Animate popup
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut 
                         animations:^{
                             view.frame = CGRectApplyAffineTransform(view.frame, CGAffineTransformMakeTranslation(0, -height));
                             self.frame = CGRectApplyAffineTransform(self.frame, CGAffineTransformMakeTranslation(0, -height));
                             
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 [self removeFromSuperview];
                             }
                         }];
    }
}

#pragma mark - UIBarButton Helpers

- (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)image target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 60, 60);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)animateButton:(UIBarButtonItem*)barButton
{
    UIButton *button = (UIButton*)barButton.customView;
    NSInteger degrees = ![self isCollapsed] ? 360 : -180;
    
    [UIView animateWithDuration:0.5 animations:^{
        button.imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    }];
}

#pragma mark - DataSource Methods


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MLPBarAccordionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    MLPBarAccordionMenuItem *item = [self.menuItems objectAtIndex:indexPath.row];
    cell.iconImageView.image = item.icon;
    cell.titleLabel.text = item.title;
    cell.titleLabel.textColor = item.titleColor ? item.titleColor :[UIColor whiteColor];
    
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCellSize, kCellSize);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kCellPad, kCellPad, kCellPad, kCellPad);
}

#pragma mark - UICollection Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }
}

@end
