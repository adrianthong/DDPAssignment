library(shiny)
library(rCharts)

df <- read.csv("Domestic-Exports-By-Area.csv", header = TRUE, na.strings = "na")
DFdomexp <- df

server <- function(input, output) {
  output$chart1 <- renderChart({
    YEAR = input$InpYear
    AREA = input$InpArea
    LTarea <- list(area = as.character(df$area))
    DFdomexp <- subset(DFdomexp, year > YEAR[1] - 1 & year < YEAR[2] + 1)
    DFdomexp <- subset(DFdomexp, area == AREA)
    p1 <- rPlot(domestic_exports ~ year, color = "area", 
                data = DFdomexp, type = "line")
    p1$addParams(dom = 'chart1', 
                 title = "Domestic Exports by Area, Annual")
    p1$guides(x = list(title = "Year"), ticks = unique(DFdomexp$year))
    p1$guides(y = list(title = "Domestic Exports (S$ MILLION)"))
    
    return(p1)
  })
  output$table1 <- renderDataTable({
    YEAR = input$InpYear
    AREA = input$InpArea
    DFdomexp <- subset(DFdomexp, year > YEAR[1] - 1 & year < YEAR[2] + 1)
    DFdomexp <- subset(DFdomexp, area == AREA)
    return(DFdomexp)
  }, options = list(pageLength = 10))  
}