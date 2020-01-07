connection: "lookerdata_publicdata_standard_sql"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project

explore: pitchfork_reviews {
  sql_always_where: ${pitchfork_reviews.artist} != "Various Artists" ;;
  join: album_count {
    sql_on: ${album_count.artist} = ${pitchfork_reviews.artist} ;;
    type: inner
    relationship: one_to_one
  }
}
