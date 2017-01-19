//
//  TextFieldPrimary.m
//  Practice
//
//  Created by Ibrahim on 20/05/2016.
//  Copyright © 2016 Ibrahim. All rights reserved.
//


// IMPORT

#import "Label.h"
#import "Theme.h"
#import "Font Size.h"
#import "Dimension.h"


// FORM

@implementation LabelFormSection

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_FORM_SECTION]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end

@implementation LabelFormParagraph

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_FORM_PARAGRAPH]];
        self.numberOfLines = 8;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end

@implementation LabelFormNumber

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_FORM_NUMBER]];
        [self.widthAnchor constraintEqualToConstant:FORM_SIZE_LABELNUMBER].active = true;
        [self.heightAnchor constraintEqualToConstant:FORM_SIZE_LABELNUMBER].active = true;
        self.layer.cornerRadius = FORM_SIZE_LABELNUMBER / 2;
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentCenter;
        self.clipsToBounds = true;
    }

    - (void)styleInvalid
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_ERROR floatOpacity:1.0];
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    }

    - (void)styleValid
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0];
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    }

    - (void)styleEnable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0];
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        self.backgroundColor = [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0];
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SENARY floatOpacity:1.0]];
    }

@end

@implementation LabelFormQuestion

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }

    - (void)drawTextInRect:(CGRect)rect
    {
        UIEdgeInsets insets = {GENERAL_SPACE_TINY, 0, GENERAL_SPACE_TINY, 0};
        [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_FORM_QUESTION]];
        self.numberOfLines = 4;
        self.textAlignment = NSTextAlignmentLeft;
        [self.heightAnchor constraintEqualToConstant:GENERAL_HEIGHT_SINGLE].active = true;
    }

@end

@implementation LabelFormSlimSection

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_FORM_SECTION]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end

@implementation LabelFormSlimQuestion

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }

    - (void)drawTextInRect:(CGRect)rect
    {
        UIEdgeInsets insets = {GENERAL_SPACE_TINY, 0, GENERAL_SPACE_TINY, 0};
        [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_FORMSLIM_QUESTION]];
        self.numberOfLines = 4;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end


// PHOTO

@implementation LabelPhotoSection

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_FORM_SECTION]];
    }

@end

@implementation LabelPhotoParagraph

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_FORM_PARAGRAPH]];
        [self setNumberOfLines : 8];
        [self setLineBreakMode:NSLineBreakByWordWrapping];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing : 1.25];
        [paragraphStyle setLineHeightMultiple : 1.25];
        [paragraphStyle setParagraphSpacing : 1.25];
        [paragraphStyle setAlignment : self.textAlignment];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
        [attributeString addAttribute:NSFontAttributeName value: self.font range: NSMakeRange(0, attributeString.length)];
        [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributeString.length)];
        [self setAttributedText : attributeString];
    }

@end

@implementation LabelPhotoHeader

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_PHOTO_HEADER]];
        self.textAlignment = NSTextAlignmentCenter;
    }

@end

@implementation LabelPhotoDetail

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_PHOTO_DETAIL]];
        self.numberOfLines = 8;
        self.textAlignment = NSTextAlignmentCenter;
    }

@end


// DESCRIPTOR

@implementation LabelDescriptorHeader

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_PRIMARY size:FONTSIZE_DESCRIPTOR_HEADER]];
        self.numberOfLines = 3;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end

@implementation LabelDescriptorWebsite

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_DESCRIPTOR_WEBSITE]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end

@implementation LabelDescriptorDetail

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_DESCRIPTOR_DETAIL]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end


// LIST

@implementation LabelTableHeader

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_LIST_HEADER]];
    self.numberOfLines = 1;
    self.textAlignment = NSTextAlignmentLeft;
}

@end

@implementation LabelTableDetail

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_LIST_DETAIL]];
    self.numberOfLines = 1;
    self.textAlignment = NSTextAlignmentLeft;
}

@end

@implementation LabelTableResult

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_LIST_RESULT]];
    self.numberOfLines = 1;
    self.textAlignment = NSTextAlignmentLeft;
}

@end

@implementation LabelTableHeaderHeader

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
    [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_LISTHEADER_HEADER]];
    self.numberOfLines = 2;
    self.textAlignment = NSTextAlignmentCenter;
}

@end

@implementation LabelTableHeaderDetail

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
    [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_LISTHEADER_DETAIL]];
    self.numberOfLines = 2;
    self.textAlignment = NSTextAlignmentCenter;
}

@end

@implementation LabelTableItemHeader

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
    [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_LISTITEM_HEADER]];
    self.numberOfLines = 2;
    self.textAlignment = NSTextAlignmentCenter;
}

@end

@implementation LabelTableItemDetail

/* INITIALIZE */

- (void)awakeFromNib { [self setupStyle]; }


/* FUNCTION */

- (void)setupStyle
{
    UserInterface *objectUserInterface = [[UserInterface alloc] init];
    
    [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
    [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_LISTITEM_DETAIL]];
    self.numberOfLines = 2;
    self.textAlignment = NSTextAlignmentCenter;
}

@end


// NAVIGATION

@implementation LabelProfileHeader

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_PROFILE_HEADER]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end

@implementation LabelProfileDetail

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_PROFILE_DETAIL]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end

@implementation LabelProfileInitial

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self.widthAnchor constraintEqualToConstant:180].active = true;
        [self.heightAnchor constraintEqualToConstant:80].active = true;
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:48]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentCenter;
        [self setBackgroundColor : [objectUserInterface generateUIColor:THEME_COLOR_NONARY floatOpacity:1.0]];
    }

@end


// GUIDE

    /* HEADER */

    @implementation LabelGuideHeaderStep

        /* INITIALIZE */

        - (void)awakeFromNib
        {
            [self setupStyle];
        }


        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
            [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_GUIDEHEADER_STEP]];
            self.numberOfLines = 1;
            self.textAlignment = NSTextAlignmentCenter;
        }

        - (void)styleOnProgress
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        }

        - (void)styleComplete
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0]];
        }

        - (void)styleDisable
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
        }

    @end

    @implementation LabelGuideHeaderTitle

        /* INITIALIZE */

        - (void)awakeFromNib
        {
            [self setupStyle];
        }

        - (void)drawTextInRect:(CGRect)rect
        {
            UIEdgeInsets insets = {GENERAL_SPACE_TINY, 0, GENERAL_SPACE_TINY, 0};
            [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
        }

        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
            [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_GUIDEHEADER_TITLE]];
            self.numberOfLines = 1;
            self.textAlignment = NSTextAlignmentLeft;
        }

        - (void)styleOnProgress
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
        }

        - (void)styleComplete
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        }

        - (void)styleDisable
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
        }

    @end

    @implementation LabelGuideHeaderState

        /* INITIALIZE */

        - (void)awakeFromNib
        {
            [self setupStyle];
        }


        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
            [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_GUIDEHEADER_STATE]];
            self.numberOfLines = 1;
            self.textAlignment = NSTextAlignmentLeft;
        }

        - (void)styleOnProgress
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_QUINARY floatOpacity:1.0]];
        }

        - (void)styleComplete
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        }

        - (void)styleDisable
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
        }

    @end

    /* DETAIL */

    @implementation LabelGuideDetailStep

        /* INITIALIZE */

        - (void)awakeFromNib
        {
            [self setupStyle];
        }


        /* FUNCTION */

        - (void)setupStyle
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
            [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_GUIDEDETAIL_STEP]];
            self.numberOfLines = 1;
            self.textAlignment = NSTextAlignmentCenter;
        }

        - (void)styleOnProgress
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        }

        - (void)styleComplete
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0]];
        }

        - (void)styleDisable
        {
            _objectUserInterface = [[UserInterface alloc] init];
            
            [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
        }

    @end


// HEADER

@implementation LabelHeaderTitle

    /* INITIALIZE */

    - (void)awakeFromNib { [self setupStyle]; }


    /* FUNCTION */

    - (void)setupStyle
    {
        UserInterface *objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_HEADER_TITLE]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

@end


// MODULE

@implementation LabelModuleTitle

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_SECONDARY size:FONTSIZE_MODULE_TITLE]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

    - (void)styleOnProgress
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    }

    - (void)styleComplete
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0]];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
    }

@end

@implementation LabelModuleHeader

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_MODULE_HEADER]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

    - (void)styleOnProgress
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    }

    - (void)styleComplete
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0]];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
    }

@end

@implementation LabelModuleDetail

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_MODULE_DETAIL]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentLeft;
    }

    - (void)styleOnProgress
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    }

    - (void)styleComplete
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0]];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
    }

@end

@implementation LabelModuleProgress

    /* INITIALIZE */

    - (void)awakeFromNib
    {
        [self setupStyle];
    }


    /* FUNCTION */

    - (void)setupStyle
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
        [self setFont : [UIFont fontWithName:THEME_FONT_TERTIARY size:FONTSIZE_MODULE_PROGRESS]];
        self.numberOfLines = 1;
        self.textAlignment = NSTextAlignmentCenter;
    }

    - (void)styleOnProgress
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_SEPTENARY floatOpacity:1.0]];
    }

    - (void)styleComplete
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_PRIMARY floatOpacity:1.0]];
    }

    - (void)styleDisable
    {
        _objectUserInterface = [[UserInterface alloc] init];
        
        [self setTextColor : [_objectUserInterface generateUIColor:THEME_COLOR_DISABLE floatOpacity:1.0]];
    }

@end
