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
  String seeders;
  String uploadSize;
  String downloadSize;
  String ratio;
  String leechers; 
  String completions;
  String discount;
  String discountRemain;
  bool isHot;
}