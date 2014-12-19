//
//  CMMotionManager+Utility.h
//  Eunomia
//
//  Created by Ian on 12/19/14.
//  Copyright (c) 2014 Eunomia. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

@interface CMMotionManager (Utility)

- (void)startAccelerometerUpdatesToMainQueueWithHandler:(CMAccelerometerHandler)handler;
- (void)startDeviceMotionUpdatesToMainQueueWithHandler:(CMDeviceMotionHandler)handler;
- (void)startGyroUpdatesToMainQueueWithHandler:(CMGyroHandler)handler;
- (void)startMagnetometerUpdatesToMainQueueWithHandler:(CMMagnetometerHandler)handler;

@end
