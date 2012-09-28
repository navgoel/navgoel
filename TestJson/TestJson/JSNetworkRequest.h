//
//  JSNetworkRequest.h
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

// forward declaration
@class JSNetworkRequestObject;

@protocol JSNetworkRequestDelegate <NSObject>

// delegate called after successfull response from server/url
//
- (void) didFinishLoadingSuccessfullyNetworkObject:(JSNetworkRequestObject*)theNetworkObject withResponse:(NSData*)theResponseData;

// in case of failure
- (void) didFailedLoadingNetworkObject:(JSNetworkRequestObject*)theNetworkObject withError:(NSError *)theError;

@end


@interface JSNetworkRequest : NSObject
<
NSURLConnectionDelegate
>
{
    // member variables
}
// properties


// class methods


// public methods

// loads the content from the initialized url
//
- (void) load;

// designated initializers
- (id) initWithNetworkObject:(JSNetworkRequestObject*)theObject andNetworkDelegate:(id <JSNetworkRequestDelegate>) theNetworkDelegate;


@end
