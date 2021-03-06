//
//  ABCarWasher.m
//  IDAPCourse
//
//  Created by Andrew Boychuk on 28.04.17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import "ABCarWasher.h"

#import "ABCar.h"

@interface ABCarWasher ()

- (void)wash:(ABCar *)car;

@end

@implementation ABCarWasher

#pragma mark
#pragma mark Private Methods

- (void)processScpecificOperations:(ABCar *)car {
    [self wash:car];
}
- (void)wash:(ABCar *)car {
    NSLog(@"Washer %@  washed car", self);
}

- (void)finishProcessingObject:(id<ABMoneyFlow>)object {
    object.state = ABCarStateClean;
}

@end
