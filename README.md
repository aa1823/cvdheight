# Do tall people have greater odds of developing cardiovascular disease than short people?


An Analysis of a Kaggle Dataset

CVD, also known as cardiovascular disease, or colloquially known as “heart disease” is a prominent illness that impacts the heart and vascular system throughout the body. It affects many Americans nationally, and is the leading cause of death for Americans annually[1]. 
According to the CDC, one person dies every 34 seconds from heart disease[2]. It is said that up to 80% of CVD can be prevented via changes to modifiable risk factors, of which high blood pressure, high cholesterol, cigarette smoking, diet, physical activity, and obesity are a part [3]. 

There are many different types of cardiovascular disease, a major one being stroke, which is defined as a blockage of a blood vessel in the brain, and hypertension. Additionally, 1 in 6 deaths from cardiovascular disease was from stroke in 2020[4].
There are many factors that can impact risk, and there is a question of whether an immutable characteristic like height can impact odds of developing cardiovascular disease, in combination with modifiable risk factors such as exercise or BMI. 

According to a study performed by Samara, Elrick, and Storms, “..the results…indicate that shorter people have substantially lower rates of CHD mortality and moderately lower levels of stroke mortality. For example…shorter ethnic groups vs taller groups in California had substantially lower mortality rates”[5]. 

## Getting Started

### Prerequisites

What things you need to install the software and how to install them

```
SAS for desktop or SAS online
```


# Results
The results of the SAS analysis can be interpreted in terms of odds ratios: 
 - The odds of someone who is tall having heart disease is 0.898 times less that of someone who is not tall. The probability of having CVD given you are tall is 0.47 or 47%. It was found to be statistically significant. 
 - The probability of having CVD given that you are hypertensive is 0.65. The odds of someone developing CVD is 1.865 times greater than those with normal blood pressure.
 - The probability of developing CVD given you work out is 0.44, or the odds are 0.795 times less than if you didn’t. 
 - The odds of having CVD was 3.1 times greater for the 37-44 age group than the 58-65 age group.
 - The odds of having CVD given you have an “overweight” BMI is 1.214. Your probability of CVD in the presence of this predictor is 0.55. 
 - The odds of a woman having CVD given the predictors is 1.056 times greater than that of a man, based on the dataset. The chance of having it is 0.51 or 51%.
 - An ROC (receiver operating characteristic) curve was generated from the data, and the area under this curve was 0.778. This means that the probability of our model being able to correctly classify an individual with CVD was right 78% of the time.

Conclusion

	To conclude, the analysis shows, based on the dataset, that if you’re a woman between the ages of 37-44 and you are tall, exercise, hypertensive, and overweight, you are more likely to have CVD, than a man with the same characteristics. The analysis seemed to show that height had a protective effect overall. 

 These conclusions are not without problems; for example,  All the potential predictors that impact risk of CVD are not listed in the dataset. Because the country of origin for the data was not listed, it was hard to compare values. The average age of the participants in the data was 53 (years) 11 (days), and it was collected in a clinical setting. People who are hospitalized tend to have more serious disease, older people tend to experience more frequent hospitalizations, so the results are not that generalizable, only for this specific group. Tallness taken to be greater than 2 standard deviations means that only about 2.1% of height the data is represented, so it is rare. And finally, BMI is not a good estimate of body composition, so it is hard to draw meaningful conclusions with this metric. It assumes that a large volume of weight for an individual is automatically attributed to body fat instead of musculature. 


## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc

