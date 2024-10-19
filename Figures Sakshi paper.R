x <- scatter_continent_year(data_psych,
                            method = "loess",
                            plotly = FALSE)
x

# x + scale_colour_viridis_d() + guides(fill = "none")

ggplot2::ggsave("Figures/Figure 1.pdf", width = 10, height = 6, unit = "in", dpi = 300)


# # Color-blindness investigation
# red_green_colors <- RColorBrewer::brewer.pal(6, "RdYlGn")
#
# # convert to the three dichromacy approximations
# library(dichromat)
# protan <- dichromat(red_green_colors, type = "protan")
# deutan <- dichromat(red_green_colors, type = "deutan")
# tritan <- dichromat(red_green_colors, type = "tritan")
#
# # plot for comparison
# layout(matrix(1:4, nrow = 4)); par(mar = rep(1, 4))
# recolorize::plotColorPalette(red_green_colors, main = "Trichromacy")
# recolorize::plotColorPalette(protan, main = "Protanopia")
# recolorize::plotColorPalette(deutan, main = "Deutanopia")
# recolorize::plotColorPalette(tritan, main = "Tritanopia")
#

# Figure 2 facet_wrap

# scatter_continent_year(journals_dat,
#                        method = "loess",
#                        text_size = 11,
#                        height = 400 * n_plots,
#                        xmin = 1987,
#                        xmax = 2024,
#                        xby = 10,
#                        plotly = FALSE) +
#   ggplot2::facet_wrap("journal")

# Not feasible to facet_warp because scatter_continent_year relies on
# table_continent_year which does not save the journal data in order to
# make the table like we wish it to be.
# So instead we might have to rely on see:plots()...

journals_dat <- data_psych

journals <- journals_dat %>%
  pull(journal) %>%
  unique

journal.abb <- dplyr::inner_join(data.frame(journal = journals),
                                 pubDashboard::journal_field)

journal.abb <- journal.abb %>%
  mutate(journal2 = case_when(
    nchar(journal) >= 40 ~ journal_abbr,
    TRUE ~ journal
  ))

list.plots <- lapply(journals, \(x) {
  zz <- scatter_continent_year(journals_dat %>%
                                 filter(journal == x),
                               method = "loess",
                               text_size = 11,
                               height = 400 * n_plots,
                               xmin = 1987,
                               xmax = 2024,
                               xby = 10,
                               plotly = FALSE) +
    ggplot2::labs(title = journal.abb %>%
                    filter(journal == x) %>%
                    pull(journal2)) +
    ggplot2::theme(legend.text = ggplot2::element_text(size = 20))
}) %>%
  setNames(journals)

zz <- see::plots(list.plots, n_columns = 4) +
  patchwork::guide_area() +
  patchwork::plot_layout(guides = "collect")
zz

# ggplot2::ggsave("Figures/Figure 2.pdf", width = 3 * 4, height = 6 * (17 / 5), unit = "in", dpi = 300)

ggplot2::ggsave("Figures/Figure 2.pdf", width = 3 * 5, height = 6 * (17 / 6), unit = "in", dpi = 300)
ggplot2::ggsave("Figures/Figure 2.png", width = 3 * 5, height = 6 * (17 / 6), unit = "in", dpi = 300)

# Figure 2

# journals_dat <- data_psych
#
# journals <- journals_dat %>%
#   pull(journal) %>%
#   unique
#
# n_plots <- length(journals)
#
# list.plots <- lapply(journals, \(x) {
#   zz <- scatter_continent_year(journals_dat %>%
#                                  filter(journal == x),
#                                method = "loess",
#                                text_size = 11,
#                                height = 400 * n_plots,
#                                xmin = 1987,
#                                xmax = 2024,
#                                xby = 10)
# }) %>%
#   setNames(journals)
#
# my_y <- lapply(1:n_plots, function(i) {
#   1 - (i * 1.001 - 1) / n_plots
# }) %>% unlist()
#
# my_annotations <- lapply(seq_along(names(list.plots)), \(x){
#   list(x = 0.5,
#        y = my_y[x],
#        text = names(list.plots)[x],
#        showarrow = FALSE,
#        xref = "paper",
#        yref = "paper",
#        font = list(size = 14))
# })
#
# subplot_obj <- plotly::subplot(
#   list.plots, nrows = round(n_plots / 2),
#   margin = 0.12 / n_plots, #0.01,
#   shareX = FALSE, titleY = TRUE) %>%
#   plotly::layout(annotations = my_annotations)
#
# # Remove redundant legends from all but the first plot
# subplot_obj$x$data <- lapply(1:length(subplot_obj$x$data), function(i) {
#   # Only remove legends from subsequent plots
#   if (i > 6) {  # Adjusting index to correspond to legend settings
#     subplot_obj$x$data[[i]]$showlegend <- FALSE  # Remove legend from others
#   }
#   return(subplot_obj$x$data[[i]])
# })
#
# # Render the modified subplot
# subplot_obj
#
