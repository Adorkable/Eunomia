#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "LaunchView.h"

SpecBegin(LaunchView)

describe(@"init", ^{
    it(@"init", ^{
        LaunchView *launchView = [ [LaunchView alloc] init];
        expect(launchView.sharedInitCallCount).to.equal(1);
    });
    
    it(@"initWithCoder:", ^{
        id coder = OCMClassMock( [NSCoder class] );
        
        LaunchView *launchView = [ [LaunchView alloc] initWithCoder:coder];
        expect(launchView.sharedInitCallCount).to.equal(1);
    });
    
    it(@"initWithFrame:", ^{
        LaunchView *launchView = [ [LaunchView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) ];
        expect(launchView.sharedInitCallCount).to.equal(1);
    });
    
    it(@"initWithImage:", ^{
        id image = OCMClassMock( [UIImage class] );
        
        LaunchView *launchView = [ [LaunchView alloc] initWithImage:image];
        expect(launchView.sharedInitCallCount).to.equal(1);
    });
    
    it(@"initWithImage:highlightedImage:", ^{
        id image = OCMClassMock( [UIImage class] );
        
        LaunchView *launchView = [ [LaunchView alloc] initWithImage:image highlightedImage:image];
        expect(launchView.sharedInitCallCount).to.equal(1);
    });
});

SpecEnd
