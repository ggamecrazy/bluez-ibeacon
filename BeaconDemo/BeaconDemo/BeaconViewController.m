#import "BeaconViewController.h"

@interface BeaconViewController ()

@end

@implementation BeaconViewController
{
    CLLocationManager *locationManager;
}

- (void)loadView
{
    locationManager = [[CLLocationManager alloc] init];
    
    [super loadView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    locationManager.delegate = self;
    
    
    NSString *uuid = [[NSUserDefaults standardUserDefaults] stringForKey:@"BeaconUUID"];
    [self.uuidLabel setText:uuid];
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] identifier:BEACON_ID];
    
    region.notifyOnEntry = YES;
    region.notifyOnExit = YES;
    region.notifyEntryStateOnDisplay = YES;
    
    [locationManager startMonitoringForRegion:region];
    [locationManager requestStateForRegion:region];
    
    
    [self.distanceLabel setText:@"Unknown"];
    [self.minorLabel setText:@""];
    [self.majorLabel setText:@""];
    [self.numberofBeaconsLabel setText:@"0"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    locationManager.delegate = nil;
}

- (IBAction)monitoringAction:(id)sender
{
    NSString *uuid = [[NSUserDefaults standardUserDefaults] stringForKey:@"BeaconUUID"];
    
    if(!self.monitoringSwitch.on)
    {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] identifier:BEACON_ID];
        
        region = [locationManager.monitoredRegions member:region];
        
        if(region)
        {
            [locationManager stopMonitoringForRegion:region];
            [locationManager stopRangingBeaconsInRegion:region];
        }
        [self.distanceLabel setText:@""];
        [self.minorLabel setText:@""];
        [self.majorLabel setText:@""];
        [self.numberofBeaconsLabel setText:@""];
        [self.stateLabel setText:@""];
    }
    else
    {
        
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:uuid] identifier:BEACON_ID];
        
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        region.notifyEntryStateOnDisplay = YES;
        
        [locationManager startMonitoringForRegion:region];
        [locationManager requestStateForRegion:region];
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    CLBeaconRegion *beaconRegion = (CLBeaconRegion *) region;
    switch (state)
    {
        case CLRegionStateInside:
            self.stateLabel.text = @"Inside";
            [locationManager startRangingBeaconsInRegion:beaconRegion];
            break;
            
        case CLRegionStateOutside:
            self.stateLabel.text = @"Outside";
            [self outsideRegionfor:beaconRegion];
            break;
            
        case CLRegionStateUnknown:
        default:
            self.stateLabel.text = @"Unknown";
            [self outsideRegionfor:beaconRegion];
            
            break;
    }
}

- (void) outsideRegionfor: (CLBeaconRegion*) beaconRegion{
    [locationManager stopRangingBeaconsInRegion:beaconRegion];
    [self.minorLabel setText:@""];
    [self.majorLabel setText:@""];
    [self.numberofBeaconsLabel setText:@"0"];
    
}
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        CLBeaconRegion *beaconRegion = (CLBeaconRegion *)region;
        if ([beaconRegion.identifier isEqualToString:BEACON_ID]) {
            [locationManager startRangingBeaconsInRegion:beaconRegion];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    [self.numberofBeaconsLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)beacons.count ]];
    CLBeacon *beacon = [beacons objectAtIndex:0];//Just grab the first one, Would use a table view to show all available beacons in future
    
    if (beacon) {
        [self setDistanceLabelForProximity:beacon.proximity];
        [self setMajorMinorLabelsForBeacon:beacon];
    }
}

- (void)setDistanceLabelForProximity:(CLProximity) proximity{
    switch (proximity) {
        case CLProximityUnknown:
            [self.distanceLabel setText:@"Unknown"];
            break;
            
        case CLProximityFar:
            [self.distanceLabel setText:@"Far"];
            break;
            
        case CLProximityNear:
            [self.distanceLabel setText:@"Near"];
            break;
            
        case CLProximityImmediate:
            [self.distanceLabel setText:@"Immediate"];
            break;
            
        default:
            break;
    }
}

- (void)setMajorMinorLabelsForBeacon: (CLBeacon*) beacon{
    [self.majorLabel setText:[NSString stringWithFormat:@"%@", beacon.major]];
    [self.minorLabel setText:[NSString stringWithFormat:@"%@", beacon.minor]];
}

@end
