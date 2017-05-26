//
//  ABCarWashTest.m
//  IDAPCourse
//
//  Created by Andrew Boychuk on 5/6/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import "ABCarWashTest.h"

#import "NSObject+ABObjectExtension.h"
#import "NSArray+ABExtension.h"

@implementation ABCarWashTest

+ (void)startTest {
    NSArray *cars = [NSArray objectsWithCount:10 factoryBlock:^id{
        return [[ABCar new] autorelease];
    }];

    ABCarWash *carWashCompany = [[[ABCarWash alloc] init] autorelease];
    
    for (ABCar *car in cars) {
        [carWashCompany startWashing:car];
    }
}

@end
