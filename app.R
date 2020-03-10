library(dplyr)
library(shiny)
library(collapsibleTree)
require(colorspace)
library(xlsx)

# Dataset is a test set created internally for testing purposes

Origin <- read_excel("test-data.xlsx")


# Define UI for application that draws a collapsible tree
ui <- fluidPage(
  
  # Application title
  titlePanel("Collapsible Tree Example: Income statement to revenues & expenses"),
  
  # Sidebar with a select input for the root node
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "hierarchy", "Tree hierarchy",
        choices = c(
          "Income Statement", "Revenues", "Revenue 1",
          "Revenue 1A"
        ),
        selected = c("Income Statement","Revenues", "Revenues 1", "Revenues 1A"),
        multiple = TRUE
      )
      
    ),
    
    # Show a tree diagram with the selected root node
    mainPanel(
      collapsibleTreeOutput("plot", height = "500px")
    )
  )
)

# Define server logic required to draw a collapsible tree diagram
server <- function(input, output) {
  output$plot <- renderCollapsibleTree({
    collapsibleTreeSummary(
      Origin,
      hierarchy = input$hierarchy
    )
  })
  
  output$str <- renderPrint(str(input$node))
}

# Run the application
shinyApp(ui = ui, server = server)
