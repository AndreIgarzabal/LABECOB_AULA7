# Carregar bibliotecas
library(WDI)
library(ggplot2)

# Coletar dados
dadospib <- WDI(country = 'all', indicator = 'NY.GDP.MKTP.CD')

# Criar a coluna de categoria: Brasil ou Outros
dadospib$categoria <- ifelse(dadospib$iso2c == "BR", "Brasil", "Outros")

# Gráfico com Brasil em vermelho sólido e sobrepondo os outros pontos
grafpainel <- ggplot(dadospib) +
  # Desenha os pontos de "Outros" com pontos transparentes
  geom_point(data = subset(dadospib, categoria == "Outros"),
             aes(x = year, y = NY.GDP.MKTP.CD, color = categoria), 
             size = 1.5, alpha = 0.4) +
  
  # Desenha os pontos do "Brasil" com destaque
  geom_point(data = subset(dadospib, categoria == "Brasil"),
             aes(x = year, y = NY.GDP.MKTP.CD, color = categoria), 
             size = 4, alpha = 1) +
  
  # Adicionar título e rótulos
  labs(
    title = "Evolução do PIB Mundial com Destaque para o Brasil",
    x = "Ano",
    y = "PIB (USD)",
    color = "País"
  ) +
  scale_color_manual(values = c("Brasil" = "red", "Outros" = "lightgrey")) +  # Define cores personalizadas para a legenda
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 10, face = "bold"),  # Título ajustado para tamanho menor
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    legend.position = "top",  # Coloca a legenda no topo
    legend.title = element_text(size = 10),  # Aumenta o título da legenda
    legend.text = element_text(size = 8),   # Aumenta o texto da legenda
    legend.key.size = unit(0.5, "cm")       # Ajusta o tamanho dos quadrados da legenda
  )

# Exibir o gráfico
print(grafpainel)

             