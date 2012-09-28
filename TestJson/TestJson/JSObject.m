//
//  JSObject.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSObject.h"
#import "JSUserInfo.h"

static NSString* const sObjectHref =            @"href";
static NSString* const sObjectImageSrc =        @"src";
static NSString* const sObjectDesc =            @"desc";
static NSString* const sObjectAttrib =          @"attrib";
static NSString* const sObjectUSer =            @"user";

// category extension for internal variables
//
@interface JSObject()
{
    // link to pinterest
    //
    NSString* m_strHrefOfObject;
    
    // url of image for the object
    NSString* m_strImageURLOfObject;
    
    // object description
    NSString* m_strDescriptionOfObject;
    
    // object attribute
    //
    NSString* m_strAttributeOfObject;
    
    // Userinfo object
    JSUserInfo* m_userInfo;
}
// properties

@end

@implementation JSObject

// synthesizes
@synthesize hrefOfObject = m_strHrefOfObject;
@synthesize imageURLOfObject = m_strImageURLOfObject;
@synthesize descriptionOfObject = m_strDescriptionOfObject;
@synthesize attributeOfObject = m_strAttributeOfObject;
@synthesize userInfo = m_userInfo;

#pragma mark NSObject
- (id) initWithObjectDictionary:(NSDictionary*)in_objectDictionary
{
    self = [super init];
    NSAssert(self, @"couldn't initialize self");
    
    if (self)
    {
        // initialize
        m_strHrefOfObject = [[in_objectDictionary objectForKey:sObjectHref] copy];
        m_strImageURLOfObject = [[in_objectDictionary objectForKey:sObjectImageSrc] copy];
        m_strDescriptionOfObject = [[in_objectDictionary objectForKey:sObjectDesc] copy];
        m_strAttributeOfObject = [[in_objectDictionary objectForKey:sObjectAttrib] copy];

        m_userInfo = [[JSUserInfo alloc] initWithUserInfoDictionary:[in_objectDictionary objectForKey:sObjectUSer]];
    }
        
    
    return self;
}

- (void) dealloc
{
    [m_strHrefOfObject release];
    [m_strImageURLOfObject release];
    [m_strDescriptionOfObject release];
    [m_strAttributeOfObject release];
    [m_userInfo release];
    
    [super dealloc];
}

@end
