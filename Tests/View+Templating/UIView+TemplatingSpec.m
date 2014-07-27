#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import "UIView+Templating.h"

SpecBegin(UIView_Templating)

describe(@"", ^{
    UIView *(^createInitialized)() = ^UIView *()
    {
        UIView *view = [ [UIView alloc] init];
        ^(UIView *self)
        {
            self.userInteractionEnabled = YES;
            self.contentScaleFactor = 1.0f;
            
            self.multipleTouchEnabled = YES;
            self.exclusiveTouch = YES;
            
            self.autoresizesSubviews = YES;
            self.autoresizingMask = 1;
            
            self.clipsToBounds = YES;
            self.backgroundColor = [UIColor redColor];
            self.alpha = 0.5f;
            self.opaque = NO;
            self.clearsContextBeforeDrawing = YES;
            self.hidden = YES;
            self.contentMode = UIViewContentModeLeft;
            
            self.tintColor = [UIColor greenColor];
            self.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
        }(view);
        return view;
    };
    
    it(@"applyTemplate", ^{
        UIView *template = createInitialized();
        
        UIView *testView = [ [UIView alloc] init];
        {
            [testView applyTemplate:template];
            
            expect(testView.userInteractionEnabled).to.equal(template.userInteractionEnabled);
            expect(testView.contentScaleFactor).to.equal(template.contentScaleFactor);
            
            expect(testView.multipleTouchEnabled).to.equal(template.multipleTouchEnabled);
            expect(testView.exclusiveTouch).to.equal(template.exclusiveTouch);
            
            expect(testView.autoresizesSubviews).to.equal(template.autoresizesSubviews);
            expect(testView.autoresizingMask).to.equal(template.autoresizingMask);
            
            expect(testView.clipsToBounds).to.equal(template.clipsToBounds);
            expect(testView.backgroundColor).to.equal(template.backgroundColor);
            expect(testView.alpha).to.equal(template.alpha);
            expect(testView.opaque).to.equal(template.opaque);
            expect(testView.clearsContextBeforeDrawing).to.equal(template.clearsContextBeforeDrawing);
            expect(testView.hidden).to.equal(template.hidden);
            expect(testView.contentMode).to.equal(template.contentMode);
            
            expect(testView.tintColor).to.equal(template.tintColor);
            expect(testView.tintAdjustmentMode).to.equal(template.tintAdjustmentMode);
        }
    });
});

SpecEnd
