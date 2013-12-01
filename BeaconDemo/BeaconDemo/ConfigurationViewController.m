#import "ConfigurationViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface ConfigurationViewController ()

@end

@implementation ConfigurationViewController
{

}

- (void)loadView{
    
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults] stringForKey:@"BeaconUUID"];
    
    self.uuidLabel.text = uuid;


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.uuidLabel.text forKey:@"BeaconUUID"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (IBAction)regenerateUUIDAction:(id)sender
{
    self.uuidLabel.text = [[NSUUID UUID] UUIDString];
}

@end
