//
//  ABGCDExtension.h
//  IDAPCourse
//
//  Created by Andrew Boychuk on 7/3/17.
//  Copyright © 2017 Andrew Boychuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABGCDExtension : NSObject

dispatch_queue_t createSerialDispatchQueue();
dispatch_queue_t createConcurrentDispatchQueue();

void dispatchAfterDelay(NSUInteger delay, dispatch_queue_t queue, dispatch_block_t block);

void dispatchSyncOnMainThreadWithBlock(dispatch_block_t block);
void dispatchAsyncOnMainTheradWithBlock(dispatch_block_t block);
void dispatchSyncInBackgroundThread(dispatch_queue_t queue, dispatch_block_t block);
void dispatchAsyncInBackgroundThread(dispatch_queue_t queue, dispatch_block_t block);

@end
