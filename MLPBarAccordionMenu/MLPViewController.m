//
//  MLPViewController.m
//  MLPBarAccordionMenu
//
//  Created by Javier Figueroa on 4/12/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import "MLPViewController.h"
#import "MLPBarAccordionMenu.h"
#import "MLPMenuItem.h"

@interface MLPViewController ()
{
    MLPBarAccordionMenu *menu;
}
@end

@implementation MLPViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MLPMenuItem *calendar = [[MLPMenuItem alloc] init];
    calendar.icon = [UIImage imageNamed:@"calendar_32x32"];
    calendar.title = @"Calendar";
    
    
    MLPMenuItem *camera = [[MLPMenuItem alloc] init];
    camera.icon = [UIImage imageNamed:@"camera_32x32"];
    camera.title = @"Camera";
    
    
    MLPMenuItem *cloud = [[MLPMenuItem alloc] init];
    cloud.icon = [UIImage imageNamed:@"cloud_32x20"];
    cloud.title = @"Cloud";
    
    MLPMenuItem *refresh = [[MLPMenuItem alloc] init];
    refresh.icon = [UIImage imageNamed:@"loop_32x32"];
    refresh.title = @"Refresh";
    
    menu = [[MLPBarAccordionMenu alloc] initWithItems:@[calendar, camera, cloud, refresh]];

    [self.navigationItem setRightBarButtonItem:self.toggleButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didSelectToggleButton:(id)sender {

    [menu toggleInView:self.topView];
}

@end
