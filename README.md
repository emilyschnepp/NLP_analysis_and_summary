<h1>Neutral Natural Language Processing: Analysis and Summary<h1></h1>
<br>
<br>
<h2>Overview</h2>
<br>
<br>
This project uses natural language processing (NLP) techniques to summarize and analyze Mandate for Leadership: The Conservative Promise, a book widely discussed in the 2024 election cycle. The book, published by The Heritage Foundation, is often presented as memes on social media. Memes aren't always the best way to get important information. My goal is to provide an unbiased analysis of the book, making it more accessible for those who don't have the time to read all 900 pages. 
<br>
This project includes a full abstractive summary of the book, along with key analyses in areas such as emotion detection, metadata analysis, and readability metrics. The hope is that this will help readers engage with accurate information to form their own opinions. 
<br>
<br>
<h2>Project Summary</h2>
<br>
<br>
<h3>Coding Languages:</h3>
<br>
R
<br>
Python
<br>
<br>
<h3>Data:</h3>
<br>
The dataset consists of a nearly 900-page document released by The Heritage Foundation, which outlines a hopeful political agenda for 2025. It was obtained from this source https://static.project2025.org/2025_MandateForLeadership_FULL.pdf
<br>
<br>
<h3>Data Preprocessing:</h3>
<br>
Preprocessing in both Python and R included text extraction from a '.docx' file, text cleaning, and tokenization. Specific steps included: 
<br>
UTF-8 and ASCII encoding
Reducing whitespace
Removing irrelevant phrases, stopwords, punctuation, numbers, URLs, and newline/tab characters
Converting text to lowercase
For summarization, text chunks were tokenized to ensure compatibility with BART's token limits
<br>
<br>
<h3>Tools & Libraries Used</h3>
<br>
<h4>Python Libraries:</h4>
<br>
nltk (punkt, stopwords, averaged_perception_tagger, wordnet, brown)
<br>
spacy (en_core_web_sm)
<br>
transformers (BartTokenizer, BartForConditionalGeneration)
<br>
math (pi)
<br>
re, scikit-learn, LDA, numpy, docx, textstat, pandas, seaborn
<br>
<br>
<h4>R Packages:</h4> 
<br>
tm, tidyverse, textclean, quanteda, stringi, ggplot2, wordcloud, quanteda.textstats, officer, syuzhet.
<br>
<br>
<h3>Analysis Types</h3>
<br>
<h4>Natural Language Processing Exploratory Analysis, specifically:</h4>
<br>
Word Clouds: Visual representations of the most frequent terms in the text. 
<br>
Section Size Analysis: Bar charts showing the word count of each chapter within its respective section for comparison. 
<br>
N-grams Analysis: Bigram and trigram analysis was performed for each chapter, and the most frequent combinations were visualized using bar charts. 
<br>
<br>
<h4>Emotion Detection:</h4> 
<br>
Using the NRC Emotion Lexicon, emotions such as joy, anticipation, trust, suprirse, anger, disgust, fear, and sadness were detected and visualized. The analysis involved: 
<br>
Bar charts for each emotion by chapter. 
<br>
A line chart comparing positive and negative emotions across chapters. 
<br>
<br>
<h4>Metadata Analysis:</h4>
<br>
Footnote Count by Chapter: A bar chart was created to display the number of footnotes per chapter, giving insight into which chapters relied more on citations or additonal commentary. 
<br>
<br>
<h4>Textual Complexity and Readability Metrics</h4>
<br>
This analysis focused on calculating readability scores such as Flesch-Kincaid Grade, Gunning Fog Index, and Coleman-Liau Index to assess the text's complexity. Visualizations include radar charts and line plots. 
<br>
<h4>Abstractive Summarization Using BART</h4>
<br>
The document was summarized using the BART-Large-CNN model. The text was chunked to fit within BART's token limitations, and the summarization process was enhanced through beam search. Topic modeling using LDA was applied to organize the summaries. 
<br>
<br>
<h2>Key Findings:</h2>
<br>
<h5>Word Frequency:</h5> Common words include government, state, national, policy, programs, department, agencies, federal, administration, and president. 
<br>
<h5>Emotion Trends:</h5> Trust appeared most frequently, while Chapter 17 (Department of Justice) showed the highest levels of anger and disgust. 
<br>
<h5>Textual Complexity:</h5> Readability scores indicate a moderate range of complexity, with most chapters scoring between grades 13 and 17 on the Flesch-Kincaid scale.
<br>
<br>
<h5>Readability Metrics:</h5> 
<br>
Chapter 17 (Department of Justice) had the highest Flesch-Kincaid grade (~17), indicating high complexity. 
<br>
Chapter 19 (Department of Transportation) had the lowest (~13), suggesting easier readability. 
<br>
<br>
<h2>Conclusions and Next Steps</h2>
<br>
This project provides a comprehensive, unbiased summary of Mandate for Leadership and opens the door for further analysis. Further improvements could include:
<br>
Vusializing emotion-related words by chapter. 
<br>
Simplifying the language in the summaries. 
<br>
Implementing an ensemble model to balance biases across summarization techniques (e.g., combining BART with T5 or GPT-based models). 
<br>
Summarizing sections more granularly. 
<br>
