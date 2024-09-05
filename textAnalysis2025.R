# Loading libraries
library(tm)
library(tidyverse)
library(syuzhet)
library(textclean)
library(quanteda)
library(stringi)
library(ggplot2)
library(wordcloud)
library(quanteda.textstats)
library(officer)

#Creating a function to clean the text and remove phrases often used with no context.
cleanText <- function(text) {
  text <- iconv(text, from = "UTF-8", to = "UTF-8", sub = "")
  text <- stri_trans_general(text, "latin-ascii")
  text <- gsub("[[:cntrl:]]", " ", text)
  text <- gsub("\\s+", " ", text)
# # Remove specific phrases/combinations from analysis
  phrasesForRemoval <- c(
    "Mandate for Leadership: The Conservative Promise",
    "Mandate for Leadership",
    "The Conservative Promise",
    "Mandate Leadership Conservative Promise",
   "Mandate Leadership",
   "Conservative Promise",
   "Section 1: Taking The Reins of Government",
   "Section 2: The Common Defense",
   "Section 3: The General Welfare",
    "Section 4: The Economy",
    "Section 5: Independent Regulatory Agencies")
  for (phrase in phrasesForRemoval) {
    text <- gsub(phrase, "", text, ignore.case = TRUE)}
  return(text)}

#Creating a function to preprocess the corpus, removing formatting for analysis. 
corpPreprocess <- function(text_data) {
  corpus <- Corpus(VectorSource(text_data))
  corpus <- tm_map(corpus, content_transformer(cleanText))
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removeWords, stopwords('english'))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, content_transformer(function(x) gsub('http[[:alnum:]]*', ' ', x)))
  corpus <- tm_map(corpus, content_transformer(function(x) gsub('[\r\n]', ' ', x)))
  corpus <- tm_map(corpus, content_transformer(function(x) gsub('[\t]', ' ', x)))
  return(corpus)}

#Creating a function to handle the .docx file and clean the text.
processDocX <- function(docPath) {
  # Read the Word document
  doc <- read_docx(docPath)
  docText <- docx_summary(doc)$text
  cleanTextData <- cleanText(paste(docText, collapse = " "))
  corpus <- corpPreprocess(cleanTextData)
  return(corpus)}

bookBySectionPath <-  c("C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Section1.docx",
                        "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Section2.docx",
                        "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Section3.docx",
                        "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Section4.docx",
                        "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Section5.docx")

#Preprocessing
corpusList <- lapply(bookBySectionPath, processDocX)
combinedCorpus <- do.call(c, corpusList)
DTM <- DocumentTermMatrix(combinedCorpus)
rowTotals <- apply(DTM, 1, sum)
DTM <- DTM[rowTotals > 0, ]

#Creating a word cloud.
#Frequency Analysis for a word cloud.
wordFreq <- sort(colSums(as.matrix(DTM)), decreasing = TRUE)
wordFreqDF <- data.frame(term = names(wordFreq), freq = wordFreq)
set.seed(1234)
par(mar = c(1, 1, 1, 1))
#Plotting the word cloud.
wordcloud(words = wordFreqDF$term, freq = wordFreqDF$freq, min.freq = 2,
          max.words = 200, random.order = FALSE, rot.per = 0.35,
          colors = gray.colors(8, start = 0.2, end = 0.8, gamma = 2.2))
title(main = "Project 2025 Word Cloud", line = -2)

#Creating a visualization of section size in a bar chart.
sectionSizes <- sapply(corpusList, function(corpus) {
  sum(sapply(corpus, function(doc) length(unlist(strsplit(as.character(doc), " ")))))})
sectionNames <- c("Section 1", "Section 2", "Section 3", "Section 4", "Section 5")
colors <- gray.colors(length(sectionSizes))
calcPerc <- round((sectionSizes / sum(sectionSizes)) * 100, 1)
df <- data.frame(Section = sectionNames, Size = sectionSizes, Percentage = calcPerc)
#Plotting the bar chart.
plot <- ggplot(df, aes(x = reorder(Section, Size), y = Size, fill = Section)) +
  geom_bar(stat = "identity", fill = "grey") +
  geom_text(aes(label = paste(Percentage, "%")), vjust = -0.5, size = 4, color = "black") +
  labs(title = "Size of Each Section", x = NULL, y = "Size (Word Count)") +
  theme_minimal() +
  theme(
    legend.position = "none", # Remove legend
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(color = "black"),  # Section titles on x-axis
    axis.text.y = element_text(color = "black"),  # Y-axis labels in black
    axis.title = element_text(color = "black"),
    plot.title = element_text(color = "black", hjust = 0.5)  # Center the title
  ) +
  scale_x_discrete(labels = sectionNames)
print(plot)

#Defining paths to all chapter files.
allChaptersPath <- c("C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter1.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter2.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter3.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter4.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter5.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter6.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter7.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter8.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter9.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter10.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter11.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter12.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter13.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter14.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter15.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter16.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter17.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter18.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter19.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter20.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter21.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter22.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter23.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter24.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter25.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter26.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter27.docx",                     
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter28.docx",
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter29.docx", 
                     "C:/Users/emmax/OneDrive/Documents/DataProjects/P2025Chapter30.docx")

#Plot negative and positive emotion scores by chapter.
chapterTexts <- lapply(allChaptersPath, function(path) {
  corpus <- processDocX (path)
  sapply(corpus, as.character)})
chapterSentiments <- lapply(chapterTexts, function(section) {
  get_nrc_sentiment(section)})
# Plot negative and positive emotions by chapter using the automatic sentiment scores
plotSentimentsByChapter <- function(chapterSentiments) {
  sentimentSummary1 <- lapply(chapterSentiments, function(sentiment_df1) {
    data.frame(Positive = sum(sentiment_df1$positive), Negative = sum(sentiment_df1$negative))})
  combinedSentimentSummary1 <- do.call(rbind, sentimentSummary1)
  combinedSentimentSummary1$Section <- 1:nrow(combinedSentimentSummary1)
  #Plotting the line graph. 
  combinedSentimentPlot <- ggplot(combinedSentimentSummary1, aes(x = Section)) +
    geom_line(aes(y = Positive, color = "Positive"), linewidth = 1) +
    geom_line(aes(y = Negative, color = "Negative"), linewidth = 1) +
    labs(y = "Emotion", x = "Chapter", title = "Positive and Negative Emotions by Chapter") +
    scale_color_manual(values = c("Positive" = "darkgray", "Negative" = "black")) +
    theme_minimal() +
    theme(legend.title = element_blank())+
    theme(plot.title = element_text(hjust = 0.5)) 
    theme(panel.grid.major = element_blank())     
    theme (panel.grid.minor = element_blank())      
  return(list(combinedSentimentPlot))}

#Creating visualizations for emotion by chapter.
#Preprocessing the data
plotIndividualEmotionsByChapter <- function(chapterSentiments) {
  emotionList <- c("joy", "anticipation", "trust", "surprise", 
                   "anger", "disgust", "fear", "sadness")
  emotionDataList <- list()
  for (emotion in emotionList) {
    emotionSummary <- sapply(chapterSentiments, function(sentiment_df) {
      sum(sentiment_df[[emotion]])
    })  # There may be an issue here.
    emotionData <- data.frame(Emotion = emotionSummary, Chapter = 1:length(emotionSummary))
    emotionDataList[[emotion]] <- emotionData
    #Plotting the graphs.
    plot <- ggplot(emotionData, aes(x = factor(Chapter), y = Emotion)) +
      geom_bar(stat = "identity", fill = "darkgray") +
      labs(y = "Emotion Count", x = "Chapter", title = paste(emotion)) +
      ylim(0, 250) +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5)) 
      theme(panel.grid.major = element_blank())     
      theme (panel.grid.minor = element_blank())      
    print(plot)
  }
  return(emotionDataList)
} 

# Generate the plots
sentimentPlots1 <- plotSentimentsByChapter(chapterSentiments)
individualEmotionPlots <- plotIndividualEmotionsByChapter(chapterSentiments)

# Display the line chart of positive and negative emotions
print(sentimentPlots1[[1]])

#Creating bar charts for the top 15 most used Ngrams by chapter.
for (i in 1:length(chapterTexts)) {
  chapterTextVector <- sapply(chapterTexts[[i]], as.character)
  tokens <- tokens(chapterTextVector, remove_punct = TRUE)
  bigrams <- textstat_collocations(tokens, size = 2)
  trigrams <- textstat_collocations(tokens, size = 3)
  bigramsDF <- as.data.frame(bigrams)
  bigramsDF$size <- "Bigram"
  trigramsDF <- as.data.frame(trigrams)
  trigramsDF$size <- "Trigram"
  #Limiting to the top 15 bigrams.
  topBigramsDF <- bigramsDF[order(-bigramsDF$count),][1:15,]
  topTrigramsDF <- trigramsDF[order(-trigramsDF$count),][1:15,]
  #Stacking nGrams for plotting.
  ngramsDF <- rbind(topBigramsDF, topTrigramsDF)
  # Plotting Ngrams.
  plot <- ggplot(ngramsDF, aes(x = reorder(collocation, count), y = count, fill = size)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = count), hjust = -0.3) + 
    coord_flip() +
    facet_wrap(~ size, scales = "free_y", ncol = 1) +
    ylim(0, 80) +  
    labs(title = paste("Most Used Two and Three Word Combinations - Chapter", i), x = " ", y = "Count") +
    theme(plot.title = element_text(hjust = 0.5)) +
    scale_fill_manual(values = c("Bigram" = "#D3D3D3", "Trigram" = "#A9A9A9")) +
    theme(panel.grid.major = element_blank(),  
          panel.grid.minor = element_blank())  
  print(plot)}

#Creating bar charts of section size by chapter.
#Processing
sections <- list("Section 1" = 1:3, "Section 2" = 4:9, "Section 3" = 10:20, "Section 4" = 21:26, "Section 5" = 27:30)
chaptersList <- lapply(allChaptersPath, processDocX)
chapterSizes <- sapply(chaptersList, function(corpus) {
  sum(sapply(corpus, function(doc) length(unlist(strsplit(as.character(doc), " ")))))})
#Creating a loop to loop through sections and get chapter size. 
for (sectionName in names(sections)) {
  sectionChapters <- sections[[sectionName]]
  sectionDf <- data.frame(
    Chapter = factor(paste("Chapter", sectionChapters)),  
    Size = chapterSizes[sectionChapters],
    Section = rep(sectionName, length(sectionChapters)))
  #Plotting the bar charts.
  plot <- ggplot(sectionDf, aes(x = reorder(Chapter, -Size), y = Size, fill = Chapter)) +
    geom_bar(stat = "identity", color = "white", width = 0.7) +
    geom_text(aes(label = paste0(round((Size / sum(Size)) * 100, 1), "%")), vjust = -0.5, color = "black", size = 5) +
    scale_fill_grey(start = 0.8, end = 0.2) +  # Grayscale colors
    labs(title = paste("Size of Each Chapter -", sectionName), x = NULL, y = "Size (in words)") +
    ylim(0, 12000) + 
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 0, hjust = 0.5, size = 12), 
      axis.text.y = element_text(size = 12),
      axis.title.x = element_blank(),
      axis.title.y = element_text(size = 14),
      plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.position = "none")
  
  print(plot)
}

#Plotting a bar chart of footnote counts by chapter.
chapters <- 1:30
footnotes <- c(10, 45, 31, 47, 20, 27, 49, 55, 18, 128, 19, 133, 57, 87, 44, 97, 98, 25, 16, 7, 9, 76, 35, 34, 74, 78, 56, 28, 16, 30)
data <- data.frame(Chapter = as.factor(chapters), Footnotes = footnotes)
ggplot(data, aes(x = Chapter, y = Footnotes)) +
  geom_bar(stat = "identity", fill = "darkgray", color = "black") +
  labs(title = "Footnote Counts by Chapter", x = "Chapter", y = "Footnotes") +
  theme_minimal()