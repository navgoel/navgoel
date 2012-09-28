//
//  JSObject.h
//  TestJson
//
//  Created by Navin Goel on 9/27/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import <Foundation/Foundation.h>

// forward declaration
@class JSUserInfo;

@interface JSObject : NSObject
{
    
}
// property
@property (nonatomic, copy) NSString*       hrefOfObject;
@property (nonatomic, copy) NSString*       imageURLOfObject;
@property (nonatomic, copy) NSString*       descriptionOfObject;
@property (nonatomic, copy) NSString*       attributeOfObject;
@property (nonatomic, retain) JSUserInfo*   userInfo;


// designated initializers
//
- (id) initWithObjectDictionary:(NSDictionary*)in_objectDictionary;


@end
