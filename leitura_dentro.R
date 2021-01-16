library(rvest)
library(RSelenium)

rs <- rsDriver(
  browser = "firefox",
  port = 4570L,
  extraCapabilities = list(
    `mox:firefoxOptions` = list(
      binary = "C:/Program Files (x86)/Mozilla Firefox/firefox.exe"
    )
  )
)


rsc <- rs$client


le_detalhes <- function(endereco){

  rsc$navigate(endereco)
  
  pagina <- rsc$getPageSource()[[1]]
  
  dom <- read_html(pagina)
  
  autor <- dom %>% html_node(css = ".EXLResultAuthor") %>% 
    html_text()
  
  detalhes_1 <- dom %>% html_node(css = ".EXLResultDetails") %>% 
    html_text()

  detalhes_2 <- dom %>% html_node(css = ".EXLResultFourthLine") %>% 
    html_text()
  
  tibble(
    autor = autor,
    detalhes_1 = detalhes_1,
    detalhes_2 = detalhes_2
  )
  

}




