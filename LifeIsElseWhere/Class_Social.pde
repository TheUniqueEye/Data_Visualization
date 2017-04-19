class Social {
  String user_id, user_name, media_id, date, social_id, social_name;
  float location_long, location_lat;
  int count_comment,comment_length; //count_like;
  String comment_date, comment_text;

  Social( String user_id, String user_name, String media_id, 
    String date, float location_long, float location_lat, 
    String social_id, String social_name, 
    int count_comment, //int count_like,
    String comment_date, String comment_text,int comment_length) {
    this.user_id = user_id;
    this.user_name = user_name;
    this.media_id = media_id;
    this.date = date;
    this.location_long = location_long;
    this.location_lat = location_lat;
    this.social_id = social_id;
    this.social_name = social_name;
    this.count_comment = count_comment;
    //this.count_like = count_like;
    this.comment_date = comment_date;
    this.comment_text = comment_text;
    this.comment_length = comment_length;
  }
}