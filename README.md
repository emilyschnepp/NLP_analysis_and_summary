<h1>Neutral Natural Language Processing: Analysis and Summary</h1>
<h2>Overview</h2>
This project uses natural language processing (NLP) techniques to summarize and analyze Mandate for Leadership: The Conservative Promise, a book widely discussed in the 2024 election cycle. The book, published by The Heritage Foundation, is often presented as memes on social media. Memes aren't always the best way to get important information. This project aims to deliver a summary and analysis for those unable to traverse its 900 pages. 
<br>
<br>
This project includes a full abstractive summary of the book, along with key analyses in areas such as emotion detection, metadata analysis, and readability metrics. The hope is that this will help readers engage with accurate information to form their own opinions. 
<h2>Project Summary</h2>
<h3>Coding Languages</h3> 
• R
<br>
• Python
<h3>Data:</h3>
The dataset is a nearly 900-page document released by The Heritage Foundation, outlining a hopeful political agenda for 2025. It is available at: https://static.project2025.org/2025_MandateForLeadership_FULL.pdf

<h3>Tools & Libraries Used</h3>
<h4>Python Libraries:</h4>
• nltk (punkt, stopwords, averaged_perception_tagger, wordnet, brown)
<br>
• spacy (en_core_web_sm)
<br>
• transformers (BartTokenizer, BartForConditionalGeneration)
<br>
• Additional Python libraries, including re, scikit-learn, LDA, numpy, docx, textstat, pandas, seaborn
<h4>R Packages:</h4> 
• Additional R packages, including tm, tidyverse, textclean, quanteda, stringi, ggplot2, wordcloud, quanteda.textstats, officer, syuzhet.
<h3>Data Preprocessing</h3>
Preprocessing in both Python and R included text extraction from a '.docx' file, text cleaning, and tokenization. Specific steps included: 
<br>
<br>
• UTF-8 and ASCII encoding
<br>
• Reducing whitespace
<br>
• Removing irrelevant phrases, stopwords, punctuation, numbers, URLs, and newline/tab characters
<br>
• Converting text to lowercase
<br>
• For summarization, text chunks were tokenized to ensure compatibility with BART's token limits
<h3>Analysis Types</h3>
<h4>Natural Language Processing Exploratory Analysis, specifically:</h4>
• Word Clouds: Visual representations of the most frequent terms in the text. 
<br>
• Section Size Analysis: Bar charts showing the word count of each chapter within its respective section for comparison. 
<br>
• N-grams Analysis: Bigram and trigram analysis was performed for each chapter, and the most frequent combinations were visualized using bar charts. 
<h4>Emotion Detection:</h4> 
Using the NRC Emotion Lexicon, emotions such as joy, anticipation, trust, suprise, anger, disgust, fear, and sadness were detected and visualized. The analysis involved: 
<br>
Bar charts for each emotion by chapter. 
<br>
A line chart comparing positive and negative emotions across chapters. 
<h4>Metadata Analysis:</h4>
Footnote Count by Chapter: A bar chart was created to display the number of footnotes per chapter, giving insight into which chapters relied more on citations or additional commentary. 
<h4>Textual Complexity and Readability Metrics</h4>
This analysis focused on calculating readability scores such as Flesch-Kincaid Grade, Gunning Fog Index, and Coleman-Liau Index to assess the text's complexity. Visualizations include radar charts and line plots. 
<h4>Abstractive Summarization Using BART</h4>
The document was summarized using the BART-Large-CNN model. The text was divided into smaller sections to accommodate the token limits of the BART model. Topic modeling using LDA was applied to organize the summaries. 
<h2>Key Findings:</h2>
<h4>Word Frequency:</h4> Common words include government, state, national, policy, programs, department, agencies, federal, administration, and president. 
<h4>Emotion Trends:</h4> Trust appeared most frequently, while Chapter 17 (Department of Justice) showed the highest levels of anger and disgust. 
<h4>Textual Complexity:</h4> Readability scores indicate a moderate range of complexity, with most chapters scoring between grades 13 and 17 on the Flesch-Kincaid scale.
<h4>Readability Metrics:</h4> • Chapter 17 (Department of Justice) had the highest reading complexity, with a Flesch-Kincaid grade of ~17.
<br>
• Chapter 19 (Department of Transportation) had easier readability, with a Flesch-Kincaid grade of ~13. 
<h2>Next Steps</h2>
This project provides a comprehensive, unbiased summary of Mandate for Leadership and opens the door for further analysis. Further improvements could include:
<br>
<br>
• Visualizing emotion-related words by chapter in order to provide more context.
<br>
• Simplifying the language used in the summaries for wider accessibility.
<br>
• Implementing a stacked ensemble model to balance biases across summarization techniques (e.g., combining BART with T5 or GPT-based models). 
<br>
• Summarizing sections more granularly to include section introductions and parts of chapters distinctly set aside from the rest. 
