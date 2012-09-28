//
//  JSUserInfo.h
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSUserInfo : NSObject
{
    
}
// properties

@property (nonatomic,copy) NSString*         name;
@property (nonatomic,copy) NSString*         userAvatarImageURL;
@property (nonatomic,readwrite) NSInteger    userAvatarImageWidth;
@property (nonatomic,readwrite) NSInteger    userAvatarImageHeight;
@property (nonatomic,copy) NSString*         userName;

// public methods

// designated initializers
- (id) initWithUserInfoDictionary:(NSDictionary*)in_userInfoDictionary;

@end
