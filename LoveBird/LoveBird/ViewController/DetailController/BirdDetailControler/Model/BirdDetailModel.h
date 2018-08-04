//
//  BirdDetailModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"


@protocol BirdDetailImageModel;
@protocol BirdDetailSongModel;
@protocol BirdDetailVedioModel;

@interface BirdDetailModel : AppBaseModel


@property (nonatomic, strong) NSArray <BirdDetailImageModel>*img;

@property (nonatomic, strong) NSArray <BirdDetailSongModel>*song;

@property (nonatomic, strong) NSArray <BirdDetailVedioModel>*video;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *bi_property;

@property (nonatomic, copy) NSString *bird_class;

@property (nonatomic, copy) NSString *color;

@property (nonatomic, copy) NSString *describe;

@property (nonatomic, copy) NSString *dis_range;

@property (nonatomic, copy) NSString *dis_status;

@property (nonatomic, copy) NSString *dis_status_china;

@property (nonatomic, copy) NSString *habit;

@property (nonatomic, assign) CGFloat hand_drawing_height;

@property (nonatomic, assign) CGFloat hand_drawing_width;

@property (nonatomic, copy) NSString *hand_drawing_img;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *name_latin;

@property (nonatomic, copy) NSString *obs_times;

@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, copy) NSString *po_ch_property;

@property (nonatomic, copy) NSString *protect_china;

@property (nonatomic, copy) NSString *protect_cites;

@property (nonatomic, copy) NSString *protect_iucn;

@property (nonatomic, copy) NSString *region_img;

@property (nonatomic, assign) CGFloat region_img_height;

@property (nonatomic, assign) CGFloat region_img_width;

@property (nonatomic, copy) NSString *song_describe;


@end


@interface BirdDetailImageModel : AppBaseModel

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *img_url;

@property (nonatomic, copy) NSString *property;


@end

@interface BirdDetailSongModel : AppBaseModel
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *playback_length;
@property (nonatomic, copy) NSString *song_url;
@property (nonatomic, copy) NSString *vid;

@end

@interface BirdDetailVedioModel : AppBaseModel
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *playback_length;
@property (nonatomic, copy) NSString *video_url;
@property (nonatomic, copy) NSString *video_imgUrl;


@end


//alias    别名    string    @mock=红鹤,朱脸鹮鹤,朱鹭
//bi_property    生物学特征    string    @mock=现存种群为 1981 年 7 只个体的后代，属近亲繁殖，繁殖力低。
//bird_class    物种分类    string    @mock=鹳形目-鹮科-朱鹮属
//color    颜色    string    @mock=虹膜－黄色；嘴－黑色而端红；脚－绯红
//describe    描述    string    @mock=中等体型（55厘米）偏粉色鹮。脸朱红色，嘴长而下弯，嘴端红色，颈后饰羽长，为白或灰色（繁殖期），腿绯红。亚成鸟灰色，部分成鸟仍为灰色。夏季灰色较浓，饰羽较长。飞行时飞羽下面红色。虹膜－黄色；嘴－黑色而端红；脚－绯红。
//dis_range    分布范围    string    @mock=过去在中国东部、朝鲜及日本为留鸟，现野外几乎绝种，仅在中国中部尚有一群存活。
//dis_status    分布状况    string    @mock=全球性极危（Collar et al., 1994）。繁殖于陕西南部秦岭南坡（洋县），野外仅有百余只鸟幸存（曾降至20余只）。笼养条件下有大致相应数目的个体，且尝试过引种至日本。
//dis_status_china    中国分部状况
//habit    习性    string    @mock=在大栎树上结群营巢。在附近农场农作区及自然沼泽区取食。
//hand_drawing_height    手绘图高度    number    @mock=840
//hand_drawing_img    手绘图url    string    @mock=http://bird.obs.myhwclouds.com/birdpic/P00561.jpg
//hand_drawing_width    手绘图宽度
//
//name    鸟名    string    @mock=朱鹮
//name_latin    拉丁名    string    @mock=Nipponia nippon
//obs_times    观察记录数    number    @mock=10
//pinyin    鸟名汉语拼音    string    @mock=zhuhuan
//po_ch_property    种群变化趋势    string    @mock=至 2002 年 7 月，野生种群数量约 200 只，饲养种群数量(包括日本)将近250只。
//protect_china    中国法律保护等级    string    @mock=国家一级保护动物
//protect_cites    华盛顿公约CITES    string    @mock=一级保护物种
//protect_iucn    世界自然保护联盟IUCN    string    @mock=Endangered（EN）
//region_img    地域图分布    string    @mock=http://bird.obs.myhwclouds.com/birdmap/b0561.jpg
//region_img_height    地域图分布高度    number    @mock=328
//region_img_width    地域图分布宽度
// song_describe    叫声描述
//
//author    展示图作者    string    @mock=$order('爱鸟网','爱鸟网','爱鸟网','爱鸟网','爱鸟网')
//img_url    展示图url    string    @mock=$order(' http://www.fansimg.com/forum/201712/26/103605vsa5gxxug5ppzmeu.jpg',' http://www.fansimg.com/forum/201712/26/103822cwi12w0i1fzey0i0.jpg',' http://www.fansimg.com/forum/201712/26/103822it1ubemejbprqq4q.jpg',' http://www.fansimg.com/forum/201801/10/124913gqn5bql001l01c95.jpg',' http://www.fansimg.com/forum/201801/10/124956h7b72uu7j3vjxkxo.jpg')
//property    展示图属性
//
//
//author    叫声作者    string    @mock=$order('Frank Lambert','Frank Lambert','Frank Lambert','Frank Lambert')
//playback_length    鸟叫音频播放时长    string    @mock=$order('27秒','19秒','42秒','36秒')
//song_url    音频url    string    @mock=$order('http://bird.obs.myhwclouds.com/birdsong/20330001/9747.mp3','http://bird.obs.myhwclouds.com/birdsong/20330001/9748.mp3','http://bird.obs.myhwclouds.com/birdsong/20330001/9749.mp3','http://bird.obs.myhwclouds.com/birdsong/20330001/9750.mp3')
//vid    暂可忽略
//
//author
//playback_length    播放时长
//video_url    视频url
