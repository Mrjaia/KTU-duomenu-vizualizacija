library(shiny)
library(dplyr)
library(tidyverse)


ui <- fluidPage(

  titlePanel("561000"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "kodas", label = "Imones kodas", choices = NULL, selected = NULL)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  data <- read_csv("../../laboratorinis/data/lab_sodra.csv")
  updateSelectInput(session, "kodas", choices = unique(data$code))
  output$distPlot <- renderPlot({
    data %>%
      filter(ecoActCode == 561000,code == as.numeric(input$kodas)) %>%
      ggplot(aes(x = month, y = avgWage, color = name)) +
      geom_line() +
      theme_bw()
  })
}



shinyApp(ui = ui, server = server)
