project_name: "pitchfork_review"

constant: sql_statement{
  value: "CASE WHEN ${artist}=\"(Sandy) Alex G\" THEN 'yes' else 'no' END"
}


constant: test_join{
  value:
  "
  {% if {{testy._parameter_value}}==1 %}
    ${pitchfork_reviews.artist} = ${album_count.artist}
  {% else %}
    ${pitchfork_reviews.link} = ${album_count.link}
  {% endif %}
  "
}
