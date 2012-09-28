//
//  JSTableViewCell.m
//  TestJson
//
//  Created by Navin Goel on 9/28/12.
//  Copyright (c) 2012 Navin Goel. All rights reserved.
//

#import "JSTableViewCell.h"

#define JS_DESCRIPTION_FONT_SIZE        18.0
#define JS_ATTRIBUTE_FONT_SIZE          16.0
#define JS_NAME_FONT_SIZE               16.0

#define JS_AVATAR_WIDTH                 40.0
#define JS_AVATAR_HEIGHT                40.0


#define JS_OBJECT_WIDTH                 80.0
#define JS_OBJECT_HEIGHT                80.0


#define JS_BORDER_OFFSET_2              2.0
#define JS_BORDER_OFFSET_4              4.0
#define JS_BORDER_OFFSET                10.0


// category extension for private ivars
@interface JSTableViewCell()
{
    // object image view
    UIImageView* m_objectImageView;
    
    // object description label
    UILabel* m_objectDescriptionLabel;
    
    // object attribute
    UILabel* m_objectAttributeLabel;
    
    // user image avatar
    UIImageView* m_userAvatarImageView;
    
    // username
    UILabel* m_userNameLabel;
    
    // username
    UILabel* m_nameLabel;

}

// properties
@property (nonatomic, retain) UIImageView* objectImageView;
@property (nonatomic, retain) UILabel* objectDescriptionLabel;
@property (nonatomic, retain) UILabel* objectAttributeLabel;
@property (nonatomic, retain) UIImageView* userAvatarImageView;
@property (nonatomic, retain) UILabel* userNameLabel;
@property (nonatomic, retain) UILabel* nameLabel;


@end


@implementation JSTableViewCell

// synthesizes
@synthesize objectImageView = m_objectImageView;
@synthesize objectDescriptionLabel = m_objectDescriptionLabel;
@synthesize objectAttributeLabel = m_objectAttributeLabel;
@synthesize userAvatarImageView = m_userAvatarImageView;
@synthesize userNameLabel = m_userNameLabel;
@synthesize nameLabel = m_nameLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        
        // object image
        {
            self.objectImageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
            self.objectImageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        // object description
        {
            self.objectDescriptionLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
            self.objectDescriptionLabel.backgroundColor = [UIColor clearColor];
			self.objectDescriptionLabel.textColor = [UIColor blackColor];
            UIFont* l_font = [UIFont fontWithName:@"Helvetica-Bold" size:JS_DESCRIPTION_FONT_SIZE];
            self.objectDescriptionLabel.font = l_font;
        }
        
        
        // object attribute
        {
            self.objectAttributeLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
            self.objectAttributeLabel.backgroundColor = [UIColor clearColor];
			self.objectAttributeLabel.textColor = [UIColor blueColor];
            UIFont* l_font = [UIFont fontWithName:@"Helvetica-Bold" size:JS_ATTRIBUTE_FONT_SIZE];
            self.objectAttributeLabel.font = l_font;
        }
        
        // avatar image
        {
            self.userAvatarImageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
            self.userAvatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        // user name
        {
            self.userNameLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
            self.userNameLabel.backgroundColor = [UIColor clearColor];
			self.userNameLabel.textColor = [UIColor darkGrayColor];
            UIFont* l_font = [UIFont fontWithName:@"Helvetica-Bold" size:JS_NAME_FONT_SIZE];
            self.userNameLabel.font = l_font;
        }

        //  name
        {
            self.nameLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
            self.nameLabel.backgroundColor = [UIColor clearColor];
			self.nameLabel.textColor = [UIColor darkGrayColor];
            UIFont* l_font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:JS_NAME_FONT_SIZE];
            self.nameLabel.font = l_font;
        }

#if 0
        // debugging code
        self.objectDescriptionLabel.backgroundColor = [UIColor redColor];
        self.objectAttributeLabel.backgroundColor = [UIColor yellowColor];
        self.userNameLabel.backgroundColor = [UIColor greenColor];
        self.nameLabel.backgroundColor = [UIColor orangeColor];
#endif
        
        // add sub views
        //
        [self.contentView addSubview:self.objectImageView];
        [self.contentView addSubview:self.objectDescriptionLabel];
        [self.contentView addSubview:self.objectAttributeLabel];
        [self.contentView addSubview:self.userAvatarImageView];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGGradientRef glossGradient = nil;
    CGColorSpaceRef rgbColorspace = nil;
    
    //Give two locations
    size_t numLocations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    
    //Two color components, white(1 1 1 1) and a kind of grey
//    CGFloat components[8] = { 1, 1, 1, 1, 245.0/255, 245.0/255, 245.0/255, 1 };
//    CGFloat components[8] = { 150.9/255, 150.0/255, 150.0/255, 1, 205.0/255, 205.0/255, 205.0/255, 1 };
    CGFloat components[8] = { 180.9/255, 180.0/255, 180.0/255, 1, 225.0/255, 225.0/255, 225.0/255, 1 };


    
    //Create the gradient
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, numLocations);
    
    //Set the gradient range.
    CGRect currentBounds = self.bounds;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0);
    CGPoint bottomCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMaxY(currentBounds));
    
    // draw the gradient.
    CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, bottomCenter, 0);
    
    // Release our CG objects.
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
}


- (void) dealloc
{
    [m_objectImageView release];
    [m_objectDescriptionLabel release];
    [m_objectAttributeLabel release];
    [m_userAvatarImageView release];
    [m_userNameLabel release];

    [super dealloc];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect l_contentViewBounds = self.contentView.bounds;
    
    CGRect l_objectImageViewFrame = CGRectZero;
    CGRect l_objectDescriptionLabelFrame = CGRectZero;
    CGRect l_objectAttributeLabelFrame = CGRectZero;
    CGRect l_avatarImageViewFrame = CGRectZero;
    CGRect l_userNameLabelFrame = CGRectZero;
    CGRect l_nameLabelFrame = CGRectZero;
    
//    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad &&
//             ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft ||
//              [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight))


    // object image
    {
        l_objectImageViewFrame = CGRectMake(JS_BORDER_OFFSET,
                                            JS_BORDER_OFFSET,
                                            JS_OBJECT_WIDTH,
                                            JS_OBJECT_HEIGHT);
        
        self.objectImageView.frame = l_objectImageViewFrame;
    }
    
    // object description
    //
    {
        CGFloat l_fXCoordinate = l_objectImageViewFrame.origin.x + l_objectImageViewFrame.size.width + JS_BORDER_OFFSET;
        l_objectDescriptionLabelFrame = CGRectMake(l_fXCoordinate,
                                                   l_objectImageViewFrame.origin.y,
                                                   l_contentViewBounds.size.width - l_fXCoordinate - JS_BORDER_OFFSET,
                                                   JS_DESCRIPTION_FONT_SIZE + JS_BORDER_OFFSET_2);
        self.objectDescriptionLabel.frame = l_objectDescriptionLabelFrame;
    }

    // object attribute
    //
    {
        l_objectAttributeLabelFrame = CGRectMake(l_objectDescriptionLabelFrame.origin.x,
                                                   l_objectDescriptionLabelFrame.origin.y + l_objectDescriptionLabelFrame.size.height + JS_BORDER_OFFSET_2,
                                                   l_objectDescriptionLabelFrame.size.width,
                                                   JS_ATTRIBUTE_FONT_SIZE + JS_BORDER_OFFSET_2);
        self.objectAttributeLabel.frame = l_objectAttributeLabelFrame;
    }
    
    // avatar image
    //
    {
        l_avatarImageViewFrame = CGRectMake(l_objectAttributeLabelFrame.origin.x,
                                            l_objectAttributeLabelFrame.origin.y + l_objectAttributeLabelFrame.size.height + JS_BORDER_OFFSET_4,
                                            JS_AVATAR_WIDTH,
                                            JS_AVATAR_HEIGHT);
        
        self.userAvatarImageView.frame = l_avatarImageViewFrame;
    }
    
    // user name
    {
        CGFloat l_fXCoordinate = l_avatarImageViewFrame.origin.x + l_avatarImageViewFrame.size.width + JS_BORDER_OFFSET;
        l_userNameLabelFrame = CGRectMake(l_fXCoordinate,
                                          l_avatarImageViewFrame.origin.y,
                                          l_contentViewBounds.size.width - l_fXCoordinate - JS_BORDER_OFFSET,
                                          JS_NAME_FONT_SIZE + JS_BORDER_OFFSET_2);
        self.userNameLabel.frame = l_userNameLabelFrame;
    }

    // name
    {
        l_nameLabelFrame = CGRectMake(l_userNameLabelFrame.origin.x,
                                          l_userNameLabelFrame.origin.y + l_userNameLabelFrame.size.height + JS_BORDER_OFFSET_2,
                                          l_userNameLabelFrame.size.width,
                                          JS_NAME_FONT_SIZE + JS_BORDER_OFFSET_2);
        self.nameLabel.frame = l_nameLabelFrame;
    }

    
}

// static method for height requirement
//
+ (CGFloat) heightOfTableViewCell
{
    CGFloat l_fHeight = 0.0;
    
    // top buffer
    l_fHeight += JS_BORDER_OFFSET;

    // height of object image
    l_fHeight += JS_OBJECT_HEIGHT;
    
    // bottom buffer
    l_fHeight += JS_BORDER_OFFSET;
    
    return l_fHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// set cell information
//
- (void) setCellInfoWhereObjectImage:(UIImage*)in_objectImage
                   objectDescription:(NSString*)in_strObjectDescription
                objectAttributeLabel:(NSString*)in_strObjectAttribute
                     userAvatarImage:(UIImage*)in_userAvatarImage
                            userName:(NSString*) in_strUserName
                             andName:(NSString*) in_strName
{
    self.objectImageView.image = in_objectImage;
    
    self.objectDescriptionLabel.text = in_strObjectDescription;
    
    self.objectAttributeLabel.text = in_strObjectAttribute;
    
    self.userAvatarImageView.image = in_userAvatarImage;
    
    self.userNameLabel.text = in_strUserName;
    
    self.nameLabel.text = in_strName;
}

@end
