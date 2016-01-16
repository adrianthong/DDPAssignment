library(shiny)
library(rCharts)

df <- read.csv("Domestic-Exports-By-Area.csv", header = TRUE, na.strings = "na")
DFdomexp <- df

fluidPage(
  titlePanel("Singapore Domestic Exports by Area, Annual"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId= "InpYear", label = "Year:", 
                  min = min(df$year), max = max(df$year),
                  value = c(min(df$year),max(df$year)), 
                  sep = "", step = 1
      ),
      checkboxGroupInput(inputId = "InpArea", label = "Area:",
                         choices = as.character(unique(df$area)), 
                         selected = as.character(unique(df$area))
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("ReadMe",
                 includeMarkdown('./ReadMe.html')
        ),
        tabPanel("Chart", 
                 showOutput("chart1", "polycharts")
        ),
        tabPanel("Data",
                 dataTableOutput("table1")
        )
      )))  
)