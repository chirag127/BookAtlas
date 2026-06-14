$ErrorActionPreference = "SilentlyContinue"
$count = 0

function Move-Books($from, $to) {
    if (!(Test-Path $from)) { return }
    if (!(Test-Path $to)) { New-Item -ItemType Directory -Path $to -Force | Out-Null }
    Get-ChildItem -Path $from -Directory | ForEach-Object {
        $dest = Join-Path $to $_.Name
        if (!(Test-Path $dest)) {
            Move-Item $_.FullName $to
            $script:count++
        }
    }
}

# 01-health-fitness-longevity -> 02
Move-Books "01-health-fitness-longevity/exercise-science-and-physical-training" "02-body-health-and-life-sciences/exercise-and-fitness"
Move-Books "01-health-fitness-longevity/longevity-research-and-aging" "02-body-health-and-life-sciences/longevity-and-aging"
Move-Books "01-health-fitness-longevity/mental-health-and-neurocognitive-performance" "02-body-health-and-life-sciences/neuroscience-and-brain-health"
Move-Books "01-health-fitness-longevity/nutrition-for-performance-and-health" "02-body-health-and-life-sciences/nutrition-and-diet"
Move-Books "01-health-fitness-longevity/peak-physical-performance" "02-body-health-and-life-sciences/exercise-and-fitness"
Move-Books "01-health-fitness-longevity/sleep-science-and-optimization" "02-body-health-and-life-sciences/sleep-science"

# 02-medicine-health-sciences -> 02
Move-Books "02-medicine-health-sciences/anatomy-and-physiology" "02-body-health-and-life-sciences/medicine-and-clinical-science"
Move-Books "02-medicine-health-sciences/medical-history-and-bioethics" "02-body-health-and-life-sciences/medicine-and-clinical-science"
Move-Books "02-medicine-health-sciences/nutrition-science" "02-body-health-and-life-sciences/nutrition-and-diet"
Move-Books "02-medicine-health-sciences/pathophysiology-and-clinical-medicine" "02-body-health-and-life-sciences/medicine-and-clinical-science"
Move-Books "02-medicine-health-sciences/pharmacology" "02-body-health-and-life-sciences/medicine-and-clinical-science"
Move-Books "02-medicine-health-sciences/psychiatry-and-mental-health" "02-body-health-and-life-sciences/psychiatry-and-mental-health"
Move-Books "02-medicine-health-sciences/public-health-and-epidemiology" "02-body-health-and-life-sciences/medicine-and-clinical-science"

# 03-biology-life-sciences -> 02
Move-Books "03-biology-life-sciences/cell-biology-and-biochemistry" "02-body-health-and-life-sciences/biology-and-life-sciences"

# 04-self-help -> 01/03/06
Move-Books "04-self-help-personal-development/confidence-self-esteem-and-assertiveness" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"
Move-Books "04-self-help-personal-development/goal-setting-and-achievement" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"
Move-Books "04-self-help-personal-development/mens-and-womens-development" "01-mind-behavior-and-human-performance/personality-psychology"
Move-Books "04-self-help-personal-development/mental-health-and-emotional-wellbeing" "01-mind-behavior-and-human-performance/positive-psychology"
Move-Books "04-self-help-personal-development/mindset-and-belief-systems" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"
Move-Books "04-self-help-personal-development/relationships-and-social-skills" "01-mind-behavior-and-human-performance/social-psychology"
Move-Books "04-self-help-personal-development/spirituality-and-life-meaning" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"
Move-Books "04-self-help-personal-development/financial-self-help" "03-money-markets-and-wealth/personal-finance"

# 05-productivity-performance -> 01
Move-Books "05-productivity-performance/attention-management-and-deep-work" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"
Move-Books "05-productivity-performance/creativity-and-innovation" "01-mind-behavior-and-human-performance/creativity-and-innovation"
Move-Books "05-productivity-performance/energy-management" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"
Move-Books "05-productivity-performance/habit-formation-and-behavioral-systems" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"
Move-Books "05-productivity-performance/knowledge-management" "01-mind-behavior-and-human-performance/learning-and-skill-acquisition"
Move-Books "05-productivity-performance/learning-and-skill-acquisition" "01-mind-behavior-and-human-performance/learning-and-skill-acquisition"
Move-Books "05-productivity-performance/time-management-and-prioritization" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"

# 06-productivity -> 01
Move-Books "06-productivity/personal-effectiveness" "01-mind-behavior-and-human-performance/habits-productivity-and-focus"

# 07-decision-making -> 01
Move-Books "07-decision-making-systems-thinking/cognitive-biases-and-debiasing" "01-mind-behavior-and-human-performance/cognitive-biases-and-rationality"
Move-Books "07-decision-making-systems-thinking/decision-making" "01-mind-behavior-and-human-performance/mental-models-and-decision-making"
Move-Books "07-decision-making-systems-thinking/forecasting-and-prediction" "01-mind-behavior-and-human-performance/probability-forecasting-and-risk"
Move-Books "07-decision-making-systems-thinking/game-theory-applied" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"
Move-Books "07-decision-making-systems-thinking/mental-models-and-multidisciplinary-thinking" "01-mind-behavior-and-human-performance/mental-models-and-decision-making"
Move-Books "07-decision-making-systems-thinking/probabilistic-and-bayesian-reasoning" "01-mind-behavior-and-human-performance/probability-forecasting-and-risk"
Move-Books "07-decision-making-systems-thinking/risk-and-uncertainty" "01-mind-behavior-and-human-performance/probability-forecasting-and-risk"
Move-Books "07-decision-making-systems-thinking/systems-thinking-and-cybernetics" "01-mind-behavior-and-human-performance/systems-thinking-and-game-theory"
Move-Books "07-decision-making-systems-thinking/thinking-in-bets-annie-duke" "01-mind-behavior-and-human-performance/mental-models-and-decision-making"

# 08-psychology -> 01
Move-Books "08-psychology/behavioral-psychology" "01-mind-behavior-and-human-performance/behavioral-psychology"
Move-Books "08-psychology/behavioral-psychology-and-learning-theory" "01-mind-behavior-and-human-performance/behavioral-psychology"
Move-Books "08-psychology/clinical-psychology-and-psychotherapy" "01-mind-behavior-and-human-performance/clinical-psychology"
Move-Books "08-psychology/cognitive-biases" "01-mind-behavior-and-human-performance/cognitive-biases-and-rationality"
Move-Books "08-psychology/cognitive-psychology" "01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"
Move-Books "08-psychology/developmental-psychology" "01-mind-behavior-and-human-performance/behavioral-psychology"
Move-Books "08-psychology/evolutionary-psychology" "01-mind-behavior-and-human-performance/evolutionary-psychology"
Move-Books "08-psychology/existential-and-humanistic-psychology" "01-mind-behavior-and-human-performance/clinical-psychology"
Move-Books "08-psychology/industrial-organizational-psychology" "01-mind-behavior-and-human-performance/industrial-organizational-psychology"
Move-Books "08-psychology/netropsychology-and-biological-psychology" "01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"
Move-Books "08-psychology/neuropsychology" "01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"
Move-Books "08-psychology/neuroscience-and-cognition" "01-mind-behavior-and-human-performance/cognitive-and-behavioral-psychology"
Move-Books "08-psychology/personality-psychology" "01-mind-behavior-and-human-performance/personality-psychology"
Move-Books "08-psychology/positive-psychology" "01-mind-behavior-and-human-performance/positive-psychology"
Move-Books "08-psychology/social-psychology" "01-mind-behavior-and-human-performance/social-psychology"

# 09-philosophy -> 06
Move-Books "09-philosophy/aesthetics" "06-philosophy-religion-and-indian-thought/philosophy"
Move-Books "09-philosophy/eastern-philosophy" "06-philosophy-religion-and-indian-thought/eastern-philosophy"
Move-Books "09-philosophy/epistemology" "06-philosophy-religion-and-indian-thought/philosophy"
Move-Books "09-philosophy/ethics-and-moral-philosophy" "06-philosophy-religion-and-indian-thought/ethics-and-moral-philosophy"
Move-Books "09-philosophy/existentialism" "06-philosophy-religion-and-indian-thought/western-philosophy"
Move-Books "09-philosophy/indian-philosophy" "06-philosophy-religion-and-indian-thought/indian-philosophy"
Move-Books "09-philosophy/logic-and-critical-thinking" "06-philosophy-religion-and-indian-thought/philosophy"
Move-Books "09-philosophy/metaphysics-and-ontology" "06-philosophy-religion-and-indian-thought/philosophy"
Move-Books "09-philosophy/non-western-and-comparative-philosophy" "06-philosophy-religion-and-indian-thought/comparative-philosophy"
Move-Books "09-philosophy/philosophy-of-mind-and-language" "06-philosophy-religion-and-indian-thought/philosophy"
Move-Books "09-philosophy/political-philosophy" "06-philosophy-religion-and-indian-thought/philosophy"
Move-Books "09-philosophy/western-philosophy-by-era" "06-philosophy-religion-and-indian-thought/western-philosophy"

# 10-religion-spirituality -> 06
Move-Books "10-religion-spirituality/abrahamic-religions" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"
Move-Books "10-religion-spirituality/atheism-agnosticism-and-secular-humanism" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"
Move-Books "10-religion-spirituality/comparative-religion" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"
Move-Books "10-religion-spirituality/dharmic-religions" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"
Move-Books "10-religion-spirituality/east-asian-religions" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"
Move-Books "10-religion-spirituality/mind-body-spirit-and-spirituality" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"
Move-Books "10-religion-spirituality/mysticism-and-esoteric-traditions" "06-philosophy-religion-and-indian-thought/religion-and-spirituality"

# 11-finance-investing -> 03
Move-Books "11-finance-investing/alternative-investments" "03-money-markets-and-wealth/investment-theory-and-principles"
Move-Books "11-finance-investing/behavioral-finance" "03-money-markets-and-wealth/behavioral-finance"
Move-Books "11-finance-investing/derivatives-and-structured-products" "03-money-markets-and-wealth/finance"
Move-Books "11-finance-investing/equity-investing" "03-money-markets-and-wealth/investment-theory-and-principles"
Move-Books "11-finance-investing/financial-history" "03-money-markets-and-wealth/finance"
Move-Books "11-finance-investing/fixed-income-and-bond-markets" "03-money-markets-and-wealth/finance"
Move-Books "11-finance-investing/indian-finance" "03-money-markets-and-wealth/indian-finance"
Move-Books "11-finance-investing/investment-theory-and-principles" "03-money-markets-and-wealth/investment-theory-and-principles"
Move-Books "11-finance-investing/macro-investing-and-global-markets" "03-money-markets-and-wealth/macroeconomics"
Move-Books "11-finance-investing/personal-finance-and-wealth-building" "03-money-markets-and-wealth/personal-finance"
Move-Books "11-finance-investing/quantitative-finance" "03-money-markets-and-wealth/finance"
Move-Books "11-finance-investing/real-estate-investing" "03-money-markets-and-wealth/investment-theory-and-principles"
Move-Books "11-finance-investing/risk-management" "03-money-markets-and-wealth/finance"
Move-Books "11-finance-investing/venture-capital-and-private-equity" "03-money-markets-and-wealth/finance"

# 12-business -> 05
Move-Books "12-business-management-entrepreneurship/business-strategy" "05-business-strategy-and-organizations/business-strategy"
Move-Books "12-business-management-entrepreneurship/consulting-and-frameworks" "05-business-strategy-and-organizations/consulting-and-frameworks"
Move-Books "12-business-management-entrepreneurship/corporate-finance-and-accounting" "05-business-strategy-and-organizations/corporate-finance-and-accounting"
Move-Books "12-business-management-entrepreneurship/entrepreneurship-and-startups" "05-business-strategy-and-organizations/entrepreneurship-and-startups"
Move-Books "12-business-management-entrepreneurship/leadership-and-executive-development" "05-business-strategy-and-organizations/leadership"
Move-Books "12-business-management-entrepreneurship/management-and-organizational-behavior" "05-business-strategy-and-organizations/management-and-organizational-behavior"
Move-Books "12-business-management-entrepreneurship/marketing-and-brand-strategy" "05-business-strategy-and-organizations/marketing-and-brand-strategy"
Move-Books "12-business-management-entrepreneurship/operations-and-supply-chain" "05-business-strategy-and-organizations/operations-and-supply-chain"
Move-Books "12-business-management-entrepreneurship/product-management" "05-business-strategy-and-organizations/product-management"
Move-Books "12-business-management-entrepreneurship/sales-and-business-development" "05-business-strategy-and-organizations/sales-and-business-development"
Move-Books "12-business-management-entrepreneurship/small-business-and-micro-enterprises" "05-business-strategy-and-organizations/entrepreneurship-and-startups"

# 13-economics -> 03
Move-Books "13-economics-economic-theory/behavioral-economics" "03-money-markets-and-wealth/behavioral-economics"
Move-Books "13-economics-economic-theory/development-economics" "03-money-markets-and-wealth/development-economics"
Move-Books "13-economics-economic-theory/ecological-and-environmental-economics" "03-money-markets-and-wealth/political-economy"
Move-Books "13-economics-economic-theory/history-of-economic-thought" "03-money-markets-and-wealth/history-of-economic-thought"
Move-Books "13-economics-economic-theory/international-trade-and-globalization" "03-money-markets-and-wealth/macroeconomics"
Move-Books "13-economics-economic-theory/macroeconomics" "03-money-markets-and-wealth/macroeconomics"
Move-Books "13-economics-economic-theory/microeconomics" "03-money-markets-and-wealth/microeconomics"
Move-Books "13-economics-economic-theory/political-economy" "03-money-markets-and-wealth/political-economy"

# 14-communication -> 09
Move-Books "14-communication-language-linguistics/communication-theory" "09-communication-writing-and-creativity/communication-theory"
Move-Books "14-communication-language-linguistics/language-acquisition-and-learning" "09-communication-writing-and-creativity/language-learning"
Move-Books "14-communication-language-linguistics/linguistics" "09-communication-writing-and-creativity/linguistics"
Move-Books "14-communication-language-linguistics/persuasion-and-rhetoric" "09-communication-writing-and-creativity/persuasion-and-rhetoric"
Move-Books "14-communication-language-linguistics/public-speaking-and-presentation" "09-communication-writing-and-creativity/public-speaking-and-presentation"
Move-Books "14-communication-language-linguistics/specific-languages" "09-communication-writing-and-creativity/language-learning"
Move-Books "14-communication-language-linguistics/storytelling" "09-communication-writing-and-creativity/storytelling"
Move-Books "14-communication-language-linguistics/writing-craft-and-nonfiction-writing" "09-communication-writing-and-creativity/writing-craft-and-nonfiction"

# 15-education -> 09
Move-Books "15-education-pedagogy/curriculum-design-and-instructional-design" "09-communication-writing-and-creativity/curriculum-design-and-instructional-design"
Move-Books "15-education-pedagogy/educational-technology" "09-communication-writing-and-creativity/learning-science-and-cognitive-science-of-learning"
Move-Books "15-education-pedagogy/higher-education" "09-communication-writing-and-creativity/philosophy-and-history-of-education"
Move-Books "15-education-pedagogy/learning-science-and-cognitive-science-of-learning" "09-communication-writing-and-creativity/learning-science-and-cognitive-science-of-learning"
Move-Books "15-education-pedagogy/philosophy-and-history-of-education" "09-communication-writing-and-creativity/philosophy-and-history-of-education"
Move-Books "15-education-pedagogy/special-education-and-inclusive-pedagogy" "09-communication-writing-and-creativity/special-education-and-inclusive-pedagogy"

# 16-social-sciences -> 08
Move-Books "16-social-sciences-sociology/anthropology" "08-society-history-and-power/sociology-and-anthropology"
Move-Books "16-social-sciences-sociology/cultural-studies" "08-society-history-and-power/cultural-studies"
Move-Books "16-social-sciences-sociology/demographics-and-population-studies" "08-society-history-and-power/demographics-and-population-studies"
Move-Books "16-social-sciences-sociology/gender-race-and-ethnicity" "08-society-history-and-power/gender-race-and-ethnicity"
Move-Books "16-social-sciences-sociology/global-society-and-world-systems" "08-society-history-and-power/global-society-and-world-systems"
Move-Books "16-social-sciences-sociology/social-problems-and-social-policy" "08-society-history-and-power/social-problems-and-social-policy"
Move-Books "16-social-sciences-sociology/sociology" "08-society-history-and-power/sociology-and-anthropology"

# 17-law -> 08
Move-Books "17-law-legal-systems/common-law-traditions" "08-society-history-and-power/public-policy-and-law"
Move-Books "17-law-legal-systems/corporate-and-commercial-law" "08-society-history-and-power/public-policy-and-law"
Move-Books "17-law-legal-systems/foundations-of-law" "08-society-history-and-power/public-policy-and-law"
Move-Books "17-law-legal-systems/indian-law" "08-society-history-and-power/public-policy-and-law"
Move-Books "17-law-legal-systems/international-law" "08-society-history-and-power/public-policy-and-law"
Move-Books "17-law-legal-systems/legal-practice-and-career" "08-society-history-and-power/public-policy-and-law"

# 18-history -> 08
Move-Books "18-history/big-history-and-civilization" "08-society-history-and-power/world-history-and-civilizations"
Move-Books "18-history/contemporary-history" "08-society-history-and-power/history"
Move-Books "18-history/economic-and-financial-history" "08-society-history-and-power/history"
Move-Books "18-history/history-of-ideas-and-intellectual-history" "08-society-history-and-power/history"
Move-Books "18-history/history-of-technology" "08-society-history-and-power/history"
Move-Books "18-history/military-history" "08-society-history-and-power/history"
Move-Books "18-history/modern-world-history" "08-society-history-and-power/world-history-and-civilizations"
Move-Books "18-history/regional-history" "08-society-history-and-power/history"
Move-Books "18-history/world-history-and-civilizations" "08-society-history-and-power/world-history-and-civilizations"

# 19-political-science -> 08
Move-Books "19-political-science-geopolitics/comparative-politics" "08-society-history-and-power/political-science-and-geopolitics"
Move-Books "19-political-science-geopolitics/democracy-media-and-civil-society" "08-society-history-and-power/political-theory-and-philosophy"
Move-Books "19-political-science-geopolitics/geopolitics-and-great-power-competition" "08-society-history-and-power/geopolitics-and-great-power-competition"
Move-Books "19-political-science-geopolitics/international-relations" "08-society-history-and-power/international-relations"
Move-Books "19-political-science-geopolitics/political-economy" "08-society-history-and-power/political-theory-and-philosophy"
Move-Books "19-political-science-geopolitics/political-theory-and-philosophy" "08-society-history-and-power/political-theory-and-philosophy"
Move-Books "19-political-science-geopolitics/public-policy-and-governance" "08-society-history-and-power/public-policy-and-law"

# 20-pure-sciences -> 07
Move-Books "20-pure-sciences/astronomy-astrophysics-cosmology" "07-math-logic-and-science/astronomy-astrophysics-cosmology"
Move-Books "20-pure-sciences/biology-and-evolution" "07-math-logic-and-science/biology-and-evolution"
Move-Books "20-pure-sciences/chemistry" "07-math-logic-and-science/chemistry"
Move-Books "20-pure-sciences/earth-sciences-and-climate" "07-math-logic-and-science/earth-sciences-and-nature"
Move-Books "20-pure-sciences/evolutionary-biology" "07-math-logic-and-science/biology-and-evolution"
Move-Books "20-pure-sciences/neuroscience" "07-math-logic-and-science/neuroscience"
Move-Books "20-pure-sciences/philosophy-history-of-science" "07-math-logic-and-science/history-and-philosophy-of-science"
Move-Books "20-pure-sciences/physics" "07-math-logic-and-science/physics"
Move-Books "20-pure-sciences/popular-science-and-science-communication" "07-math-logic-and-science/popular-science"

# 21-nature -> 07
Move-Books "21-nature-environment-ecology/botany-zoology-and-biodiversity" "07-math-logic-and-science/biology-and-evolution"
Move-Books "21-nature-environment-ecology/climate-and-environmental-crisis" "07-math-logic-and-science/earth-sciences-and-nature"
Move-Books "21-nature-environment-ecology/ecology-and-environmental-science" "07-math-logic-and-science/earth-sciences-and-nature"
Move-Books "21-nature-environment-ecology/natural-history-writing" "07-math-logic-and-science/popular-science"

# 22-mathematics -> 07
Move-Books "22-mathematics-statistics/algebra-and-number-theory" "07-math-logic-and-science/mathematics"
Move-Books "22-mathematics-statistics/analysis-and-calculus" "07-math-logic-and-science/mathematics"
Move-Books "22-mathematics-statistics/applied-and-computational-mathematics" "07-math-logic-and-science/mathematics"
Move-Books "22-mathematics-statistics/foundations-of-mathematics-and-logic" "07-math-logic-and-science/mathematics"
Move-Books "22-mathematics-statistics/geometry-and-topology" "07-math-logic-and-science/mathematics"
Move-Books "22-mathematics-statistics/mathematics-for-a-general-audience" "07-math-logic-and-science/popular-science"
Move-Books "22-mathematics-statistics/probability-theory" "07-math-logic-and-science/statistics-and-probability"
Move-Books "22-mathematics-statistics/real-and-complex-analysis" "07-math-logic-and-science/mathematics"
Move-Books "22-mathematics-statistics/statistics-and-data-analysis" "07-math-logic-and-science/statistics-and-probability"

# 23-computer-science -> 04
Move-Books "23-computer-science/algorithms-and-data-structures" "04-computers-ai-and-software/data-algorithms-and-databases"
Move-Books "23-computer-science/compilers-and-language-runtimes" "04-computers-ai-and-software/computer-science-theory"
Move-Books "23-computer-science/computer-architecture-and-organization" "04-computers-ai-and-software/computer-science"
Move-Books "23-computer-science/computer-networking" "04-computers-ai-and-software/networking-and-distributed-systems"
Move-Books "23-computer-science/databases-and-storage-theory" "04-computers-ai-and-software/data-algorithms-and-databases"
Move-Books "23-computer-science/information-theory-and-coding" "04-computers-ai-and-software/computer-science-theory"
Move-Books "23-computer-science/operating-systems-internals" "04-computers-ai-and-software/computer-science"
Move-Books "23-computer-science/programming-languages-and-paradigms" "04-computers-ai-and-software/computer-science"
Move-Books "23-computer-science/security-and-cryptography" "04-computers-ai-and-software/cybersecurity"
Move-Books "23-computer-science/software-engineering-practice" "04-computers-ai-and-software/software-engineering"
Move-Books "23-computer-science/theoretical-computer-science" "04-computers-ai-and-software/theory-of-computation"
Move-Books "23-computer-science/theory-of-computation" "04-computers-ai-and-software/theory-of-computation"

# 24-software-engineering -> 04
Move-Books "24-software-engineering/api-design-and-integration" "04-computers-ai-and-software/software-engineering"
Move-Books "24-software-engineering/code-quality-and-craft" "04-computers-ai-and-software/code-quality-and-craft"
Move-Books "24-software-engineering/devops-sre-and-platform-engineering" "04-computers-ai-and-software/devops-and-platform-engineering"
Move-Books "24-software-engineering/distributed-systems-implementation" "04-computers-ai-and-software/system-design-and-architecture"
Move-Books "24-software-engineering/engineering-culture-and-team-dynamics" "04-computers-ai-and-software/software-engineering"
Move-Books "24-software-engineering/software-architecture" "04-computers-ai-and-software/software-design-principles"
Move-Books "24-software-engineering/software-design-and-architecture" "04-computers-ai-and-software/software-design-principles"
Move-Books "24-software-engineering/software-design-principles" "04-computers-ai-and-software/software-design-principles"
Move-Books "24-software-engineering/system-design-and-scalability" "04-computers-ai-and-software/system-design-and-architecture"

# 25-ai-ml -> 04
Move-Books "25-artificial-intelligence-machine-learning/ai-history-philosophy-and-ethics" "04-computers-ai-and-software/artificial-intelligence"
Move-Books "25-artificial-intelligence-machine-learning/ai-safety-and-alignment" "04-computers-ai-and-software/artificial-intelligence"
Move-Books "25-artificial-intelligence-machine-learning/computer-vision" "04-computers-ai-and-software/artificial-intelligence"
Move-Books "25-artificial-intelligence-machine-learning/deep-learning-and-neural-architectures" "04-computers-ai-and-software/artificial-intelligence"
Move-Books "25-artificial-intelligence-machine-learning/machine-learning-foundations" "04-computers-ai-and-software/artificial-intelligence"
Move-Books "25-artificial-intelligence-machine-learning/mlops-and-production-ai" "04-computers-ai-and-software/artificial-intelligence"
Move-Books "25-artificial-intelligence-machine-learning/natural-language-processing" "04-computers-ai-and-software/artificial-intelligence"
Move-Books "25-artificial-intelligence-machine-learning/reinforcement-learning" "04-computers-ai-and-software/artificial-intelligence"

# 26-technology-engineering -> 04
Move-Books "26-technology-engineering/biomedical-engineering" "04-computers-ai-and-software/engineering-and-technology"
Move-Books "26-technology-engineering/civil-and-infrastructure-engineering" "04-computers-ai-and-software/engineering-and-technology"
Move-Books "26-technology-engineering/electrical-and-electronics-engineering" "04-computers-ai-and-software/engineering-and-technology"
Move-Books "26-technology-engineering/energy-and-sustainability-engineering" "04-computers-ai-and-software/engineering-and-technology"
Move-Books "26-technology-engineering/history-and-philosophy-of-technology" "04-computers-ai-and-software/history-and-philosophy-of-technology"
Move-Books "26-technology-engineering/materials-science-and-nanotechnology" "04-computers-ai-and-software/engineering-and-technology"
Move-Books "26-technology-engineering/mechanical-engineering" "04-computers-ai-and-software/engineering-and-technology"
Move-Books "26-technology-engineering/robotics-and-automation" "04-computers-ai-and-software/engineering-and-technology"

# 27-biography -> 10
Move-Books "27-biography-memoir/artists-writers-and-musicians" "10-fiction-and-literature/artists-writers-and-musicians"
Move-Books "27-biography-memoir/autobiographies-and-personal-memoirs" "10-fiction-and-literature/autobiographies-and-personal-memoirs"
Move-Books "27-biography-memoir/collected-and-group-biographies" "10-fiction-and-literature/autobiographies-and-personal-memoirs"
Move-Books "27-biography-memoir/entrepreneurs-and-business-builders" "10-fiction-and-literature/entrepreneurs-and-business-builders"
Move-Books "27-biography-memoir/investors-and-financiers" "10-fiction-and-literature/entrepreneurs-and-business-builders"
Move-Books "27-biography-memoir/philosophers-and-intellectuals" "10-fiction-and-literature/political-and-military-leaders"
Move-Books "27-biography-memoir/political-and-military-leaders" "10-fiction-and-literature/political-and-military-leaders"
Move-Books "27-biography-memoir/scientists-and-mathematicians" "10-fiction-and-literature/scientists-and-mathematicians"
Move-Books "27-biography-memoir/social-activists-and-reformers" "10-fiction-and-literature/social-activists-and-reformers"
Move-Books "27-biography-memoir/sports-figures-and-athletes" "10-fiction-and-literature/autobiographies-and-personal-memoirs"
Move-Books "27-biography-memoir/technology-leaders-and-founders" "10-fiction-and-literature/technology-leaders-and-founders"

# 28-fiction -> 10
Move-Books "28-fiction/fantasy" "10-fiction-and-literature/fantasy"
Move-Books "28-fiction/graphic-novels-and-sequential-art" "10-fiction-and-literature/genre-fiction"
Move-Books "28-fiction/historical-fiction" "10-fiction-and-literature/genre-fiction"
Move-Books "28-fiction/horror-and-gothic-literature" "10-fiction-and-literature/horror-and-gothic-literature"
Move-Books "28-fiction/literary-fiction" "10-fiction-and-literature/literary-fiction"
Move-Books "28-fiction/mystery-and-crime-fiction" "10-fiction-and-literature/mystery-and-crime-fiction"
Move-Books "28-fiction/mythology-legend-and-epic" "10-fiction-and-literature/genre-fiction"
Move-Books "28-fiction/philosophical-and-existential-fiction" "10-fiction-and-literature/literary-fiction"
Move-Books "28-fiction/romance" "10-fiction-and-literature/genre-fiction"
Move-Books "28-fiction/science-fiction" "10-fiction-and-literature/science-fiction"
Move-Books "28-fiction/short-stories-and-flash-fiction" "10-fiction-and-literature/genre-fiction"

# 29-poetry-drama -> 10
Move-Books "29-poetry-drama-performing-arts/drama-and-theatre" "10-fiction-and-literature/drama-and-theatre"
Move-Books "29-poetry-drama-performing-arts/performing-arts" "10-fiction-and-literature/drama-and-theatre"
Move-Books "29-poetry-drama-performing-arts/poetry" "10-fiction-and-literature/poetry-and-drama"

# 30-music-film -> 10
Move-Books "30-music-film-media/film-studies" "10-fiction-and-literature/film-and-media-studies"
Move-Books "30-music-film-media/media-studies" "10-fiction-and-literature/film-and-media-studies"
Move-Books "30-music-film-media/music" "10-fiction-and-literature/music"

# 31-architecture-art -> 10
Move-Books "31-architecture-art-design/architecture" "10-fiction-and-literature/art-and-design"
Move-Books "31-architecture-art-design/design" "10-fiction-and-literature/art-and-design"
Move-Books "31-architecture-art-design/fine-arts" "10-fiction-and-literature/art-and-design"
Move-Books "31-architecture-art-design/photography" "10-fiction-and-literature/art-and-design"

# 32-literary-criticism -> 10
Move-Books "32-literary-criticism-theory/author-studies-and-genre-criticism" "10-fiction-and-literature/literary-criticism"
Move-Books "32-literary-criticism-theory/classical-literary-theory" "10-fiction-and-literature/literary-criticism"
Move-Books "32-literary-criticism-theory/modern-literary-theory" "10-fiction-and-literature/literary-criticism"

Write-Host "Migration complete! $script:count book directories moved."
