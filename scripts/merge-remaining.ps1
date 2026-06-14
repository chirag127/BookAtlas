$ErrorActionPreference = "SilentlyContinue"
$knowledgeRoot = "C:\AM\GitHub\BookAtlas\knowledge"
$moved = 0

# For each remaining old category, move books that haven't been moved yet
# The key issue: books in old categories with content need to be moved even if
# a folder with same name exists in the new location (merge content)

function Merge-Book($fromPath, $toPath) {
    if (!(Test-Path $fromPath)) { return }
    if (!(Test-Path $toPath)) {
        Move-Item $fromPath $toPath
        $script:moved++
        return
    }
    # If destination exists, copy missing files
    $fromFiles = Get-ChildItem -Path $fromPath -File
    foreach ($f in $fromFiles) {
        $destFile = Join-Path $toPath $f.Name
        if (!(Test-Path $destFile)) {
            Copy-Item $f.FullName $destFile -Force
        }
    }
    # Remove the old directory after merging
    Remove-Item $fromPath -Recurse -Force
}

# Remaining old categories with books
$remainingMappings = @(
    @{Old="01-health-fitness-longevity/exercise-science-and-physical-training"; New="02-body-health-and-life-sciences/exercise-and-fitness"},
    @{Old="01-health-fitness-longevity/longevity-research-and-aging"; New="02-body-health-and-life-sciences/longevity-and-aging"},
    @{Old="01-health-fitness-longevity/mental-health-and-neurocognitive-performance"; New="02-body-health-and-life-sciences/neuroscience-and-brain-health"},
    @{Old="01-health-fitness-longevity/nutrition-for-performance-and-health"; New="02-body-health-and-life-sciences/nutrition-and-diet"},
    @{Old="01-health-fitness-longevity/peak-physical-performance"; New="02-body-health-and-life-sciences/exercise-and-fitness"},
    @{Old="01-health-fitness-longevity/sleep-science-and-optimization"; New="02-body-health-and-life-sciences/sleep-science"},
    @{Old="02-medicine-health-sciences/anatomy-and-physiology"; New="02-body-health-and-life-sciences/medicine-and-clinical-science"},
    @{Old="02-medicine-health-sciences/medical-history-and-bioethics"; New="02-body-health-and-life-sciences/medicine-and-clinical-science"},
    @{Old="02-medicine-health-sciences/nutrition-science"; New="02-body-health-and-life-sciences/nutrition-and-diet"},
    @{Old="02-medicine-health-sciences/pathophysiology-and-clinical-medicine"; New="02-body-health-and-life-sciences/medicine-and-clinical-science"},
    @{Old="02-medicine-health-sciences/pharmacology"; New="02-body-health-and-life-sciences/medicine-and-clinical-science"},
    @{Old="02-medicine-health-sciences/psychiatry-and-mental-health"; New="02-body-health-and-life-sciences/psychiatry-and-mental-health"},
    @{Old="02-medicine-health-sciences/public-health-and-epidemiology"; New="02-body-health-and-life-sciences/medicine-and-clinical-science"},
    @{Old="04-self-help-personal-development/confidence-self-esteem-and-assertiveness"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="04-self-help-personal-development/goal-setting-and-achievement"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="04-self-help-personal-development/mens-and-womens-development"; New="01-mind-behavior-and-human-performance/personality-psychology"},
    @{Old="04-self-help-personal-development/mental-health-and-emotional-wellbeing"; New="01-mind-behavior-and-human-performance/positive-psychology"},
    @{Old="04-self-help-personal-development/mindset-and-belief-systems"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="04-self-help-personal-development/relationships-and-social-skills"; New="01-mind-behavior-and-human-performance/social-psychology"},
    @{Old="04-self-help-personal-development/spirituality-and-life-meaning"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="04-self-help-personal-development/financial-self-help"; New="03-money-markets-and-wealth/personal-finance"},
    @{Old="05-productivity-performance/attention-management-and-deep-work"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="05-productivity-performance/creativity-and-innovation"; New="01-mind-behavior-and-human-performance/creativity-and-innovation"},
    @{Old="05-productivity-performance/energy-management"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="05-productivity-performance/habit-formation-and-behavioral-systems"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="05-productivity-performance/knowledge-management"; New="01-mind-behavior-and-human-performance/learning-and-skill-acquisition"},
    @{Old="05-productivity-performance/learning-and-skill-acquisition"; New="01-mind-behavior-and-human-performance/learning-and-skill-acquisition"},
    @{Old="05-productivity-performance/time-management-and-prioritization"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="06-productivity/personal-effectiveness"; New="01-mind-behavior-and-human-performance/habits-productivity-and-focus"},
    @{Old="07-decision-making-systems-thinking/cognitive-biases-and-debiasing"; New="01-mind-behavior-and-human-performance/cognitive-biases-and-rationality"},
    @{Old="07-decision-making-systems-thinking/decision-making"; New="01-mind-behavior-and-human-performance/mental-models-and-decision-making"},
    @{Old="07-decision-making-systems-thinking/forecasting-and-prediction"; New="01-mind-behavior-and-human-performance/probability-forecasting-and-risk"},
    @{Old="07-decision-making-systems-thinking/game-theory-applied"; New="01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"},
    @{Old="07-decision-making-systems-thinking/mental-models-and-multidisciplinary-thinking"; New="01-mind-behavior-and-human-performance/mental-models-and-decision-making"},
    @{Old="07-decision-making-systems-thinking/probabilistic-and-bayesian-reasoning"; New="01-mind-behavior-and-human-performance/probability-forecasting-and-risk"},
    @{Old="07-decision-making-systems-thinking/risk-and-uncertainty"; New="01-mind-behavior-and-human-performance/probability-forecasting-and-risk"},
    @{Old="07-decision-making-systems-thinking/systems-thinking-and-cybernetics"; New="01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"},
    @{Old="07-decision-making-systems-thinking/thinking-in-bets-annie-duke"; New="01-mind-behavior-and-human-performance/mental-models-and-decision-making"},
    @{Old="08-psychology/behavioral-psychology"; New="01-mind-behavior-and-human-performance/behavioral-psychology"},
    @{Old="08-psychology/behavioral-psychology-and-learning-theory"; New="01-mind-behavior-and-human-performance/behavioral-psychology"},
    @{Old="08-psychology/clinical-psychology-and-psychotherapy"; New="01-mind-behavior-and-human-performance/clinical-psychology"},
    @{Old="08-psychology/cognitive-biases"; New="01-mind-behavior-and-human-performance/cognitive-biases-and-rationality"},
    @{Old="08-psychology/cognitive-psychology"; New="01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"},
    @{Old="08-psychology/developmental-psychology"; New="01-mind-behavior-and-human-performance/behavioral-psychology"},
    @{Old="08-psychology/evolutionary-psychology"; New="01-mind-behavior-and-human-performance/evolutionary-psychology"},
    @{Old="08-psychology/existential-and-humanistic-psychology"; New="01-mind-behavior-and-human-performance/clinical-psychology"},
    @{Old="08-psychology/industrial-organizational-psychology"; New="01-mind-behavior-and-human-performance/industrial-organizational-psychology"},
    @{Old="08-psychology/netropsychology-and-biological-psychology"; New="01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"},
    @{Old="08-psychology/neuropsychology"; New="01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"},
    @{Old="08-psychology/neuroscience-and-cognition"; New="01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"},
    @{Old="08-psychology/personality-psychology"; New="01-mind-behavior-and-human-performance/personality-psychology"},
    @{Old="08-psychology/positive-psychology"; New="01-mind-behavior-and-human-performance/positive-psychology"},
    @{Old="08-psychology/social-psychology"; New="01-mind-behavior-and-human-performance/social-psychology"},
    @{Old="09-philosophy/aesthetics"; New="06-philosophy-religion-and-indian-thought/philosophy"},
    @{Old="09-philosophy/eastern-philosophy"; New="06-philosophy-religion-and-indian-thought/eastern-philosophy"},
    @{Old="09-philosophy/epistemology"; New="06-philosophy-religion-and-indian-thought/philosophy"},
    @{Old="09-philosophy/ethics-and-moral-philosophy"; New="06-philosophy-religion-and-indian-thought/ethics-and-moral-philosophy"},
    @{Old="09-philosophy/existentialism"; New="06-philosophy-religion-and-indian-thought/western-philosophy"},
    @{Old="09-philosophy/indian-philosophy"; New="06-philosophy-religion-and-indian-thought/indian-philosophy"},
    @{Old="09-philosophy/logic-and-critical-thinking"; New="06-philosophy-religion-and-indian-thought/philosophy"},
    @{Old="09-philosophy/metaphysics-and-ontology"; New="06-philosophy-religion-and-indian-thought/philosophy"},
    @{Old="09-philosophy/non-western-and-comparative-philosophy"; New="06-philosophy-religion-and-indian-thought/comparative-philosophy"},
    @{Old="09-philosophy/philosophy-of-mind-and-language"; New="06-philosophy-religion-and-indian-thought/philosophy"},
    @{Old="09-philosophy/political-philosophy"; New="06-philosophy-religion-and-indian-thought/philosophy"},
    @{Old="09-philosophy/western-philosophy-by-era"; New="06-philosophy-religion-and-indian-thought/western-philosophy"},
    @{Old="10-religion-spirituality/abrahamic-religions"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="10-religion-spirituality/atheism-agnosticism-and-secular-humanism"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="10-religion-spirituality/comparative-religion"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="10-religion-spirituality/dharmic-religions"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="10-religion-spirituality/east-asian-religions"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="10-religion-spirituality/mind-body-spirit-and-spirituality"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="10-religion-spirituality/mysticism-and-esoteric-traditions"; New="06-philosophy-religion-and-indian-thought/religion-and-spirituality"},
    @{Old="11-finance-investing/alternative-investments"; New="03-money-markets-and-wealth/investment-theory-and-principles"},
    @{Old="11-finance-investing/behavioral-finance"; New="03-money-markets-and-wealth/behavioral-finance"},
    @{Old="11-finance-investing/derivatives-and-structured-products"; New="03-money-markets-and-wealth/finance"},
    @{Old="11-finance-investing/equity-investing"; New="03-money-markets-and-wealth/investment-theory-and-principles"},
    @{Old="11-finance-investing/financial-history"; New="03-money-markets-and-wealth/finance"},
    @{Old="11-finance-investing/fixed-income-and-bond-markets"; New="03-money-markets-and-wealth/finance"},
    @{Old="11-finance-investing/indian-finance"; New="03-money-markets-and-wealth/indian-finance"},
    @{Old="11-finance-investing/investment-theory-and-principles"; New="03-money-markets-and-wealth/investment-theory-and-principles"},
    @{Old="11-finance-investing/macro-investing-and-global-markets"; New="03-money-markets-and-wealth/macroeconomics"},
    @{Old="11-finance-investing/personal-finance-and-wealth-building"; New="03-money-markets-and-wealth/personal-finance"},
    @{Old="11-finance-investing/quantitative-finance"; New="03-money-markets-and-wealth/finance"},
    @{Old="11-finance-investing/real-estate-investing"; New="03-money-markets-and-wealth/investment-theory-and-principles"},
    @{Old="11-finance-investing/risk-management"; New="03-money-markets-and-wealth/finance"},
    @{Old="11-finance-investing/venture-capital-and-private-equity"; New="03-money-markets-and-wealth/finance"},
    @{Old="12-business-management-entrepreneurship/business-strategy"; New="05-business-strategy-and-organizations/business-strategy"},
    @{Old="12-business-management-entrepreneurship/consulting-and-frameworks"; New="05-business-strategy-and-organizations/consulting-and-frameworks"},
    @{Old="12-business-management-entrepreneurship/corporate-finance-and-accounting"; New="05-business-strategy-and-organizations/corporate-finance-and-accounting"},
    @{Old="12-business-management-entrepreneurship/entrepreneurship-and-startups"; New="05-business-strategy-and-organizations/entrepreneurship-and-startups"},
    @{Old="12-business-management-entrepreneurship/leadership-and-executive-development"; New="05-business-strategy-and-organizations/leadership"},
    @{Old="12-business-management-entrepreneurship/management-and-organizational-behavior"; New="05-business-strategy-and-organizations/management-and-organizational-behavior"},
    @{Old="12-business-management-entrepreneurship/marketing-and-brand-strategy"; New="05-business-strategy-and-organizations/marketing-and-brand-strategy"},
    @{Old="12-business-management-entrepreneurship/operations-and-supply-chain"; New="05-business-strategy-and-organizations/operations-and-supply-chain"},
    @{Old="12-business-management-entrepreneurship/product-management"; New="05-business-strategy-and-organizations/product-management"},
    @{Old="12-business-management-entrepreneurship/sales-and-business-development"; New="05-business-strategy-and-organizations/sales-and-business-development"},
    @{Old="12-business-management-entrepreneurship/small-business-and-micro-enterprises"; New="05-business-strategy-and-organizations/entrepreneurship-and-startups"},
    @{Old="13-economics-economic-theory/behavioral-economics"; New="03-money-markets-and-wealth/behavioral-economics"},
    @{Old="13-economics-economic-theory/development-economics"; New="03-money-markets-and-wealth/development-economics"},
    @{Old="13-economics-economic-theory/ecological-and-environmental-economics"; New="03-money-markets-and-wealth/political-economy"},
    @{Old="13-economics-economic-theory/history-of-economic-thought"; New="03-money-markets-and-wealth/history-of-economic-thought"},
    @{Old="13-economics-economic-theory/international-trade-and-globalization"; New="03-money-markets-and-wealth/macroeconomics"},
    @{Old="13-economics-economic-theory/macroeconomics"; New="03-money-markets-and-wealth/macroeconomics"},
    @{Old="13-economics-economic-theory/microeconomics"; New="03-money-markets-and-wealth/microeconomics"},
    @{Old="13-economics-economic-theory/political-economy"; New="03-money-markets-and-wealth/political-economy"},
    @{Old="14-communication-language-linguistics/communication-theory"; New="09-communication-writing-and-creativity/communication-theory"},
    @{Old="14-communication-language-linguistics/language-acquisition-and-learning"; New="09-communication-writing-and-creativity/language-learning"},
    @{Old="14-communication-language-linguistics/linguistics"; New="09-communication-writing-and-creativity/linguistics"},
    @{Old="14-communication-language-linguistics/persuasion-and-rhetoric"; New="09-communication-writing-and-creativity/persuasion-and-rhetoric"},
    @{Old="14-communication-language-linguistics/public-speaking-and-presentation"; New="09-communication-writing-and-creativity/public-speaking-and-presentation"},
    @{Old="14-communication-language-linguistics/specific-languages"; New="09-communication-writing-and-creativity/language-learning"},
    @{Old="14-communication-language-linguistics/storytelling"; New="09-communication-writing-and-creativity/storytelling"},
    @{Old="14-communication-language-linguistics/writing-craft-and-nonfiction-writing"; New="09-communication-writing-and-creativity/writing-craft-and-nonfiction"},
    @{Old="15-education-pedagogy/curriculum-design-and-instructional-design"; New="09-communication-writing-and-creativity/curriculum-design-and-instructional-design"},
    @{Old="15-education-pedagogy/educational-technology"; New="09-communication-writing-and-creativity/learning-science-and-cognitive-science-of-learning"},
    @{Old="15-education-pedagogy/higher-education"; New="09-communication-writing-and-creativity/philosophy-and-history-of-education"},
    @{Old="15-education-pedagogy/learning-science-and-cognitive-science-of-learning"; New="09-communication-writing-and-creativity/learning-science-and-cognitive-science-of-learning"},
    @{Old="15-education-pedagogy/philosophy-and-history-of-education"; New="09-communication-writing-and-creativity/philosophy-and-history-of-education"},
    @{Old="15-education-pedagogy/special-education-and-inclusive-pedagogy"; New="09-communication-writing-and-creativity/special-education-and-inclusive-pedagogy"},
    @{Old="16-social-sciences-sociology/anthropology"; New="08-society-history-and-power/sociology-and-anthropology"},
    @{Old="16-social-sciences-sociology/cultural-studies"; New="08-society-history-and-power/cultural-studies"},
    @{Old="16-social-sciences-sociology/demographics-and-population-studies"; New="08-society-history-and-power/demographics-and-population-studies"},
    @{Old="16-social-sciences-sociology/gender-race-and-ethnicity"; New="08-society-history-and-power/gender-race-and-ethnicity"},
    @{Old="16-social-sciences-sociology/global-society-and-world-systems"; New="08-society-history-and-power/global-society-and-world-systems"},
    @{Old="16-social-sciences-sociology/social-problems-and-social-policy"; New="08-society-history-and-power/social-problems-and-social-policy"},
    @{Old="16-social-sciences-sociology/sociology"; New="08-society-history-and-power/sociology-and-anthropology"},
    @{Old="17-law-legal-systems/common-law-traditions"; New="08-society-history-and-power/public-policy-and-law"},
    @{Old="17-law-legal-systems/corporate-and-commercial-law"; New="08-society-history-and-power/public-policy-and-law"},
    @{Old="17-law-legal-systems/foundations-of-law"; New="08-society-history-and-power/public-policy-and-law"},
    @{Old="17-law-legal-systems/indian-law"; New="08-society-history-and-power/public-policy-and-law"},
    @{Old="17-law-legal-systems/international-law"; New="08-society-history-and-power/public-policy-and-law"},
    @{Old="17-law-legal-systems/legal-practice-and-career"; New="08-society-history-and-power/public-policy-and-law"},
    @{Old="18-history/big-history-and-civilization"; New="08-society-history-and-power/world-history-and-civilizations"},
    @{Old="18-history/contemporary-history"; New="08-society-history-and-power/history"},
    @{Old="18-history/economic-and-financial-history"; New="08-society-history-and-power/history"},
    @{Old="18-history/history-of-ideas-and-intellectual-history"; New="08-society-history-and-power/history"},
    @{Old="18-history/history-of-technology"; New="08-society-history-and-power/history"},
    @{Old="18-history/military-history"; New="08-society-history-and-power/history"},
    @{Old="18-history/modern-world-history"; New="08-society-history-and-power/world-history-and-civilizations"},
    @{Old="18-history/regional-history"; New="08-society-history-and-power/history"},
    @{Old="18-history/world-history-and-civilizations"; New="08-society-history-and-power/world-history-and-civilizations"},
    @{Old="19-political-science-geopolitics/comparative-politics"; New="08-society-history-and-power/political-science-and-geopolitics"},
    @{Old="19-political-science-geopolitics/democracy-media-and-civil-society"; New="08-society-history-and-power/political-theory-and-philosophy"},
    @{Old="19-political-science-geopolitics/geopolitics-and-great-power-competition"; New="08-society-history-and-power/geopolitics-and-great-power-competition"},
    @{Old="19-political-science-geopolitics/international-relations"; New="08-society-history-and-power/international-relations"},
    @{Old="19-political-science-geopolitics/political-economy"; New="08-society-history-and-power/political-theory-and-philosophy"},
    @{Old="19-political-science-geopolitics/political-theory-and-philosophy"; New="08-society-history-and-power/political-theory-and-philosophy"},
    @{Old="19-political-science-geopolitics/public-policy-and-governance"; New="08-society-history-and-power/public-policy-and-law"},
    @{Old="20-pure-sciences/astronomy-astrophysics-cosmology"; New="07-math-logic-and-science/astronomy-astrophysics-cosmology"},
    @{Old="20-pure-sciences/biology-and-evolution"; New="07-math-logic-and-science/biology-and-evolution"},
    @{Old="20-pure-sciences/chemistry"; New="07-math-logic-and-science/chemistry"},
    @{Old="20-pure-sciences/earth-sciences-and-climate"; New="07-math-logic-and-science/earth-sciences-and-nature"},
    @{Old="20-pure-sciences/evolutionary-biology"; New="07-math-logic-and-science/biology-and-evolution"},
    @{Old="20-pure-sciences/neuroscience"; New="07-math-logic-and-science/neuroscience"},
    @{Old="20-pure-sciences/philosophy-history-of-science"; New="07-math-logic-and-science/history-and-philosophy-of-science"},
    @{Old="20-pure-sciences/physics"; New="07-math-logic-and-science/physics"},
    @{Old="20-pure-sciences/popular-science-and-science-communication"; New="07-math-logic-and-science/popular-science"},
    @{Old="21-nature-environment-ecology/botany-zoology-and-biodiversity"; New="07-math-logic-and-science/biology-and-evolution"},
    @{Old="21-nature-environment-ecology/climate-and-environmental-crisis"; New="07-math-logic-and-science/earth-sciences-and-nature"},
    @{Old="21-nature-environment-ecology/ecology-and-environmental-science"; New="07-math-logic-and-science/earth-sciences-and-nature"},
    @{Old="21-nature-environment-ecology/natural-history-writing"; New="07-math-logic-and-science/popular-science"},
    @{Old="22-mathematics-statistics/algebra-and-number-theory"; New="07-math-logic-and-science/mathematics"},
    @{Old="22-mathematics-statistics/analysis-and-calculus"; New="07-math-logic-and-science/mathematics"},
    @{Old="22-mathematics-statistics/applied-and-computational-mathematics"; New="07-math-logic-and-science/mathematics"},
    @{Old="22-mathematics-statistics/foundations-of-mathematics-and-logic"; New="07-math-logic-and-science/mathematics"},
    @{Old="22-mathematics-statistics/geometry-and-topology"; New="07-math-logic-and-science/mathematics"},
    @{Old="22-mathematics-statistics/mathematics-for-a-general-audience"; New="07-math-logic-and-science/popular-science"},
    @{Old="22-mathematics-statistics/probability-theory"; New="07-math-logic-and-science/statistics-and-probability"},
    @{Old="22-mathematics-statistics/real-and-complex-analysis"; New="07-math-logic-and-science/mathematics"},
    @{Old="22-mathematics-statistics/statistics-and-data-analysis"; New="07-math-logic-and-science/statistics-and-probability"},
    @{Old="23-computer-science/algorithms-and-data-structures"; New="04-computers-ai-and-software/data-algorithms-and-databases"},
    @{Old="23-computer-science/compilers-and-language-runtimes"; New="04-computers-ai-and-software/computer-science-theory"},
    @{Old="23-computer-science/computer-architecture-and-organization"; New="04-computers-ai-and-software/computer-science"},
    @{Old="23-computer-science/computer-networking"; New="04-computers-ai-and-software/networking-and-distributed-systems"},
    @{Old="23-computer-science/databases-and-storage-theory"; New="04-computers-ai-and-software/data-algorithms-and-databases"},
    @{Old="23-computer-science/information-theory-and-coding"; New="04-computers-ai-and-software/computer-science-theory"},
    @{Old="23-computer-science/operating-systems-internals"; New="04-computers-ai-and-software/computer-science"},
    @{Old="23-computer-science/programming-languages-and-paradigms"; New="04-computers-ai-and-software/computer-science"},
    @{Old="23-computer-science/security-and-cryptography"; New="04-computers-ai-and-software/cybersecurity"},
    @{Old="23-computer-science/software-engineering-practice"; New="04-computers-ai-and-software/software-engineering"},
    @{Old="23-computer-science/theoretical-computer-science"; New="04-computers-ai-and-software/theory-of-computation"},
    @{Old="23-computer-science/theory-of-computation"; New="04-computers-ai-and-software/theory-of-computation"},
    @{Old="24-software-engineering/api-design-and-integration"; New="04-computers-ai-and-software/software-engineering"},
    @{Old="24-software-engineering/code-quality-and-craft"; New="04-computers-ai-and-software/code-quality-and-craft"},
    @{Old="24-software-engineering/devops-sre-and-platform-engineering"; New="04-computers-ai-and-software/devops-and-platform-engineering"},
    @{Old="24-software-engineering/distributed-systems-implementation"; New="04-computers-ai-and-software/system-design-and-architecture"},
    @{Old="24-software-engineering/engineering-culture-and-team-dynamics"; New="04-computers-ai-and-software/software-engineering"},
    @{Old="24-software-engineering/software-architecture"; New="04-computers-ai-and-software/software-design-principles"},
    @{Old="24-software-engineering/software-design-and-architecture"; New="04-computers-ai-and-software/software-design-principles"},
    @{Old="24-software-engineering/software-design-principles"; New="04-computers-ai-and-software/software-design-principles"},
    @{Old="24-software-engineering/system-design-and-scalability"; New="04-computers-ai-and-software/system-design-and-architecture"},
    @{Old="25-artificial-intelligence-machine-learning/ai-history-philosophy-and-ethics"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="25-artificial-intelligence-machine-learning/ai-safety-and-alignment"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="25-artificial-intelligence-machine-learning/computer-vision"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="25-artificial-intelligence-machine-learning/deep-learning-and-neural-architectures"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="25-artificial-intelligence-machine-learning/machine-learning-foundations"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="25-artificial-intelligence-machine-learning/mlops-and-production-ai"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="25-artificial-intelligence-machine-learning/natural-language-processing"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="25-artificial-intelligence-machine-learning/reinforcement-learning"; New="04-computers-ai-and-software/artificial-intelligence"},
    @{Old="26-technology-engineering/biomedical-engineering"; New="04-computers-ai-and-software/engineering-and-technology"},
    @{Old="26-technology-engineering/civil-and-infrastructure-engineering"; New="04-computers-ai-and-software/engineering-and-technology"},
    @{Old="26-technology-engineering/electrical-and-electronics-engineering"; New="04-computers-ai-and-software/engineering-and-technology"},
    @{Old="26-technology-engineering/energy-and-sustainability-engineering"; New="04-computers-ai-and-software/engineering-and-technology"},
    @{Old="26-technology-engineering/history-and-philosophy-of-technology"; New="04-computers-ai-and-software/history-and-philosophy-of-technology"},
    @{Old="26-technology-engineering/materials-science-and-nanotechnology"; New="04-computers-ai-and-software/engineering-and-technology"},
    @{Old="26-technology-engineering/mechanical-engineering"; New="04-computers-ai-and-software/engineering-and-technology"},
    @{Old="26-technology-engineering/robotics-and-automation"; New="04-computers-ai-and-software/engineering-and-technology"},
    @{Old="27-biography-memoir/artists-writers-and-musicians"; New="10-fiction-and-literature/artists-writers-and-musicians"},
    @{Old="27-biography-memoir/autobiographies-and-personal-memoirs"; New="10-fiction-and-literature/autobiographies-and-personal-memoirs"},
    @{Old="27-biography-memoir/collected-and-group-biographies"; New="10-fiction-and-literature/autobiographies-and-personal-memoirs"},
    @{Old="27-biography-memoir/entrepreneurs-and-business-builders"; New="10-fiction-and-literature/entrepreneurs-and-business-builders"},
    @{Old="27-biography-memoir/investors-and-financiers"; New="10-fiction-and-literature/entrepreneurs-and-business-builders"},
    @{Old="27-biography-memoir/philosophers-and-intellectuals"; New="10-fiction-and-literature/political-and-military-leaders"},
    @{Old="27-biography-memoir/political-and-military-leaders"; New="10-fiction-and-literature/political-and-military-leaders"},
    @{Old="27-biography-memoir/scientists-and-mathematicians"; New="10-fiction-and-literature/scientists-and-mathematicians"},
    @{Old="27-biography-memoir/social-activists-and-reformers"; New="10-fiction-and-literature/social-activists-and-reformers"},
    @{Old="27-biography-memoir/sports-figures-and-athletes"; New="10-fiction-and-literature/autobiographies-and-personal-memoirs"},
    @{Old="27-biography-memoir/technology-leaders-and-founders"; New="10-fiction-and-literature/technology-leaders-and-founders"},
    @{Old="28-fiction/fantasy"; New="10-fiction-and-literature/fantasy"},
    @{Old="28-fiction/graphic-novels-and-sequential-art"; New="10-fiction-and-literature/genre-fiction"},
    @{Old="28-fiction/historical-fiction"; New="10-fiction-and-literature/genre-fiction"},
    @{Old="28-fiction/horror-and-gothic-literature"; New="10-fiction-and-literature/horror-and-gothic-literature"},
    @{Old="28-fiction/literary-fiction"; New="10-fiction-and-literature/literary-fiction"},
    @{Old="28-fiction/mystery-and-crime-fiction"; New="10-fiction-and-literature/mystery-and-crime-fiction"},
    @{Old="28-fiction/mythology-legend-and-epic"; New="10-fiction-and-literature/genre-fiction"},
    @{Old="28-fiction/philosophical-and-existential-fiction"; New="10-fiction-and-literature/literary-fiction"},
    @{Old="28-fiction/romance"; New="10-fiction-and-literature/genre-fiction"},
    @{Old="28-fiction/science-fiction"; New="10-fiction-and-literature/science-fiction"},
    @{Old="28-fiction/short-stories-and-flash-fiction"; New="10-fiction-and-literature/genre-fiction"},
    @{Old="29-poetry-drama-performing-arts/drama-and-theatre"; New="10-fiction-and-literature/drama-and-theatre"},
    @{Old="29-poetry-drama-performing-arts/performing-arts"; New="10-fiction-and-literature/drama-and-theatre"},
    @{Old="29-poetry-drama-performing-arts/poetry"; New="10-fiction-and-literature/poetry-and-drama"},
    @{Old="30-music-film-media/film-studies"; New="10-fiction-and-literature/film-and-media-studies"},
    @{Old="30-music-film-media/media-studies"; New="10-fiction-and-literature/film-and-media-studies"},
    @{Old="30-music-film-media/music"; New="10-fiction-and-literature/music"},
    @{Old="31-architecture-art-design/architecture"; New="10-fiction-and-literature/art-and-design"},
    @{Old="31-architecture-art-design/design"; New="10-fiction-and-literature/art-and-design"},
    @{Old="31-architecture-art-design/fine-arts"; New="10-fiction-and-literature/art-and-design"},
    @{Old="31-architecture-art-design/photography"; New="10-fiction-and-literature/art-and-design"},
    @{Old="32-literary-criticism-theory/author-studies-and-genre-criticism"; New="10-fiction-and-literature/literary-criticism"},
    @{Old="32-literary-criticism-theory/classical-literary-theory"; New="10-fiction-and-literature/literary-criticism"},
    @{Old="32-literary-criticism-theory/modern-literary-theory"; New="10-fiction-and-literature/literary-criticism"}
)

foreach ($map in $remainingMappings) {
    $oldPath = Join-Path $knowledgeRoot $map.Old
    $newPath = Join-Path $knowledgeRoot $map.New
    if (!(Test-Path $oldPath)) { continue }
    if (!(Test-Path $newPath)) {
        New-Item -ItemType Directory -Path $newPath -Force | Out-Null
    }
    $bookDirs = Get-ChildItem -Path $oldPath -Directory
    foreach ($bookDir in $bookDirs) {
        $fromBook = $bookDir.FullName
        $toBook = Join-Path $newPath $bookDir.Name
        Merge-Book $fromBook $toBook
    }
}

Write-Host "Merged $moved additional books"

# Now remove all empty old category directories
$oldCats = @(
    "01-health-fitness-longevity","02-medicine-health-sciences","03-biology-life-sciences",
    "04-self-help-personal-development","05-productivity-performance","06-productivity",
    "07-decision-making-systems-thinking","08-psychology","09-philosophy","10-religion-spirituality",
    "11-finance-investing","12-business-management-entrepreneurship","13-economics-economic-theory",
    "14-communication-language-linguistics","15-education-pedagogy","16-social-sciences-sociology",
    "17-law-legal-systems","18-history","19-political-science-geopolitics","20-pure-sciences",
    "21-nature-environment-ecology","22-mathematics-statistics","23-computer-science",
    "24-software-engineering","25-artificial-intelligence-machine-learning","26-technology-engineering",
    "27-biography-memoir","28-fiction","29-poetry-drama-performing-arts","30-music-film-media",
    "31-architecture-art-design","32-literary-criticism-theory"
)
$removed = 0
foreach ($cat in $oldCats) {
    $catPath = Join-Path $knowledgeRoot $cat
    if (Test-Path $catPath) {
        $remaining = Get-ChildItem -Path $catPath -Recurse -File -ErrorAction SilentlyContinue
        if ($remaining.Count -eq 0) {
            Remove-Item -Path $catPath -Recurse -Force
            $removed++
        } else {
            Write-Host "Still has files: $cat ($($remaining.Count))"
        }
    }
}
Write-Host "Removed $removed empty old categories"
