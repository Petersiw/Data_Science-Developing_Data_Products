library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  withMathJax(),
  tags$script("
              MathJax.Hub.Config({
              tex2jax: {
              inlineMath: [['$','$'], ['\\(','\\)']],
              processEscapes: true
              }
              });"
  ),
  
  # Application title
  titlePanel("Model Overfit"),
  # Explanation
  h5("We are using the Airquality dataset provided in R to conduct a study
            on model overfitting in the case of too many explanatory 
            variables."),

  h5("The R Squared ((R^2)) of a model can be thought of as the 
            proportion of variation in the data that a model can explain while 
            the Adjusted R Squared ((\\bar{R^2})) adjusts (R^2) based on the 
            number of explanatory variables."),
  
  helpText("((R^2 = 1 - 
            \\frac{Residual~Sum~of~Squares}
            {Total~Sum~of~Squares});
            $\\bar{R^2} = 1 - (1 -R^2)\\frac{n~-~1}{n~-~p~-~1}$,
            where (n) is sample size and (p) is the number of 
            explantory variables.)"),
          
  h5("Building on the linear model 
            $Ozone~=~\\beta_{0}~+~\\beta_{1}Temperature~
            +~\\beta_{k}Temperature^k~+~...~+\\beta_{n}Temperature^n$,
            this study will demonstrate that with increasing (n), 
            this model will overfit the data and beyond that point additional 
            (n^{th}) variable 
            will not further explain the true relationship between Ozone Levels 
            and Temperature."),

  h5("Now adjust the slider to change the Number of Variables (n) and
            note the progression of both $R^2$ and 
            $\\bar{R^2}$ as you change the value of (n)."),

  sidebarLayout(
    sidebarPanel(
       sliderInput("Exp",
                   "Number of Variables (n):",
                   min = 1,
                   max = 15,
                   value = 1,
                   step = 1),
       h5("R Squared ((R^2))"),
       textOutput("R2"),
       h5("Adjusted R Squared ((\\bar{R^2}))"),
       textOutput("AR2")
    ),
    
    mainPanel(

       plotOutput("Plot"),
       checkboxInput("rsqd", "Show the Analyses of (R^2) and (\\bar{R^2}) 
                     vs Number of Explanatory Variables", F),
       plotOutput("rsqd_graph"),
       uiOutput("text2")
    )
  )
))
