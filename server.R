library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    x <- seq(0, 50, length.out = 1000)  # Old Faithful Geyser data
    pdf <- dchisq(x, input$df)
    signif <- qchisq(0.95, input$df)
    psignif <- dchisq(signif, input$df)
    area <- x > signif
    dat <- data.frame(x = x, p = pdf, area = area)
    # draw the histogram with the specified number of bins
    ggplot(data = dat, aes(x=x, y=pdf)) + 
      geom_area(mapping = aes(fill=area)) +
      theme(legend.position="none", 
            plot.title=element_text(size=rel(1.5),
                                    lineheight=.9,
                                    family="Times",
                                    face="bold.italic",
                                    colour="black")) +
      coord_cartesian(ylim = c(-0.1, 0.5)) +
      xlim(0, 35) + 
      annotate("text",
               x=signif+3,
               y=-0.02,
               label="0.95 significance level",
               size = 5,
               family="Times") +
      ggtitle(sprintf("Chi-square Distribution(degree of freedom = %d )", input$df))
  })
})