//
//  CollectionViewCell.h
//  WeatherApp
//
//  Created by Mutlu Çalkan on 27.12.2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@end

NS_ASSUME_NONNULL_END
