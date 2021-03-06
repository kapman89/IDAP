//
//  ABWorker.m
//  IDAPCourse
//
//  Created by Andrew Boychuk on 5/9/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import "ABWorker.h"

#import "ABCarWashEnterprise.h"
#import "ABGCDExtension.h"

static NSUInteger ABWorkerSalary    = 2000;
static NSUInteger maxExpirience     = 10;
static NSUInteger nameLength        = 6;
static NSUInteger ABRandomSleep     = 1000;

@interface ABWorker()
@property (nonatomic, assign)   NSUInteger          money;

- (void)sleep;
- (void)performOperationsOnMainThread:(id<ABMoneyFlow>)object;
- (void)performOperationsInBackgroundThread:(id<ABMoneyFlow>)object;

//Methodes for override;
- (void)finishProcess;
- (void)finishProcessingObject:(id<ABMoneyFlow>)object;
- (void)processScpecificOperations:(id<ABMoneyFlow>)object;


@end

@implementation ABWorker

#pragma mark
#pragma mark Initializations and Dealocations

- (void)dealloc {
    self.name = nil;
    self.workerQueue = nil;
    
    [super dealloc];
}

- (instancetype)init{
    self = [super init];
    self.name = [NSString randomStringWithLength:nameLength];
    self.salary = ABWorkerSalary;
    self.experience = ABRandomWithMaxValue(maxExpirience);
    self.state = ABWorkerFree;
    self.workerQueue = [ABQueue object];
    
    return self;
}

#pragma mark
#pragma mark Public Methods

- (void)processObject:(id<ABMoneyFlow>)object {
    @synchronized (self) {
        if (self.state == ABWorkerFree) {
            self.state = ABWorkerBusy;
            [self processObjectInBackgroundThread:object];
        }
    }
}

#pragma mark
#pragma mark Private Methods
- (void)processObjectOnMainThread:(id<ABMoneyFlow>)object {
    ABDispatchAsyncOnMainThread(^{
        [self performOperationsOnMainThread:object];
    });
}

- (void)processObjectInBackgroundThread:(id<ABMoneyFlow>)object {
    ABDispatchAsyncInBackgroundThread(^{
        [self performOperationsInBackgroundThread:object];
        [self processObjectOnMainThread:object];
    });
}

#pragma mark
#pragma mark Private Methods

- (void)performOperationsOnMainThread:(id<ABMoneyFlow>)object {
    [self finishProcess];
    [self finishProcessingObject:object];
}

- (void)performOperationsInBackgroundThread:(id<ABMoneyFlow>)object {
    [self takeMoneyFromObject:object];
    [self processScpecificOperations:object];
    [self sleep];
}

- (void)sleep {
    usleep((uint32_t)ABRandomWithMaxValue(ABRandomSleep));
    NSLog(@"%@ is sleeping", self);
}

//Method created for overriding do not call it directly.
- (void)processScpecificOperations:(id<ABMoneyFlow>)object {
    
}

- (void)setState:(NSUInteger)state {
    @synchronized (self) {
        if (state == self.state) {
            return;
        }
        
        if (state == ABWorkerFree) {
            id object = [self.workerQueue popObjectFromQueue];
            if (object) {
                state = ABWorkerBusy;
                [self processObject:object];
            }
        }
        [super setState:state];
    }
}

- (void)finishProcessingObject:(id<ABMoneyFlow>)object {
    object.state = ABWorkerFree;
}

- (void)finishProcess {
    self.state = ABWorkerReadyForProcess;
}

#pragma mark
#pragma mark ABMoneyFlow Methods

- (void)takeMoney:(NSUInteger)money {
    @synchronized (self) {
        self.money += money;
    }
}

- (NSUInteger)giveMoney {
    @synchronized (self) {
        NSUInteger money = self.money;
        self.money = 0;
        
        return money;
    }
}

- (void)takeMoneyFromObject:(id<ABMoneyFlow>)object {
    @synchronized (self) {
        NSLog(@"%@ got %lu USD from the %@", [self class], object.money, [object class]);
        [self takeMoney:[object giveMoney]];
    }
}

#pragma mark
#pragma mark ABWorkerObserver Methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case ABWorkerBusy:
            return @selector(workerDidBecomeBusy:);
            
        case ABWorkerFree:
            return @selector (workerDidBecomeFree:);
            
        case ABWorkerReadyForProcess:
            return @selector(workerDidBecomeReadyForProcess:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
