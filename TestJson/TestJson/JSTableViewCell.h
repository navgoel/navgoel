//
//  JSTableViewCell.h
//  TestJson
//
//  Created by Navin Goel on 9/28/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSTableViewCell : UITableViewCell
{
    
}

// static method for height requirement
//
+ (CGFloat) heightOfTableViewCell;

// public methods
// set cell information
//
- (void) setCellInfoWhereObjectImage:(UIImage*)in_objectImage
                   objectDescription:(NSString*)in_strObjectDescription
                objectAttributeLabel:(NSString*)in_strObjectAttribute
                     userAvatarImage:(UIImage*)in_userAvatarImage
                            userName:(NSString*) in_strUserName
                             andName:(NSString*) in_strName;

@end
