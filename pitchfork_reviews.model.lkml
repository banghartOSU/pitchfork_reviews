connection: "lookerdata_publicdata_standard_sql"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

explore: pitchfork_reviews {
  tags: ["TAGS COMING IN"]
  sql_always_where: ${pitchfork_reviews.artist} != "Various Artists" ;;
  join: album_count {
    sql_on: ${pitchfork_reviews.test_join}  ;;
    type: inner
    relationship: one_to_one
  }
}
