//
//  JSUserInfo.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSUserInfo.h"


static NSString* const sNameHref =              @"name";
static NSString* const sUserAvatar =            @"avatar";
static NSString* const sAvatarSrc =             @"src";
static NSString* const sAvatarWidth =           @"width";
static NSString* const sAvatarHeight =          @"height";
static NSString* const sUserName    =           @"username";

// category extension for internal variables
//
@interface JSUserInfo()
{
    // name of user
    //
    NSString* m_strName;
    
    // url to user avatar
    //
    NSString* m_strUserAvatarImageURL;
    
    // user avatar width
    NSInteger m_iUserAvatarImageWidth;

    // user avatar height
    NSInteger m_iUserAvatarImageHeight;
    
    // username
    NSString* m_strUserName;
}
@end

@implementation JSUserInfo

// synthesizes

@synthesize name = m_strName;
@synthesize userAvatarImageURL = m_strUserAvatarImageURL;
@synthesize userAvatarImageWidth = m_iUserAvatarImageWidth;
@synthesize userAvatarImageHeight = m_iUserAvatarImageHeight;
@synthesize userName = m_strUserName;


#pragma mark NSObject
- (id) initWithUserInfoDictionary:(NSDictionary*)in_userInfoDictionary
{
    self = [super init];
    NSAssert(self, @"couldn't initialize self");
    
    if (self)
    {
        // initialize
        m_strName = [[in_userInfoDictionary objectForKey:sNameHref] copy];
        m_strUserAvatarImageURL = [[[in_userInfoDictionary objectForKey:sUserAvatar] objectForKey:sAvatarSrc] copy];
        
        NSNumber* l_numWidth = [[in_userInfoDictionary objectForKey:sUserAvatar] objectForKey:sAvatarWidth];
        m_iUserAvatarImageWidth = l_numWidth.integerValue;
        
        NSNumber* l_numHeight = [[in_userInfoDictionary objectForKey:sUserAvatar] objectForKey:sAvatarHeight];
        m_iUserAvatarImageHeight = l_numHeight.integerValue;
        
        m_strUserName = [[in_userInfoDictionary objectForKey:sUserName] copy];
    }

    return self;
}

- (void) dealloc
{
    [m_strName release];
    [m_strUserAvatarImageURL release];
    [m_strUserName release];
    
    [super dealloc];
}

@end
