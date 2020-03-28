enum Category {
  U2_Rip,
  U2_RBD,
  Web,
  BDRip,
  DVDRip,
  HDTVRip	,
  DVDISO	,
  BDMV,
  LQRip	,
  Plugin_Structure,
  Modded_Blu_rays,
  Raw_Books,	
  HK_Manga,
  TW_Manga,
  Lossless_Music	
}

class Torrent {
  String title;
  String subtitle;
  String id;
  String category;
  String comments;
  String ttl;
  String size;
  /// 做种数
  String seeders;
  String uploadSize;
  String downloadSize;
  String ratio;
  /// 下载数
  String leechers; 
  /// 完成数
  String completions;
  String discount;
  String discountRemain;
  /// 发布时间
  String deployTime;
  /// 封面
  String cover;
  /// 引用
  List<String> references;
  bool isHot;

  String anidb;
  /// 文件数
  String filesCount;
  String fileHash;
  /// 查看
  String pv;
  /// 点击
  String uv;
  /// 最后活动
  String lastActivity;

}