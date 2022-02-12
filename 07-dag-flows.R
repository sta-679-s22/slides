library(ggplot2)
library(ggdag)
coords <- list(
  x = c(pollution = 1, stress = 1, lifestyle = 1, addiction = 1, smoking = 2, coffee = 3, cancer = 4),
  y = c(pollution = 0.2, stress = 0.1, addiction = -0.1, lifestyle = -0.2, smoking = 0, coffee = 0, cancer = 0)
)
dagify(
  cancer ~ smoking + pollution + stress + lifestyle,
  smoking ~ addiction + stress,
  coffee ~ addiction + lifestyle,
  exposure = "coffee",
  outcome = "cancer",
  coords = coords
) %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_point(size = 22) +
  geom_dag_text() +
  theme_dag() -> p

p + 
  geom_dag_edges_arc(curvature = c(0, 0, 0, 0, 0.05, 0.05, 0.05, 0)) 
p + 
  geom_dag_edges_arc(
    curvature = c(0, 0, 0, 0, 0.05, 0.05, 0.05, 0),
    edge_color = rep(c("cornflower blue", "black", "black", "cornflower blue",
                   "black", "black", "black", "black"), each = 100)) 
p + 
  geom_dag_edges_arc(
    curvature = c(0, 0, 0, 0, 0.05, 0.05, 0.05, 0),
    edge_color = rep(c("cornflower blue", "black", "black", "black",
                       "black", "black", "black", "black"), each = 100)) 
  
## hide lifestyle
dagify(
  cancer ~ smoking + pollution + stress + lifestyle,
  smoking ~ addiction + stress,
  coffee ~ addiction + lifestyle,
  exposure = "coffee",
  outcome = "cancer",
  coords = coords
) %>%
  ggplot(aes(x = x, y = y, xend = xend, yend = yend)) +
  theme_dag() +
  geom_dag_edges_arc(
    curvature = c(0, 0, 0, 0, 0.05, 0.05, 0.05, 0),
    edge_color = rep(c("black", "black", "white", "white",
                       "black", "black", "black", "black"), each = 100)) +
  geom_dag_point(size = 22, color = c("black", "white", "black", "black",
                                      "black", "black", "black")) +
  geom_dag_text() -> p

p +   
  geom_dag_point(size = 22, color = c("orange", "white", "black", "black",
                                      "black", "black", "black")) +
  geom_dag_text()

p +   
  geom_dag_point(size = 22, color = c("black", "white", "black", "orange",
                                      "orange", "black", "black")) +
  geom_dag_text()
  
