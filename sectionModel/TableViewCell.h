//
//  TableViewCell.h
//  sectionModel
//
//  Created by Lovina on 10/05/18.
//  Copyright © 2018 Lovina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@end
