//
//  MLPViewController.h
//  MLPBarAccordionMenu
//
//  Created by Javier Figueroa on 4/12/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLPViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *toggleButton;
@property (weak, nonatomic) IBOutlet UIView *topView;

- (IBAction)didSelectToggleButton:(id)sender;

@end
