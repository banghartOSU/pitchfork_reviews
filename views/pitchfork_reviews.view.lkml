view: pitchfork_reviews {
  sql_table_name: pitchfork_reviews.pitchfork_reviews ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: album {
    type: string
    sql: ${TABLE}.album ;;
    link: {
      label: "Go To Pitchfork"
      url: "{{ pitchfork_reviews.link._value }}"
    }
  }

  dimension: artist {
    type: string
    sql: ${TABLE}.artist ;;
  }

  dimension: author {
    type: string
    sql: ${TABLE}.author ;;
  }

  dimension: bnm {
    type: number
    sql: ${TABLE}.bnm ;;
  }

  #DATE FIELDS
  dimension: date {
    group_label: "Dates"
    type: string
    sql: ${TABLE}.date ;;
  }

  dimension: year {
    group_label: "Dates"
    sql: SUBSTR(${date},-4) ;;
  }

  dimension: genre {
    type: string
    sql: ${TABLE}.genre ;;
  }

  dimension: link {
    hidden: yes
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: review {
    type: string
    sql: ${TABLE}.review ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  #MEASURES
  measure: count {
    type: count
    drill_fields: [id]
  }
  measure: normal_average_score {
    type: average
    sql: ${score} ;;
    value_format: "#0.0"
    html: {{rendered_value}} || {{ album_agg._rendered_value }} ;;
  }
  measure: weighted_average_score {
    sql: ${album_count.weighted_average_score} ;;
  }
  measure: album_agg {
    hidden: yes
    type: list
    list_field: album
  }
}

view: album_count {
  derived_table: {
    explore_source: pitchfork_reviews {
      column: count {}
      column: artist {}
    }
  }
  dimension: count {
    hidden: yes
    type: number
  }
  dimension: artist {hidden:yes}

  #MEASURES
  measure: weighted_average_score {
    hidden: yes
    type: average
    sql: (${pitchfork_reviews.score}*${album_count.count}) ;;
  }
}
