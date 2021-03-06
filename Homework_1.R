#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
require(ggplot2)
require(plotly)
Titanic <- as.data.frame(Titanic)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("The Titanic"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
          selectInput(inputId = "y",
                      label = "Do you think the Titanic sunk?",
                     choices = c("Yes", "No", "It did in the movie, but I'm really not sure"),
                     selected = "Yes"
                     ),
          sliderInput(inputId = "hours",
                      label = "How many hours did the Titanic take to sink?",
                      value = c(2,5),
                      min = 0,
                      max = 10,
                      step = 0.25),
          checkboxGroupInput(inputId = "reasons",
                             label = "Why did the Titanic sink?",
                             choices = c("The captain wasn't paying attention",
                                         "Rose was distracting the captain",
                                         "Aliens",
                                         "An iceberg",
                                         "The Titanic didn't sink"))
          
          
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput(outputId = "titanic"),
        plotOutput(outputId = "titanic2")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
     output$titanic <- renderPlot({ggplot(data = Titanic, aes(x = Class, y = Freq, fill = Sex)) + 
         geom_bar(stat="identity", position=position_dodge()) + 
         ggtitle("Titanic Classes and Age, Broken Down by Sex")})
     output$titanic2 <- renderPlot({ggplot(data = Titanic, aes(x = Age, y = Freq, fill = Sex)) + 
         geom_bar(stat="identity", position=position_dodge())})
   }


# Run the application 
shinyApp(ui = ui, server = server)

