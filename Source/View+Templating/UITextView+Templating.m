//
//  UITextView+Templating.m
//  Eunomia
//
//  Created by Ian Grossberg on 2/10/14.
//
//

#import "UITextView+Templating.h"

@implementation UITextView (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UITextView *)template
{
    self = [self initWithFrame:frame];
    if (self)
    {
        [self applyTemplate:template];
    }
    return self;
}

- (void)applyTemplate:(UIView *)baseTemplate
{
    [super applyTemplate:baseTemplate];
    
    if ( [baseTemplate isKindOfClass:[UITextView class] ] )
    {
        UITextView *template = (UITextView *)baseTemplate;
        
        self.delegate = template.delegate;

        self.clearsOnInsertion = template.clearsOnInsertion; // resets things like selectedRange, needs to be early

        self.text = template.text;
        self.attributedText = template.attributedText;
        
        self.font = template.font;
        self.textColor = template.textColor;
        self.textAlignment = template.textAlignment;
        self.selectedRange = template.selectedRange;
        self.editable = template.editable;
        self.selectable = template.selectable;
        self.dataDetectorTypes = template.dataDetectorTypes;
        self.allowsEditingTextAttributes = template.allowsEditingTextAttributes;
        self.typingAttributes = template.typingAttributes;
        
        self.inputView = template.inputView;
        self.inputAccessoryView = template.inputAccessoryView;
        
        self.textContainerInset = template.textContainerInset;
        
        self.linkTextAttributes = template.linkTextAttributes;
    }
}

@end
