//
//  JSNetworkRequestHandler.h
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

// for JSNetworkRequestType
#import "JSNetworkRequestObject.h"

// for JSNetworkRequestDelegate
#import "JSNetworkRequest.h"

// forward declaration

// singleton class for handling all the network requests
//
@interface JSNetworkRequestHandler : NSObject
<
JSNetworkRequestDelegate
>
{
    
}

// class method for getting the singleton object
//
+ (JSNetworkRequestHandler*) sharedNetworkRequestHandler;


// public methods for network request
//
- (void) loadDataForNetworkRequest:(JSNetworkRequestType)in_requestType fromURLString:(NSString*)in_strURL;
@end