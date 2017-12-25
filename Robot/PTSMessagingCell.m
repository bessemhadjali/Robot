/*
 PTSMessagingCell.m
 
 Copyright (C) 2012 pontius software GmbH
 
 This program is free software: you can redistribute and/or modify
 it under the terms of the Createive Commons (CC BY-SA 3.0) license
 */

#import "PTSMessagingCell.h"


@implementation PTSMessagingCell

static CGFloat textMarginHorizontal = 15.0f;
static CGFloat textMarginVertical = 6.0f;
static CGFloat messageTextSize = 18.0;

@synthesize sent, messageLabel, messageView, timeLabel, balloonView;

#pragma mark -
#pragma mark Static methods

+(CGFloat)textMarginHorizontal {
    return textMarginHorizontal;
}

+(CGFloat)textMarginVertical {
    return textMarginVertical;
}

+(CGFloat)maxTextWidth {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 180.0f;
    } else {
        return 360.0f;
    }
}

+(CGSize)messageSize:(NSString*)message {
    
    
   
    NSString *descriptText = message;
   
    UIFont *descriptFont = [UIFont fontWithName:@"Helvetica" size:messageTextSize];
    
    CGFloat width = [PTSMessagingCell maxTextWidth];
    
  
    NSAttributedString *attributedDescriptText = [[NSAttributedString alloc] initWithString:descriptText
                                                                                 attributes:@{NSFontAttributeName: descriptFont }];
    
    
    CGRect descriptRect = [attributedDescriptText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                               options: NSStringDrawingUsesLineFragmentOrigin
                                                               context:nil];
    
    CGSize descriptSize = descriptRect.size;
    
    
    
    
    return descriptSize;
}

+(UIImage*)balloonImage:(BOOL)sent isSelected:(BOOL)selected {
  
    if (sent == YES ) {
        return [[UIImage imageNamed:@"rightBubble"] stretchableImageWithLeftCapWidth:24 topCapHeight:15] ;
    } else {
        return [[UIImage imageNamed:@"leftBubble"] stretchableImageWithLeftCapWidth:24 topCapHeight:15] ;
    }
}

#pragma mark -
#pragma mark Object-Lifecycle/Memory management

-(id)initMessagingCellWithReuseIdentifier:(NSString*)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        /*Now the basic view-lements are initialized...*/
        messageView = [[UIView alloc] initWithFrame:CGRectZero];
        messageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        balloonView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        
        /*Message-Label*/
        
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.font=[UIFont fontWithName:@"Helvetica" size:messageTextSize];
        self.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageLabel.numberOfLines = 0;
        
        /*Time-Label*/
        self.timeLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        self.timeLabel.textColor = [UIColor darkGrayColor];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        
        /*...and adds them to the view.*/
        [self.messageView addSubview: self.balloonView];
        [self.messageView addSubview: self.messageLabel];
        
        
        [self.contentView addSubview: self.timeLabel];
       
        
        [self.contentView addSubview: self.messageView];
      
        
        
    }
    
    return self;
}


#pragma mark -
#pragma mark Layouting

- (void)layoutSubviews {
    /*This method layouts the TableViewCell. It calculates the frame for the different subviews, to set the layout according to size and orientation.*/
    
    /*Calculates the size of the message. */
    CGSize textSize = [PTSMessagingCell messageSize:self.messageLabel.text];
    
    /*Calculates the size of the timestamp.*/
    ///  [PTSMessagingCell maxTextWidth]
    
    NSString *descriptText = self.timeLabel.text;
    
    UIFont *descriptFont = [UIFont fontWithName:@"Helvetica" size:messageTextSize];
    
    CGFloat width = [PTSMessagingCell maxTextWidth];
    
    
    NSAttributedString *attributedDescriptText = [[NSAttributedString alloc] initWithString:descriptText
                                                                                 attributes:@{NSFontAttributeName: descriptFont }];
    
    
    CGRect descriptRect = [attributedDescriptText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                                               options: NSStringDrawingUsesLineFragmentOrigin
                                                               context:nil];
    
    CGSize dateSize = descriptRect.size;
    

  
    
    /*Initializes the different frames , that need to be calculated.*/
    CGRect ballonViewFrame = CGRectZero;
    CGRect messageLabelFrame = CGRectZero;
    CGRect timeLabelFrame = CGRectZero;
    
    if (self.sent == YES) {
        
        ballonViewFrame = CGRectMake(self.frame.size.width - (textSize.width + 2*textMarginHorizontal)-15.0f, 0.0f, textSize.width + 2*textMarginHorizontal+5.0f, textSize.height + 3*textMarginVertical+5.0f);
        
        messageLabelFrame = CGRectMake(self.frame.size.width - (textSize.width + textMarginHorizontal)-15.0f,  ballonViewFrame.origin.y + textMarginVertical+2.0f, textSize.width, textSize.height+5.0f);
        
        
        timeLabelFrame = CGRectMake(self.frame.size.width - 15.0f-dateSize.width, ballonViewFrame.size.height+3, dateSize.width, dateSize.height);
       
        self.messageLabel.textColor = [UIColor blackColor];
        
        
        
        
    } else {
        
        ballonViewFrame = CGRectMake(10.0f, 0.0f, textSize.width + 2*textMarginHorizontal, textSize.height + 3*textMarginVertical+5.0f);
        
        
        messageLabelFrame = CGRectMake(10.0f+textMarginHorizontal, ballonViewFrame.origin.y + textMarginVertical+2.0f, textSize.width, textSize.height+5.0f);
       
        timeLabelFrame = CGRectMake(15.0f, ballonViewFrame.size.height+3, dateSize.width, dateSize.height);
        
        self.messageLabel.textColor = [UIColor blackColor];
       
        
        
    }
    self.balloonView.image = [PTSMessagingCell balloonImage:self.sent isSelected:self.selected];
    
    /*Sets the pre-initialized frames  for the balloonView and messageView.*/
    self.balloonView.frame = ballonViewFrame;
    self.messageLabel.frame = messageLabelFrame;
    
    
    /*If there is next for the timeLabel, sets the frame of the timeLabel.*/
    
    if (self.timeLabel.text != nil) {
        self.timeLabel.frame = timeLabelFrame;
    }
 }




@end


