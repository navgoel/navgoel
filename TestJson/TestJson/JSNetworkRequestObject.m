//
//  JSNetworkRequestObject.m
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSNetworkRequestObject.h"

// category extension for internal variables
@interface JSNetworkRequestObject()
{
    // network request type
    JSNetworkRequestType m_networkRequestType;
    
    // network request url
    NSString* m_strRequestURL;    
}

// properties

@end


@implementation JSNetworkRequestObject
// synthesizes
@synthesize networkRequestType = m_networkRequestType;
@synthesize requestURL = m_strRequestURL;

#pragma mark NSObject
- (id) initWithRequestType:(JSNetworkRequestType)in_requestType
           whereRequestURL:(NSString*)in_strRequestURL
{
    self = [super init];
    NSAssert(self, @"could not initialize self");
    
    NSAssert(in_strRequestURL.length, @"request URL is empty");
    
    if (self)
    {
        // initialization
        //
        m_networkRequestType = in_requestType;
        
        m_strRequestURL = [in_strRequestURL copy];
    }
    
    return self;
}

- (void) dealloc
{
    [m_strRequestURL release];
    [super dealloc];
}

@end
