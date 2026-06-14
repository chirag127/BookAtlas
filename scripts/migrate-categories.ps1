# BookAtlas Migration Script
# Migrates old 32-category taxonomy to new 10-category taxonomy

$ErrorActionPreference = "Continue"
$knowledgeRoot = "C:\AM\GitHub\BookAtlas\knowledge"

# ============================================================
# STEP 1: Define the migration mapping
# Old subcategory -> New (top-category, leaf-category)
# ============================================================

$mappings = @()

# 01-health-fitness-longevity -> 02-body-health-and-life-sciences
$mappings += @{OldCat="01-health-fitness-longevity"; OldSub="exercise-science-and-physical-training"; NewTop="02-body-health-and-life-sciences"; NewSub="exercise-and-fitness"}
$mappings += @{OldCat="01-health-fitness-longevity"; OldSub="longevity-research-and-aging"; NewTop="02-body-health-and-life-sciences"; NewSub="longevity-and-aging"}
$mappings += @{OldCat="01-health-fitness-longevity"; OldSub="mental-health-and-neurocognitive-performance"; NewTop="02-body-health-and-life-sciences"; NewSub="neuroscience-and-brain-health"}
$mappings += @{OldCat="01-health-fitness-longevity"; OldSub="nutrition-for-performance-and-health"; NewTop="02-body-health-and-life-sciences"; NewSub="nutrition-and-diet"}
$mappings += @{OldCat="01-health-fitness-longevity"; OldSub="peak-physical-performance"; NewTop="02-body-health-and-life-sciences"; NewSub="exercise-and-fitness"}
$mappings += @{OldCat="01-health-fitness-longevity"; OldSub="sleep-science-and-optimization"; NewTop="02-body-health-and-life-sciences"; NewSub="sleep-science"}
$mappings += @{OldCat="01-health-fitness-longevity"; OldSub="sleep-science-and-optimization/sleep-biology-and-circadian-mechanisms"; NewTop="02-body-health-and-life-sciences"; NewSub="sleep-science"; IsNested=$true}

# 02-medicine-health-sciences -> 02-body-health-and-life-sciences
$mappings += @{OldCat="02-medicine-health-sciences"; OldSub="anatomy-and-physiology"; NewTop="02-body-health-and-life-sciences"; NewSub="medicine-and-clinical-science"}
$mappings += @{OldCat="02-medicine-health-sciences"; OldSub="medical-history-and-bioethics"; NewTop="02-body-health-and-life-sciences"; NewSub="medicine-and-clinical-science"}
$mappings += @{OldCat="02-medicine-health-sciences"; OldSub="nutrition-science"; NewTop="02-body-health-and-life-sciences"; NewSub="nutrition-and-diet"}
$mappings += @{OldCat="02-medicine-health-sciences"; OldSub="pathophysiology-and-clinical-medicine"; NewTop="02-body-health-and-life-sciences"; NewSub="medicine-and-clinical-science"}
$mappings += @{OldCat="02-medicine-health-sciences"; OldSub="pharmacology"; NewTop="02-body-health-and-life-sciences"; NewSub="medicine-and-clinical-science"}
$mappings += @{OldCat="02-medicine-health-sciences"; OldSub="psychiatry-and-mental-health"; NewTop="02-body-health-and-life-sciences"; NewSub="psychiatry-and-mental-health"}
$mappings += @{OldCat="02-medicine-health-sciences"; OldSub="public-health-and-epidemiology"; NewTop="02-body-health-and-life-sciences"; NewSub="medicine-and-clinical-science"}

# 03-biology-life-sciences -> 02-body-health-and-life-sciences
$mappings += @{OldCat="03-biology-life-sciences"; OldSub="cell-biology-and-biochemistry"; NewTop="02-body-health-and-life-sciences"; NewSub="biology-and-life-sciences"}

# 04-self-help-personal-development -> 01-mind-behavior-and-human-performance
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="confidence-self-esteem-and-assertiveness"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="financial-self-help"; NewTop="03-money-markets-and-wealth"; NewSub="personal-finance"}
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="goal-setting-and-achievement"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="mens-and-womens-development"; NewTop="01-mind-behavior-and-human-performance"; NewSub="personality-psychology"}
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="mental-health-and-emotional-wellbeing"; NewTop="01-mind-behavior-and-human-performance"; NewSub="positive-psychology"}
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="mindset-and-belief-systems"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="relationships-and-social-skills"; NewTop="01-mind-behavior-and-human-performance"; NewSub="social-psychology"}
$mappings += @{OldCat="04-self-help-personal-development"; OldSub="spirituality-and-life-meaning"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}

# 05-productivity-performance -> 01-mind-behavior-and-human-performance
$mappings += @{OldCat="05-productivity-performance"; OldSub="attention-management-and-deep-work"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}
$mappings += @{OldCat="05-productivity-performance"; OldSub="creativity-and-innovation"; NewTop="01-mind-behavior-and-human-performance"; NewSub="creativity-and-innovation"}
$mappings += @{OldCat="05-productivity-performance"; OldSub="energy-management"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}
$mappings += @{OldCat="05-productivity-performance"; OldSub="habit-formation-and-behavioral-systems"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}
$mappings += @{OldCat="05-productivity-performance"; OldSub="knowledge-management"; NewTop="01-mind-behavior-and-human-performance"; NewSub="learning-and-skill-acquisition"}
$mappings += @{OldCat="05-productivity-performance"; OldSub="learning-and-skill-acquisition"; NewTop="01-mind-behavior-and-human-performance"; NewSub="learning-and-skill-acquisition"}
$mappings += @{OldCat="05-productivity-performance"; OldSub="time-management-and-prioritization"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}

# 06-productivity -> 01-mind-behavior-and-human-performance
$mappings += @{OldCat="06-productivity"; OldSub="personal-effectiveness"; NewTop="01-mind-behavior-and-human-performance"; NewSub="habits-productivity-and-focus"}

# 07-decision-making-systems-thinking -> 01-mind-behavior-and-human-performance
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="cognitive-biases-and-debiasing"; NewTop="01-mind-behavior-and-human-performance"; NewSub="cognitive-biases-and-rationality"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="decision-making"; NewTop="01-mind-behavior-and-human-performance"; NewSub="mental-models-and-decision-making"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="forecasting-and-prediction"; NewTop="01-mind-behavior-and-human-performance"; NewSub="probability-forecasting-and-risk"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="game-theory-applied"; NewTop="01-mind-behavior-and-human-performance"; NewSub="systems-thinking-and-game-theory"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="mental-models-and-multidisciplinary-thinking"; NewTop="01-mind-behavior-and-human-performance"; NewSub="mental-models-and-decision-making"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="probabilistic-and-bayesian-reasoning"; NewTop="01-mind-behavior-and-human-performance"; NewSub="probability-forecasting-and-risk"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="risk-and-uncertainty"; NewTop="01-mind-behavior-and-human-performance"; NewSub="probability-forecasting-and-risk"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="systems-thinking-and-cybernetics"; NewTop="01-mind-behavior-and-human-performance"; NewSub="systems-thinking-and-game-theory"}
$mappings += @{OldCat="07-decision-making-systems-thinking"; OldSub="thinking-in-bets-annie-duke"; NewTop="01-mind-behavior-and-human-performance"; NewSub="mental-models-and-decision-making"}

# 08-psychology -> 01-mind-behavior-and-human-performance
$mappings += @{OldCat="08-psychology"; OldSub="behavioral-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="behavioral-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="behavioral-psychology-and-learning-theory"; NewTop="01-mind-behavior-and-human-performance"; NewSub="behavioral-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="clinical-psychology-and-psychotherapy"; NewTop="01-mind-behavior-and-human-performance"; NewSub="clinical-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="cognitive-biases"; NewTop="01-mind-behavior-and-human-performance"; NewSub="cognitive-biases-and-rationality"}
$mappings += @{OldCat="08-psychology"; OldSub="cognitive-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="cognitive-and-behavioral-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="developmental-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="behavioral-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="evolutionary-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="evolutionary-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="existential-and-humanistic-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="clinical-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="industrial-organizational-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="industrial-organizational-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="netropsychology-and-biological-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="cognitive-and-behavioral-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="neuropsychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="cognitive-and-behavioral-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="neuroscience-and-cognition"; NewTop="01-mind-behavior-and-human-performance"; NewSub="cognitive-and-behavioral-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="personality-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="personality-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="positive-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="positive-psychology"}
$mappings += @{OldCat="08-psychology"; OldSub="social-psychology"; NewTop="01-mind-behavior-and-human-performance"; NewSub="social-psychology"}

# 09-philosophy -> 06-philosophy-religion-and-indian-thought
$mappings += @{OldCat="09-philosophy"; OldSub="aesthetics"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="eastern-philosophy"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="eastern-philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="epistemology"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="ethics-and-moral-philosophy"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="ethics-and-moral-philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="existentialism"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="western-philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="indian-philosophy"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="indian-philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="logic-and-critical-thinking"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="metaphysics-and-ontology"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="non-western-and-comparative-philosophy"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="comparative-philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="philosophy-of-mind-and-language"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="political-philosophy"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="philosophy"}
$mappings += @{OldCat="09-philosophy"; OldSub="western-philosophy-by-era"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="western-philosophy"}

# 10-religion-spirituality -> 06-philosophy-religion-and-indian-thought
$mappings += @{OldCat="10-religion-spirituality"; OldSub="abrahamic-religions"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}
$mappings += @{OldCat="10-religion-spirituality"; OldSub="atheism-agnosticism-and-secular-humanism"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}
$mappings += @{OldCat="10-religion-spirituality"; OldSub="comparative-religion"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}
$mappings += @{OldCat="10-religion-spirituality"; OldSub="dharmic-religions"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}
$mappings += @{OldCat="10-religion-spirituality"; OldSub="east-asian-religions"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}
$mappings += @{OldCat="10-religion-spirituality"; OldSub="mind-body-spirit-and-spirituality"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}
$mappings += @{OldCat="10-religion-spirituality"; OldSub="mysticism-and-esoteric-traditions"; NewTop="06-philosophy-religion-and-indian-thought"; NewSub="religion-and-spirituality"}

# 11-finance-investing -> 03-money-markets-and-wealth
$mappings += @{OldCat="11-finance-investing"; OldSub="alternative-investments"; NewTop="03-money-markets-and-wealth"; NewSub="investment-theory-and-principles"}
$mappings += @{OldCat="11-finance-investing"; OldSub="behavioral-finance"; NewTop="03-money-markets-and-wealth"; NewSub="behavioral-finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="derivatives-and-structured-products"; NewTop="03-money-markets-and-wealth"; NewSub="finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="equity-investing"; NewTop="03-money-markets-and-wealth"; NewSub="investment-theory-and-principles"}
$mappings += @{OldCat="11-finance-investing"; OldSub="financial-history"; NewTop="03-money-markets-and-wealth"; NewSub="finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="fixed-income-and-bond-markets"; NewTop="03-money-markets-and-wealth"; NewSub="finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="indian-finance"; NewTop="03-money-markets-and-wealth"; NewSub="indian-finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="investment-theory-and-principles"; NewTop="03-money-markets-and-wealth"; NewSub="investment-theory-and-principles"}
$mappings += @{OldCat="11-finance-investing"; OldSub="macro-investing-and-global-markets"; NewTop="03-money-markets-and-wealth"; NewSub="macroeconomics"}
$mappings += @{OldCat="11-finance-investing"; OldSub="personal-finance-and-wealth-building"; NewTop="03-money-markets-and-wealth"; NewSub="personal-finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="quantitative-finance"; NewTop="03-money-markets-and-wealth"; NewSub="finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="real-estate-investing"; NewTop="03-money-markets-and-wealth"; NewSub="investment-theory-and-principles"}
$mappings += @{OldCat="11-finance-investing"; OldSub="risk-management"; NewTop="03-money-markets-and-wealth"; NewSub="finance"}
$mappings += @{OldCat="11-finance-investing"; OldSub="venture-capital-and-private-equity"; NewTop="03-money-markets-and-wealth"; NewSub="finance"}

# 12-business-management-entrepreneurship -> 05-business-strategy-and-organizations
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="business-strategy"; NewTop="05-business-strategy-and-organizations"; NewSub="business-strategy"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="consulting-and-frameworks"; NewTop="05-business-strategy-and-organizations"; NewSub="consulting-and-frameworks"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="corporate-finance-and-accounting"; NewTop="05-business-strategy-and-organizations"; NewSub="corporate-finance-and-accounting"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="entrepreneurship-and-startups"; NewTop="05-business-strategy-and-organizations"; NewSub="entrepreneurship-and-startups"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="leadership-and-executive-development"; NewTop="05-business-strategy-and-organizations"; NewSub="leadership"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="management-and-organizational-behavior"; NewTop="05-business-strategy-and-organizations"; NewSub="management-and-organizational-behavior"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="marketing-and-brand-strategy"; NewTop="05-business-strategy-and-organizations"; NewSub="marketing-and-brand-strategy"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="operations-and-supply-chain"; NewTop="05-business-strategy-and-organizations"; NewSub="operations-and-supply-chain"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="product-management"; NewTop="05-business-strategy-and-organizations"; NewSub="product-management"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="sales-and-business-development"; NewTop="05-business-strategy-and-organizations"; NewSub="sales-and-business-development"}
$mappings += @{OldCat="12-business-management-entrepreneurship"; OldSub="small-business-and-micro-enterprises"; NewTop="05-business-strategy-and-organizations"; NewSub="entrepreneurship-and-startups"}

# 13-economics-economic-theory -> 03-money-markets-and-wealth
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="behavioral-economics"; NewTop="03-money-markets-and-wealth"; NewSub="behavioral-economics"}
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="development-economics"; NewTop="03-money-markets-and-wealth"; NewSub="development-economics"}
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="ecological-and-environmental-economics"; NewTop="03-money-markets-and-wealth"; NewSub="political-economy"}
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="history-of-economic-thought"; NewTop="03-money-markets-and-wealth"; NewSub="history-of-economic-thought"}
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="international-trade-and-globalization"; NewTop="03-money-markets-and-wealth"; NewSub="macroeconomics"}
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="macroeconomics"; NewTop="03-money-markets-and-wealth"; NewSub="macroeconomics"}
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="microeconomics"; NewTop="03-money-markets-and-wealth"; NewSub="microeconomics"}
$mappings += @{OldCat="13-economics-economic-theory"; OldSub="political-economy"; NewTop="03-money-markets-and-wealth"; NewSub="political-economy"}

# 14-communication-language-linguistics -> 09-communication-writing-and-creativity
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="communication-theory"; NewTop="09-communication-writing-and-creativity"; NewSub="communication-theory"}
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="language-acquisition-and-learning"; NewTop="09-communication-writing-and-creativity"; NewSub="language-learning"}
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="linguistics"; NewTop="09-communication-writing-and-creativity"; NewSub="linguistics"}
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="persuasion-and-rhetoric"; NewTop="09-communication-writing-and-creativity"; NewSub="persuasion-and-rhetoric"}
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="public-speaking-and-presentation"; NewTop="09-communication-writing-and-creativity"; NewSub="public-speaking-and-presentation"}
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="specific-languages"; NewTop="09-communication-writing-and-creativity"; NewSub="language-learning"}
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="storytelling"; NewTop="09-communication-writing-and-creativity"; NewSub="storytelling"}
$mappings += @{OldCat="14-communication-language-linguistics"; OldSub="writing-craft-and-nonfiction-writing"; NewTop="09-communication-writing-and-creativity"; NewSub="writing-craft-and-nonfiction"}

# 15-education-pedagogy -> 09-communication-writing-and-creativity
$mappings += @{OldCat="15-education-pedagogy"; OldSub="curriculum-design-and-instructional-design"; NewTop="09-communication-writing-and-creativity"; NewSub="curriculum-design-and-instructional-design"}
$mappings += @{OldCat="15-education-pedagogy"; OldSub="educational-technology"; NewTop="09-communication-writing-and-creativity"; NewSub="learning-science-and-cognitive-science-of-learning"}
$mappings += @{OldCat="15-education-pedagogy"; OldSub="higher-education"; NewTop="09-communication-writing-and-creativity"; NewSub="philosophy-and-history-of-education"}
$mappings += @{OldCat="15-education-pedagogy"; OldSub="learning-science-and-cognitive-science-of-learning"; NewTop="09-communication-writing-and-creativity"; NewSub="learning-science-and-cognitive-science-of-learning"}
$mappings += @{OldCat="15-education-pedagogy"; OldSub="philosophy-and-history-of-education"; NewTop="09-communication-writing-and-creativity"; NewSub="philosophy-and-history-of-education"}
$mappings += @{OldCat="15-education-pedagogy"; OldSub="special-education-and-inclusive-pedagogy"; NewTop="09-communication-writing-and-creativity"; NewSub="special-education-and-inclusive-pedagogy"}

# 16-social-sciences-sociology -> 08-society-history-and-power
$mappings += @{OldCat="16-social-sciences-sociology"; OldSub="anthropology"; NewTop="08-society-history-and-power"; NewSub="sociology-and-anthropology"}
$mappings += @{OldCat="16-social-sciences-sociology"; OldSub="cultural-studies"; NewTop="08-society-history-and-power"; NewSub="cultural-studies"}
$mappings += @{OldCat="16-social-sciences-sociology"; OldSub="demographics-and-population-studies"; NewTop="08-society-history-and-power"; NewSub="demographics-and-population-studies"}
$mappings += @{OldCat="16-social-sciences-sociology"; OldSub="gender-race-and-ethnicity"; NewTop="08-society-history-and-power"; NewSub="gender-race-and-ethnicity"}
$mappings += @{OldCat="16-social-sciences-sociology"; OldSub="global-society-and-world-systems"; NewTop="08-society-history-and-power"; NewSub="global-society-and-world-systems"}
$mappings += @{OldCat="16-social-sciences-sociology"; OldSub="social-problems-and-social-policy"; NewTop="08-society-history-and-power"; NewSub="social-problems-and-social-policy"}
$mappings += @{OldCat="16-social-sciences-sociology"; OldSub="sociology"; NewTop="08-society-history-and-power"; NewSub="sociology-and-anthropology"}

# 17-law-legal-systems -> 08-society-history-and-power
$mappings += @{OldCat="17-law-legal-systems"; OldSub="common-law-traditions"; NewTop="08-society-history-and-power"; NewSub="public-policy-and-law"}
$mappings += @{OldCat="17-law-legal-systems"; OldSub="corporate-and-commercial-law"; NewTop="08-society-history-and-power"; NewSub="public-policy-and-law"}
$mappings += @{OldCat="17-law-legal-systems"; OldSub="foundations-of-law"; NewTop="08-society-history-and-power"; NewSub="public-policy-and-law"}
$mappings += @{OldCat="17-law-legal-systems"; OldSub="indian-law"; NewTop="08-society-history-and-power"; NewSub="public-policy-and-law"}
$mappings += @{OldCat="17-law-legal-systems"; OldSub="international-law"; NewTop="08-society-history-and-power"; NewSub="public-policy-and-law"}
$mappings += @{OldCat="17-law-legal-systems"; OldSub="legal-practice-and-career"; NewTop="08-society-history-and-power"; NewSub="public-policy-and-law"}

# 18-history -> 08-society-history-and-power
$mappings += @{OldCat="18-history"; OldSub="big-history-and-civilization"; NewTop="08-society-history-and-power"; NewSub="world-history-and-civilizations"}
$mappings += @{OldCat="18-history"; OldSub="contemporary-history"; NewTop="08-society-history-and-power"; NewSub="history"}
$mappings += @{OldCat="18-history"; OldSub="economic-and-financial-history"; NewTop="08-society-history-and-power"; NewSub="history"}
$mappings += @{OldCat="18-history"; OldSub="history-of-ideas-and-intellectual-history"; NewTop="08-society-history-and-power"; NewSub="history"}
$mappings += @{OldCat="18-history"; OldSub="history-of-technology"; NewTop="08-society-history-and-power"; NewSub="history"}
$mappings += @{OldCat="18-history"; OldSub="military-history"; NewTop="08-society-history-and-power"; NewSub="history"}
$mappings += @{OldCat="18-history"; OldSub="modern-world-history"; NewTop="08-society-history-and-power"; NewSub="world-history-and-civilizations"}
$mappings += @{OldCat="18-history"; OldSub="regional-history"; NewTop="08-society-history-and-power"; NewSub="history"}
$mappings += @{OldCat="18-history"; OldSub="world-history-and-civilizations"; NewTop="08-society-history-and-power"; NewSub="world-history-and-civilizations"}

# 19-political-science-geopolitics -> 08-society-history-and-power
$mappings += @{OldCat="19-political-science-geopolitics"; OldSub="comparative-politics"; NewTop="08-society-history-and-power"; NewSub="political-science-and-geopolitics"}
$mappings += @{OldCat="19-political-science-geopolitics"; OldSub="democracy-media-and-civil-society"; NewTop="08-society-history-and-power"; NewSub="political-theory-and-philosophy"}
$mappings += @{OldCat="19-political-science-geopolitics"; OldSub="geopolitics-and-great-power-competition"; NewTop="08-society-history-and-power"; NewSub="geopolitics-and-great-power-competition"}
$mappings += @{OldCat="19-political-science-geopolitics"; OldSub="international-relations"; NewTop="08-society-history-and-power"; NewSub="international-relations"}
$mappings += @{OldCat="19-political-science-geopolitics"; OldSub="political-economy"; NewTop="08-society-history-and-power"; NewSub="political-theory-and-philosophy"}
$mappings += @{OldCat="19-political-science-geopolitics"; OldSub="political-theory-and-philosophy"; NewTop="08-society-history-and-power"; NewSub="political-theory-and-philosophy"}
$mappings += @{OldCat="19-political-science-geopolitics"; OldSub="public-policy-and-governance"; NewTop="08-society-history-and-power"; NewSub="public-policy-and-law"}

# 20-pure-sciences -> 07-math-logic-and-science
$mappings += @{OldCat="20-pure-sciences"; OldSub="astronomy-astrophysics-cosmology"; NewTop="07-math-logic-and-science"; NewSub="astronomy-astrophysics-cosmology"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="biology-and-evolution"; NewTop="07-math-logic-and-science"; NewSub="biology-and-evolution"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="chemistry"; NewTop="07-math-logic-and-science"; NewSub="chemistry"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="earth-sciences-and-climate"; NewTop="07-math-logic-and-science"; NewSub="earth-sciences-and-nature"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="evolutionary-biology"; NewTop="07-math-logic-and-science"; NewSub="biology-and-evolution"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="neuroscience"; NewTop="07-math-logic-and-science"; NewSub="neuroscience"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="philosophy-history-of-science"; NewTop="07-math-logic-and-science"; NewSub="history-and-philosophy-of-science"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="physics"; NewTop="07-math-logic-and-science"; NewSub="physics"}
$mappings += @{OldCat="20-pure-sciences"; OldSub="popular-science-and-science-communication"; NewTop="07-math-logic-and-science"; NewSub="popular-science"}

# 21-nature-environment-ecology -> 07-math-logic-and-science
$mappings += @{OldCat="21-nature-environment-ecology"; OldSub="botany-zoology-and-biodiversity"; NewTop="07-math-logic-and-science"; NewSub="biology-and-evolution"}
$mappings += @{OldCat="21-nature-environment-ecology"; OldSub="climate-and-environmental-crisis"; NewTop="07-math-logic-and-science"; NewSub="earth-sciences-and-nature"}
$mappings += @{OldCat="21-nature-environment-ecology"; OldSub="ecology-and-environmental-science"; NewTop="07-math-logic-and-science"; NewSub="earth-sciences-and-nature"}
$mappings += @{OldCat="21-nature-environment-ecology"; OldSub="natural-history-writing"; NewTop="07-math-logic-and-science"; NewSub="popular-science"}

# 22-mathematics-statistics -> 07-math-logic-and-science
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="algebra-and-number-theory"; NewTop="07-math-logic-and-science"; NewSub="mathematics"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="analysis-and-calculus"; NewTop="07-math-logic-and-science"; NewSub="mathematics"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="applied-and-computational-mathematics"; NewTop="07-math-logic-and-science"; NewSub="mathematics"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="foundations-of-mathematics-and-logic"; NewTop="07-math-logic-and-science"; NewSub="mathematics"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="geometry-and-topology"; NewTop="07-math-logic-and-science"; NewSub="mathematics"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="mathematics-for-a-general-audience"; NewTop="07-math-logic-and-science"; NewSub="popular-science"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="probability-theory"; NewTop="07-math-logic-and-science"; NewSub="statistics-and-probability"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="real-and-complex-analysis"; NewTop="07-math-logic-and-science"; NewSub="mathematics"}
$mappings += @{OldCat="22-mathematics-statistics"; OldSub="statistics-and-data-analysis"; NewTop="07-math-logic-and-science"; NewSub="statistics-and-probability"}

# 23-computer-science -> 04-computers-ai-and-software
$mappings += @{OldCat="23-computer-science"; OldSub="algorithms-and-data-structures"; NewTop="04-computers-ai-and-software"; NewSub="data-algorithms-and-databases"}
$mappings += @{OldCat="23-computer-science"; OldSub="compilers-and-language-runtimes"; NewTop="04-computers-ai-and-software"; NewSub="computer-science-theory"}
$mappings += @{OldCat="23-computer-science"; OldSub="computer-architecture-and-organization"; NewTop="04-computers-ai-and-software"; NewSub="computer-science"}
$mappings += @{OldCat="23-computer-science"; OldSub="computer-networking"; NewTop="04-computers-ai-and-software"; NewSub="networking-and-distributed-systems"}
$mappings += @{OldCat="23-computer-science"; OldSub="databases-and-storage-theory"; NewTop="04-computers-ai-and-software"; NewSub="data-algorithms-and-databases"}
$mappings += @{OldCat="23-computer-science"; OldSub="information-theory-and-coding"; NewTop="04-computers-ai-and-software"; NewSub="computer-science-theory"}
$mappings += @{OldCat="23-computer-science"; OldSub="operating-systems-internals"; NewTop="04-computers-ai-and-software"; NewSub="computer-science"}
$mappings += @{OldCat="23-computer-science"; OldSub="programming-languages-and-paradigms"; NewTop="04-computers-ai-and-software"; NewSub="computer-science"}
$mappings += @{OldCat="23-computer-science"; OldSub="security-and-cryptography"; NewTop="04-computers-ai-and-software"; NewSub="cybersecurity"}
$mappings += @{OldCat="23-computer-science"; OldSub="software-engineering-practice"; NewTop="04-computers-ai-and-software"; NewSub="software-engineering"}
$mappings += @{OldCat="23-computer-science"; OldSub="theoretical-computer-science"; NewTop="04-computers-ai-and-software"; NewSub="theory-of-computation"}
$mappings += @{OldCat="23-computer-science"; OldSub="theory-of-computation"; NewTop="04-computers-ai-and-software"; NewSub="theory-of-computation"}

# 24-software-engineering -> 04-computers-ai-and-software
$mappings += @{OldCat="24-software-engineering"; OldSub="api-design-and-integration"; NewTop="04-computers-ai-and-software"; NewSub="software-engineering"}
$mappings += @{OldCat="24-software-engineering"; OldSub="code-quality-and-craft"; NewTop="04-computers-ai-and-software"; NewSub="code-quality-and-craft"}
$mappings += @{OldCat="24-software-engineering"; OldSub="devops-sre-and-platform-engineering"; NewTop="04-computers-ai-and-software"; NewSub="devops-and-platform-engineering"}
$mappings += @{OldCat="24-software-engineering"; OldSub="distributed-systems-implementation"; NewTop="04-computers-ai-and-software"; NewSub="system-design-and-architecture"}
$mappings += @{OldCat="24-software-engineering"; OldSub="engineering-culture-and-team-dynamics"; NewTop="04-computers-ai-and-software"; NewSub="software-engineering"}
$mappings += @{OldCat="24-software-engineering"; OldSub="software-architecture"; NewTop="04-computers-ai-and-software"; NewSub="software-design-principles"}
$mappings += @{OldCat="24-software-engineering"; OldSub="software-design-and-architecture"; NewTop="04-computers-ai-and-software"; NewSub="software-design-principles"}
$mappings += @{OldCat="24-software-engineering"; OldSub="software-design-principles"; NewTop="04-computers-ai-and-software"; NewSub="software-design-principles"}
$mappings += @{OldCat="24-software-engineering"; OldSub="system-design-and-scalability"; NewTop="04-computers-ai-and-software"; NewSub="system-design-and-architecture"}

# 25-artificial-intelligence-machine-learning -> 04-computers-ai-and-software
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="ai-history-philosophy-and-ethics"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="ai-safety-and-alignment"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="computer-vision"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="deep-learning-and-neural-architectures"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="machine-learning-foundations"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="mlops-and-production-ai"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="natural-language-processing"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}
$mappings += @{OldCat="25-artificial-intelligence-machine-learning"; OldSub="reinforcement-learning"; NewTop="04-computers-ai-and-software"; NewSub="artificial-intelligence"}

# 26-technology-engineering -> 04-computers-ai-and-software
$mappings += @{OldCat="26-technology-engineering"; OldSub="biomedical-engineering"; NewTop="04-computers-ai-and-software"; NewSub="engineering-and-technology"}
$mappings += @{OldCat="26-technology-engineering"; OldSub="civil-and-infrastructure-engineering"; NewTop="04-computers-ai-and-software"; NewSub="engineering-and-technology"}
$mappings += @{OldCat="26-technology-engineering"; OldSub="electrical-and-electronics-engineering"; NewTop="04-computers-ai-and-software"; NewSub="engineering-and-technology"}
$mappings += @{OldCat="26-technology-engineering"; OldSub="energy-and-sustainability-engineering"; NewTop="04-computers-ai-and-software"; NewSub="engineering-and-technology"}
$mappings += @{OldCat="26-technology-engineering"; OldSub="history-and-philosophy-of-technology"; NewTop="04-computers-ai-and-software"; NewSub="history-and-philosophy-of-technology"}
$mappings += @{OldCat="26-technology-engineering"; OldSub="materials-science-and-nanotechnology"; NewTop="04-computers-ai-and-software"; NewSub="engineering-and-technology"}
$mappings += @{OldCat="26-technology-engineering"; OldSub="mechanical-engineering"; NewTop="04-computers-ai-and-software"; NewSub="engineering-and-technology"}
$mappings += @{OldCat="26-technology-engineering"; OldSub="robotics-and-automation"; NewTop="04-computers-ai-and-software"; NewSub="engineering-and-technology"}

# 27-biography-memoir -> 10-fiction-and-literature (biography section)
$mappings += @{OldCat="27-biography-memoir"; OldSub="artists-writers-and-musicians"; NewTop="10-fiction-and-literature"; NewSub="artists-writers-and-musicians"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="autobiographies-and-personal-memoirs"; NewTop="10-fiction-and-literature"; NewSub="autobiographies-and-personal-memoirs"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="collected-and-group-biographies"; NewTop="10-fiction-and-literature"; NewSub="autobiographies-and-personal-memoirs"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="entrepreneurs-and-business-builders"; NewTop="10-fiction-and-literature"; NewSub="entrepreneurs-and-business-builders"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="investors-and-financiers"; NewTop="10-fiction-and-literature"; NewSub="entrepreneurs-and-business-builders"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="philosophers-and-intellectuals"; NewTop="10-fiction-and-literature"; NewSub="political-and-military-leaders"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="political-and-military-leaders"; NewTop="10-fiction-and-literature"; NewSub="political-and-military-leaders"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="scientists-and-mathematicians"; NewTop="10-fiction-and-literature"; NewSub="scientists-and-mathematicians"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="social-activists-and-reformers"; NewTop="10-fiction-and-literature"; NewSub="social-activists-and-reformers"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="sports-figures-and-athletes"; NewTop="10-fiction-and-literature"; NewSub="autobiographies-and-personal-memoirs"}
$mappings += @{OldCat="27-biography-memoir"; OldSub="technology-leaders-and-founders"; NewTop="10-fiction-and-literature"; NewSub="technology-leaders-and-founders"}

# 28-fiction -> 10-fiction-and-literature
$mappings += @{OldCat="28-fiction"; OldSub="fantasy"; NewTop="10-fiction-and-literature"; NewSub="fantasy"}
$mappings += @{OldCat="28-fiction"; OldSub="graphic-novels-and-sequential-art"; NewTop="10-fiction-and-literature"; NewSub="genre-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="historical-fiction"; NewTop="10-fiction-and-literature"; NewSub="genre-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="horror-and-gothic-literature"; NewTop="10-fiction-and-literature"; NewSub="horror-and-gothic-literature"}
$mappings += @{OldCat="28-fiction"; OldSub="literary-fiction"; NewTop="10-fiction-and-literature"; NewSub="literary-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="mystery-and-crime-fiction"; NewTop="10-fiction-and-literature"; NewSub="mystery-and-crime-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="mythology-legend-and-epic"; NewTop="10-fiction-and-literature"; NewSub="genre-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="philosophical-and-existential-fiction"; NewTop="10-fiction-and-literature"; NewSub="literary-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="romance"; NewTop="10-fiction-and-literature"; NewSub="genre-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="science-fiction"; NewTop="10-fiction-and-literature"; NewSub="science-fiction"}
$mappings += @{OldCat="28-fiction"; OldSub="short-stories-and-flash-fiction"; NewTop="10-fiction-and-literature"; NewSub="genre-fiction"}

# 29-poetry-drama-performing-arts -> 10-fiction-and-literature
$mappings += @{OldCat="29-poetry-drama-performing-arts"; OldSub="drama-and-theatre"; NewTop="10-fiction-and-literature"; NewSub="drama-and-theatre"}
$mappings += @{OldCat="29-poetry-drama-performing-arts"; OldSub="performing-arts"; NewTop="10-fiction-and-literature"; NewSub="drama-and-theatre"}
$mappings += @{OldCat="29-poetry-drama-performing-arts"; OldSub="poetry"; NewTop="10-fiction-and-literature"; NewSub="poetry-and-drama"}

# 30-music-film-media -> 10-fiction-and-literature
$mappings += @{OldCat="30-music-film-media"; OldSub="film-studies"; NewTop="10-fiction-and-literature"; NewSub="film-and-media-studies"}
$mappings += @{OldCat="30-music-film-media"; OldSub="media-studies"; NewTop="10-fiction-and-literature"; NewSub="film-and-media-studies"}
$mappings += @{OldCat="30-music-film-media"; OldSub="music"; NewTop="10-fiction-and-literature"; NewSub="music"}

# 31-architecture-art-design -> 10-fiction-and-literature
$mappings += @{OldCat="31-architecture-art-design"; OldSub="architecture"; NewTop="10-fiction-and-literature"; NewSub="art-and-design"}
$mappings += @{OldCat="31-architecture-art-design"; OldSub="design"; NewTop="10-fiction-and-literature"; NewSub="art-and-design"}
$mappings += @{OldCat="31-architecture-art-design"; OldSub="fine-arts"; NewTop="10-fiction-and-literature"; NewSub="art-and-design"}
$mappings += @{OldCat="31-architecture-art-design"; OldSub="photography"; NewTop="10-fiction-and-literature"; NewSub="art-and-design"}

# 32-literary-criticism-theory -> 10-fiction-and-literature
$mappings += @{OldCat="32-literary-criticism-theory"; OldSub="author-studies-and-genre-criticism"; NewTop="10-fiction-and-literature"; NewSub="literary-criticism"}
$mappings += @{OldCat="32-literary-criticism-theory"; OldSub="classical-literary-theory"; NewTop="10-fiction-and-literature"; NewSub="literary-criticism"}
$mappings += @{OldCat="32-literary-criticism-theory"; OldSub="modern-literary-theory"; NewTop="10-fiction-and-literature"; NewSub="literary-criticism"}

# ============================================================
# STEP 2: Execute migrations
# ============================================================

$migrated = 0
$skipped = 0
$errors = 0

foreach ($map in $mappings) {
    $oldPath = Join-Path $knowledgeRoot $map.OldCat $map.OldSub
    $newTopPath = Join-Path $knowledgeRoot $map.NewTop
    $newSubPath = Join-Path $newTopPath $map.NewSub

    if (-not (Test-Path $oldPath)) {
        $skipped++
        continue
    }

    # Create target directory if needed
    if (-not (Test-Path $newSubPath)) {
        New-Item -ItemType Directory -Path $newSubPath -Force | Out-Null
    }

    # Get all book directories in old path
    $bookDirs = Get-ChildItem -Path $oldPath -Directory -ErrorAction SilentlyContinue

    foreach ($bookDir in $bookDirs) {
        $destPath = Join-Path $newSubPath $bookDir.Name

        if (Test-Path $destPath) {
            # Merge: copy files that don't exist in destination
            $files = Get-ChildItem -Path $bookDir.FullName -File -ErrorAction SilentlyContinue
            foreach ($file in $files) {
                $destFile = Join-Path $destPath $file.Name
                if (-not (Test-File $destFile)) {
                    Copy-Item -Path $file.FullName -Destination $destFile -Force
                }
            }
        } else {
            # Move the entire book directory
            try {
                Move-Item -Path $bookDir.FullName -Destination $newSubPath -Force
                $migrated++
            } catch {
                # If move fails, try copy
                try {
                    Copy-Item -Path $bookDir.FullName -Destination $destPath -Recurse -Force
                    $migrated++
                } catch {
                    Write-Error "Failed to migrate: $($bookDir.FullName) -> $destPath : $_"
                    $errors++
                }
            }
        }
    }
}

Write-Host "Migration complete: $migrated books moved, $skipped empty dirs skipped, $errors errors"
