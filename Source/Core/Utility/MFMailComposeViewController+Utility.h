//
//  MFMailComposeViewController+Utility.h
//  Eunomia
//
//  Created by Ian on 1/26/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import <MessageUI/MessageUI.h>

@interface MFMailComposeViewController (Eunomia_Utility)

@property (copy) void(^didFinishHandler)(MFMailComposeResult result, NSError *error);

@end
