#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <UIKit/UIKit.h>

#import "UITextView+Templating.h"

SpecBegin(UITextView_Templating)

describe(@"", ^{
    UITextView *(^createInitialized)() = ^UITextView *()
    {
        UITextView *view = [ [UITextView alloc] init];
        ^(UITextView *self)
        {
            self.delegate = OCMProtocolMock( @protocol(UITextViewDelegate) );
            self.font = [UIFont italicSystemFontOfSize:10];
            self.textColor = [UIColor redColor];
            self.textAlignment = NSTextAlignmentRight;
            self.selectedRange = NSMakeRange(2, 1);
            self.editable = YES;
            self.selectable = YES;
            self.dataDetectorTypes = UIDataDetectorTypeCalendarEvent;
            self.allowsEditingTextAttributes = YES;
            //        self.attributedText = template.attributedText;
            //        self.typingAttributes = template.typingAttributes;
            
            self.inputView = [ [UIView alloc] init];
            self.inputAccessoryView = [ [UIView alloc] init];
            
            self.clearsOnInsertion = YES;
            
            self.textContainerInset = UIEdgeInsetsMake(10, 10, 5, 5);
            
            self.linkTextAttributes = @{};
        }(view);
        return view;
    };
    
    void (^testProperties)(UITextView *template, UITextView *testView) = ^void(UITextView *template, UITextView *testView)
    {
        expect(testView.delegate).to.equal(template.delegate);
        expect(testView.font).to.equal(template.font);
        expect(testView.textColor).to.equal(template.textColor);
        expect(testView.selectedRange.location).to.equal(template.selectedRange.location);
        expect(testView.selectedRange.length).to.equal(template.selectedRange.length);
        expect(testView.editable).to.equal(template.editable);
        expect(testView.selectable).to.equal(template.selectable);
        expect(testView.dataDetectorTypes).to.equal(template.dataDetectorTypes);
        expect(testView.allowsEditingTextAttributes).to.equal(template.allowsEditingTextAttributes);
        
        expect(testView.inputView).to.equal(template.inputView);
        expect(testView.inputAccessoryView).to.equal(template.inputAccessoryView);
        
        expect(testView.clearsOnInsertion).to.equal(template.clearsOnInsertion);
        
        expect(testView.textContainerInset).to.equal(template.textContainerInset);
        
        expect(testView.linkTextAttributes).to.equal(template.linkTextAttributes);
    };
    
    it(@"plain text", ^{
        UITextView *template = createInitialized();
        template.text = @"test";
        template.selectedRange = NSMakeRange(1, 2);
        
        UITextView *testView = [ [UITextView alloc] init];
        {
            [testView applyTemplate:template];
            
            testProperties(template, testView);
            expect(testView.text).to.equal(template.text);
        }
    });
    
    it(@"attributed text", ^{
        UITextView *template = createInitialized();
        template.attributedText = [ [NSAttributedString alloc] initWithString:@"test" attributes:@{}];
        template.selectedRange = NSMakeRange(1, 2);
        
        UITextView *testView = [ [UITextView alloc] init];
        {
            [testView applyTemplate:template];
            
            testProperties(template, testView);
            expect(testView.attributedText.string).to.equal(template.attributedText.string);
        }
    });
});

SpecEnd
