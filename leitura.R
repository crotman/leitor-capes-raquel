library(tidyverse)

dados <- read_file("dados/lista.txt") %>% 
  str_split(
    "&lang=pt_BR",
  ) %>% 
  unlist() 

titulos <- dados %>% 
  enframe(
    name = "name",
    value = "value"
  ) %>% 
  filter(
    name %% 2 == 1
  ) %>% 
  mutate(
    value = str_trim(value)
  ) %>% 
  group_by(
    value
  ) %>% 
  slice_head(
    n = 1
  ) %>% 
  arrange(
    value
  ) %>% 
  filter(
    value != "",
    !str_starts(value, "vid=CAPES_V1&docId=TN")
  ) %>% 
  separate(
    value,
    sep = "https",
    into = c("titulo", "endereco")
  ) %>% 
  mutate(
    endereco = str_glue("https{endereco}")
  ) %>% 
  mutate(
    detalhes = map(.x = endereco, .f = le_detalhes)
  ) %>% 
  unnest(
    detalhes
  ) 
  
writexl::write_xlsx(titulos, "dados/artigos.xlsx")

  
