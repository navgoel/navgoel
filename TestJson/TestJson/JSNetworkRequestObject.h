//
//  JSNetworkRequestObject.h
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

// forward declaration
@protocol JSNetworkRequestDelegate;

// enumerator for type of network request
//
typedef enum
{
    JSNRT_LoadObjectsList = 1,
    JSNRT_LoadObjectImage,
    JSNRT_LoadUserAvatar
} JSNetworkRequestType;

@interface JSNetworkRequestObject : NSObject
{
    
}
// public properties
//
@property (nonatomic, readonly) JSNetworkRequestType                networkRequestType;
@property (nonatomic, copy, readonly) NSString*                     requestURL;

// public methods

// designated intializer
//
- (id) initWithRequestType:(JSNetworkRequestType)in_requestType
           whereRequestURL:(NSString*)in_strRequestURL;
@end
