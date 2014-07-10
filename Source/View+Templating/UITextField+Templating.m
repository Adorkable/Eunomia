//
//  UITextField+Templating.m
//  Eunomia
//
//  Created by Ian Grossberg on 11/21/13.
//
//

#import "UITextField+Templating.h"

#import "UIView+Templating.h"

@implementation UITextField (Eunomia_Templating)

- (instancetype)initWithFrame:(CGRect)frame
                  andTemplate:(UITextField *)template
{
    self = [self initWithFrame:frame];
    if (self)
    {
        [self applyTemplate:template];
    }
    return self;
}

// TODO: traverse array of properties to copy over rather than explicitly assign
- (void)applyTemplate:(UIView *)baseTemplate
{
    [super applyTemplate:baseTemplate];

    if ( [baseTemplate isKindOfClass:[UITextField class] ] )
    {
        UITextField *template = (UITextField *)baseTemplate;
        
//        self.text = template.text;
//        self.attributedText = template.attributedText;
        self.textColor = template.textColor;
        self.font = template.font;
        self.textAlignment = template.textAlignment;
        self.borderStyle = template.borderStyle;
//        self.defaultTextAttributes = template.defaultTextAttributes;
        
        self.placeholder = template.placeholder;
//        self.attributedPlaceholder = template.attributedPlaceholder;
        self.clearsOnBeginEditing = template.clearsOnBeginEditing;
        self.adjustsFontSizeToFitWidth = template.adjustsFontSizeToFitWidth;
        self.minimumFontSize = template.minimumFontSize;
        self.delegate = template.delegate;
        self.background = template.background;
        self.disabledBackground = template.disabledBackground;

        self.allowsEditingTextAttributes = template.allowsEditingTextAttributes;
//        self.typingAttributes = template.typingAttributes;

        self.clearButtonMode = template.clearButtonMode;
        
        self.leftView = template.leftView;
        self.leftViewMode = template.leftViewMode;
        
        self.rightView = template.rightView;
        self.rightViewMode = template.rightViewMode;
        
        self.inputView = template.inputView;
        self.inputAccessoryView = template.inputAccessoryView;
        
        self.clearsOnInsertion = template.clearsOnInsertion;
        
#pragma mark UITextInput
//        self.selectedTextRange = template.selectedTextRange;
        self.markedTextStyle = template.markedTextStyle;
        
        self.inputDelegate = template.inputDelegate;
        
//        self.selectionAffinity = template.selectionAffinity;
        
        
#pragma mark UITextInputTraits
        self.autocapitalizationType = template.autocapitalizationType;
        self.autocorrectionType = template.autocorrectionType;
        self.spellCheckingType = template.spellCheckingType;
        self.keyboardType = template.keyboardType;
        self.keyboardAppearance = template.keyboardAppearance;
        self.returnKeyType = template.returnKeyType;
        self.enablesReturnKeyAutomatically = template.enablesReturnKeyAutomatically;
        self.secureTextEntry = template.secureTextEntry;
    }
}

@end
