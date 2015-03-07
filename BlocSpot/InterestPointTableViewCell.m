//
//  InterestPointTableViewCell.m
//  BlocSpot
//
//  Created by Jonathan Jungemann on 3/4/15.
//  Copyright (c) 2015 Jon Jungemann. All rights reserved.
//

#import "InterestPointTableViewCell.h"

@implementation InterestPointTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseIdentifier = @"InterestPointCell";
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
