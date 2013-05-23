//
//  MLPBarAccordionMenu.h
//  MLPBarAccordionMenu
//
//  Created by Javier Figueroa on 4/12/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MLPBarAccordionMenuItem : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;

@end

typedef void (^MLPBarAccordionMenuBlock)(NSIndexPath* indexPath);

@interface MLPBarAccordionMenu : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) BOOL isCollapsed;
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) UIBarButtonItem *barButton;
@property (readwrite, nonatomic, copy) MLPBarAccordionMenuBlock selectedBlock;

- (id)initWithItems:(NSArray*)menuItems;

- (void)toggleBetweenNavigationBar:(UINavigationController*)navigationController andView:(UIView*)view;

- (void)hide;

- (UIBarButtonItem*)barButtonItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;

- (void)animateButton:(UIBarButtonItem*)barButton;
@end
