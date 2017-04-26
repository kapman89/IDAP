//
//  ABCreature.m
//  IDAPCourse
//
//  Created by Andrew Boychuk on 20.04.17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import "ABCreature.h"

@interface ABCreature()

@property (nonatomic, retain) NSMutableArray *mutableChildrens;

@end

@implementation ABCreature

@dynamic childrens;

#pragma mark
#pragma mark Initializations and Dealocations

- (void)dealloc {
    self.mutableChildrens = nil;
    self.name = nil;
    
    [super dealloc];
}

- (instancetype)init {
    [super init];
    if (self) {
        self.name = [NSString stringWithFormat:@"%c", arc4random_uniform(26) + 'A'];
        self.weight = arc4random_uniform(120);
        self.age = arc4random_uniform(80);
        self.mutableChildrens = [NSMutableArray array];
    }
    return self;
}

#pragma mark
#pragma mark Class Methods

- (NSArray *)childrens {
    return [[self.mutableChildrens copy] autorelease];
}

- (void)sayHello {
    NSLog(@"Hello from %@!", self.name);
    for (ABCreature* child in self.childrens) {
        [child sayHello];
    }
}

- (void)addChild:(ABCreature *)child {
    [self.mutableChildrens addObject:child];
}

- (void)deleteChild:(ABCreature *)child {
    [self.mutableChildrens removeObject:child];
}

- (void)performGenderSpecificOperation {
    
}

@end

