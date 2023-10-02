library(pubmedDashboard)

render_dashboard(
  file_name = "test_dashboard",
  title = "Neglected 95% Dashboard",
  author = "Rémi Thériault",
  journal = journal_field$journal_short[-23],
  year_low = 2023,
  year_high = 2030,
  api_key = API_TOKEN_PUBMED,
  query_pubmed = FALSE
)
