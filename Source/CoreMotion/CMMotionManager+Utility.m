//
//  CMMotionManager+Utility.m
//  Eunomia
//
//  Created by Ian on 12/19/14.
//  Copyright (c) 2014 Eunomia. All rights reserved.
//

#import "CMMotionManager+Utility.h"

@implementation CMMotionManager (Utility)

- (NSOperationQueue *)mainQueue
{
    return [NSOperationQueue mainQueue];
}

- (void)startAccelerometerUpdatesToMainQueueWithHandler:(CMAccelerometerHandler)handler
{
    [self startAccelerometerUpdatesToQueue:[self mainQueue]
                               withHandler:handler];
}

- (void)startDeviceMotionUpdatesToMainQueueWithHandler:(CMDeviceMotionHandler)handler
{
    [self startDeviceMotionUpdatesToQueue:[self mainQueue]
                              withHandler:handler];
}

- (void)startGyroUpdatesToMainQueueWithHandler:(CMGyroHandler)handler
{
    [self startGyroUpdatesToQueue:[self mainQueue]
                      withHandler:handler];
}

- (void)startMagnetometerUpdatesToMainQueueWithHandler:(CMMagnetometerHandler)handler
{
    [self startMagnetometerUpdatesToQueue:[self mainQueue]
                              withHandler:handler];
}


@end
