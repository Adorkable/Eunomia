//
//  SSBaseDataSource+Utility.m
//  Solace
//
//  Created by Ian Grossberg on 6/3/14.
//  Copyright (c) 2014 Adorkable. All rights reserved.
//

#import "SSBaseDataSource+Utility.h"

#import "Eunomia.h"

@implementation SSBaseDataSource (Utility)

- (CGFloat)heightForRenderedCellAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat result = 0.f;
    
    UIView *cellView = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    
    if ( [cellView isKindOfClass:[UITableViewCell class] ] )
    {
        UIView *renderInView = [UIApplication sharedApplication].keyWindow;
        
        UITableViewCell *cell = (UITableViewCell *)cellView;
        UIView *contentView = cell.contentView;
        [contentView removeFromSuperview];
        
        [renderInView addSubview:contentView];
        
        NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:contentView
                                                                             attribute:NSLayoutAttributeLeading
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:renderInView
                                                                             attribute:NSLayoutAttributeLeading
                                                                            multiplier:1.0
                                                                              constant:0.0f];
        [renderInView addConstraint:leadingConstraint];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:contentView
                                                                         attribute:NSLayoutAttributeTop
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:renderInView
                                                                         attribute:NSLayoutAttributeTop
                                                                        multiplier:1.0
                                                                          constant:0.0f];
        [renderInView addConstraint:topConstraint];
        
        
        [contentView setNeedsLayout];
        [renderInView layoutIfNeeded];
        
        result = contentView.frame.size.height;
        [contentView removeFromSuperview];
    }
    
    return result;
}

@end
