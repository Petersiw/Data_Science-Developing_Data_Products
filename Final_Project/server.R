library(shiny)
library(ggplot2)
library(mgcv)
library(reshape2)

#create reference data frame
aq <- airquality[complete.cases(airquality), ]

#create data frame of r squared and adj r squared
n <- seq(1, 15, by = 1)
df1 <- data.frame(n = c(1:length(n)), r2 = rep(NA, length(n)), 
                  adj_r2 = rep(NA, length(n)))
colnames(df1) <- c("n", "R Squared", "Adjusted R Squared")
for(i in 1:length(n)) {
  m <- lm(formula = (formula = Ozone ~ poly(Temp, i)), data = aq)
  df1[i, 2] <- summary(m)$r.squared
  df1[i, 3] <- summary(m)$adj.r.squared
}
df2 <- melt(df1, id = "n")

shinyServer(function(input, output) {
  
  m1 <- reactive({
    m <- lm(formula = Ozone ~ poly(Temp, input$Exp), data = aq)
    m
  })

  output$Plot <- renderPlot({
    print(ggplot(data = aq, aes(x = Temp, y = Ozone)) + 
            geom_point(colour = "steelblue") + 
            labs(title = "Plot of Temperature against Ozone",
                 x = "Temperature", y = "Ozone Level") + 
            theme(plot.title = element_text(hjust = 0.5)) +
            #insert regression line of different polynomials
            geom_smooth(method = "lm", 
                        formula = y ~ poly(x, input$Exp),
                        colour = "red", se = F))
  })

  output$R2 <- renderText({
    summary(m1())$r.squared
  })
  
  output$AR2 <- renderText({
    summary(m1())$adj.r.squared
  })

  output$rsqd_graph <- renderPlot({
    if (!input$rsqd) return()
    ggplot(data = df2, aes(x = n, y = value, colour = variable)) +
      geom_line() +
      labs(title = "Plot of R Squared and Adjusted R Squared against the Number 
           of Variables", x = "Number of Variables", 
           y = "R Squared and Adjusted R Squared") + 
      theme(plot.title = element_text(hjust = 0.5)) +
      theme(legend.position = "bottom", legend.title = element_blank()) +
      geom_vline(xintercept = 4, colour = "orchid4", linetype = "twodash")
    
  })
  output$text2 <- renderUI({
    if (!input$rsqd) return()
    withMathJax(
      helpText("The value of both $R^2$ and $\\bar{R^2}$
               increases until $n~=~4$. After that,
               the distance between the two widens rapidly. This 
               is because the penalty imposed by $\\frac{n~-~1}{n~-~p~-~1}$
               on $R^2$ due to the $n^{th}$ term far outweighs the benefit 
               of including it, suggesting model overfit. Note how the flexible 
               function is attempting to link between the first and last 
               observation beginning from $n~=~5$. An overfit occurs when a 
               model follows the data so closely that it is no longer 
               generalisable to the population. Thus, by keeping track of
               $R^2$ and $\\bar{R^2}$ when fitting multivariate models we can 
               prevent model overfit, which is detrimental to any analysis.")
    )
  })
})






