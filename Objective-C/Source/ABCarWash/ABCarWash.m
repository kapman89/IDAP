//
//  ABCarWash.m
//  IDAPCourse
//
//  Created by Andrew Boychuk on 5/4/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import "ABCarWash.h"

@interface ABCarWash ()
@property (nonatomic, retain)   NSMutableArray  *mutableBuildings;
@property (nonatomic, retain)   NSMutableArray  *mutableCars;

@end

@implementation ABCarWash

@dynamic buildings;
@dynamic cars;


#pragma mark -
#pragma mark - Initializations and Deallocations

- (void)dealloc {
    self.mutableBuildings = nil;
    self.mutableCars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    self.mutableBuildings = [NSMutableArray array];
    self.mutableCars = [NSMutableArray array];
    
    return self;
}

#pragma mark -
#pragma mark - Accessors

- (NSArray *)buildings {
    return [[self.mutableBuildings copy] autorelease];
}

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

#pragma mark
#pragma mark Public Methods

- (void)addBuilding:(ABBuilding *)building {
    if (building) {
    [self.mutableBuildings addObject:building];
    }
}

- (void)removeBuilding:(ABBuilding *)building {
    [self.mutableBuildings removeObject:building];
}

- (void)addCar:(ABCar *)car {
    if (car) {
        [self.mutableCars addObject:car];
    }
}

- (void)removeCar:(ABCar *)car {
    [self.mutableCars removeObject:car];
}


@end
