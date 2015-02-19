//
//  MFMailComposeViewController+Utility.m
//  Eunomia
//
//  Created by Ian on 1/26/15.
//  Copyright (c) 2015 Eunomia. All rights reserved.
//

#import "MFMailComposeViewController+Utility.h"

#import "NSObject+Utility.h"

@interface MFMailComposeViewControllerDelegate : NSObject<MFMailComposeViewControllerDelegate>

@property (copy) void(^didFinishHandler)(MFMailComposeResult result, NSError *error);

@end

@implementation MFMailComposeViewController (Eunomia_Utility)

- (void)setDidFinishHandler:(void (^)(MFMailComposeResult, NSError *) )didFinishWithResult
{
    MFMailComposeViewControllerDelegate *delegate;
    if (didFinishWithResult)
    {
        delegate = [ [MFMailComposeViewControllerDelegate alloc] init];
        delegate.didFinishHandler = didFinishWithResult;
        self.mailComposeDelegate = delegate;
    }
    [self setProtocolRetainProperty:@selector(didFinishHandler) value:delegate];
}

- (void(^)(MFMailComposeResult, NSError *) )didFinishHandler
{
    void(^result)(MFMailComposeResult, NSError *);
    
    id delegateObject = [self getProtocolProperty:@selector(didFinishHandler) ];
    if ( [delegateObject isKindOfClass:[MFMailComposeViewControllerDelegate class] ] )
    {
        MFMailComposeViewControllerDelegate *delegate = delegateObject;
        result = delegate.didFinishHandler;
    }
    
    return result;
}

@end

@implementation MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (self.didFinishHandler)
    {
        self.didFinishHandler(result, error);
    }
}

@end