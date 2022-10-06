/* Generated Code (IMPORT) */
/* Source File: cardio.csv */
/* Source Path: /home/u62330021/SAS PROJECT BSTA661 */
/* Code generated on: 9/19/22, 5:09 PM */

%web_drop_table(CVD);

options validvarname=v7;
FILENAME REFFILE '/home/u62330021/SAS PROJECT BSTA661/cardio.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=CVD;
	GETNAMES=YES;
	*replace; 
	delimiter=';'; *important step, the file is delimited using ; 
RUN;

PROC CONTENTS DATA=CVD; 
RUN;


%web_open_table(CVD);


*frequency/; 

PROC FREQ data = CVD; 
	weight CARDIO_DISEASE; 
	tables HEIGHT*CARDIO_DISEASE;
run;

*histogram;
proc sgplot data=CVD; 
	histogram glucose/ group = gender transparency=0.5; 
	run;
	

*recode into categories ;
DATA CVD2; 
	SET CVD; 
	*HEIGHT = .;
	IF (HEIGHT <= 94) THEN HEIGHT = 1; 
	IF (HEIGHT > 94 AND HEIGHT <= 133) THEN HEIGHT = 2; 
	IF (HEIGHT > 133 AND HEIGHT <= 172) THEN HEIGHT = 3; 
	IF (HEIGHT > 172 AND HEIGHT <= 211) THEN HEIGHT = 4; 
	IF (HEIGHT > 211 AND HEIGHT <= 250) THEN HEIGHT = 5; 
RUN; 

PROC FREQ DATA = CVD2; 
	tables HEIGHT*CARDIO_DISEASE;
	RUN;


*10 categories USE THIS ONE 10/3;
*RECORD VARAIBLES INTOCATEGORIES: BMI FROM WEIGHT
HEIGHT AND SBP/DBP AND AGE; 

* make a format for BP and BMI variable; 
proc format ;
	value BP
	1 = "Normal"
	2 = "Elevated" 
	3 = "High Blood Pressure (Hypertension STG 1)"
	4 = "High Blood Pressure (Hypertension STG 2)" 
	5 = "Hypertensive Crisis"  ;
	
	value BMI 
	0 = "Underweight" 
	1 =  "Normal"
	2 = "Overweight" 
	3 = "Obese Range";
	
	VALUE CVD 
	0 = "No"
	1 = "Yes" ; 
	
	VALUE AGE 
	1 = "<30" 
	2 = "30-37" 
	3 = "37-44"
	4 = "44-51" 
	5 = "51-58" 
	6 = "58-65"; 

RUN;
	
 
DATA  CVD3; 
	SET CVD ;
	drop AP_HIGH AP_LOW; 
	format BP BP.;
	format BMI BMI.;
	format CVD CVD. ; 
	*format AGE AGE. ;
	
	*HEIGHT = .;
	
	*height in meters; 
	H2_cm = HEIGHT; *squared height in CM;
	HiM = H2_cm / 100; *converting from cm to m; 
	BMI =  ((WEIGHT)/(((HiM * HiM)))) ; *converting weight and height to BMI;
	
	*SYSTOLE BP; 
	SBP = AP_HIGH;
	DBP = AP_LOW ;
	*BP = CAT(SBP/DBP);
	BP=.; 
	CVD = CARDIO_DISEASE;
	*SBP/DBP;
	
	*TALK ABOUT SBP/DBP RECODE LIMITATION IN CAT 4 AND 5; 
	IF (SBP < 120) AND (DBP < 80) THEN BP = 1;
	IF (120 =< SBP <= 129) AND (DBP < 80) THEN BP = 2; 
	IF (130 <= SBP <= 139) OR (80 <= DBP <= 89) THEN BP = 3; 
	IF (SBP => 140) OR (DBP => 90) THEN BP = 4; 
	IF (SBP > 180) OR (DBP > 120) THEN BP = 5; 
	
	
	IF (BMI < 18.5) THEN BMI = 0; 
	IF (18.5 < BMI <= 24.9) THEN BMI = 1;
	IF (24.9 < BMI <= 29.9) THEN BMI = 2; 
	IF (29.9 < BMI) THEN BMI = 3; 

	
	/*
	IF (HEIGHT <= 74.5) THEN HEIGHT = 1; 
	 IF (74.5 < HEIGHT <= 94) THEN HEIGHT = 2; 
	 IF (94 < HEIGHT <= 113.5) THEN HEIGHT = 3; 
	 IF (113.5 < HEIGHT <= 133) THEN HEIGHT = 4; 
	 IF (133 < HEIGHT <= 152.5) THEN HEIGHT = 5;
	 IF (152.5 < HEIGHT <= 172) THEN HEIGHT = 6; 
	 IF (172 < HEIGHT <= 191.5) THEN HEIGHT = 7; 
	 IF (191.5 < HEIGHT <= 211) THEN HEIGHT = 8; 
	 IF (211 < HEIGHT <= 230.5) THEN HEIGHT = 9; 
	 IF (230.5 < HEIGHT <= 250) THEN HEIGHT = 10; 
	 */
	IF (AGE <= 30) THEN AGE = 1; 
	IF (30 < AGE <= 37) THEN AGE = 2; 
	IF (37 < AGE <= 44) THEN AGE = 3; 
	IF (44 < AGE <= 51) THEN AGE = 4; 
	IF (51 < AGE <= 58) THEN AGE = 5; 
	IF (58 < AGE <= 65) THEN AGE = 6; 
	
	HH="Normal";
	*IF (HEIGHT GE 180) THEN HH="Tall";
	IF (GENDER = 1) AND (HEIGHT GE 176) THEN HH="Tall";
	IF (GENDER = 2) AND (HEIGHT GE 185) THEN HH="Tall";
	
	*For sake of argument, we take Tall to be 2sig from mean of avg height of data; 	
RUN;


*summary statistics for cvd3;
proc univariate data=CVD3;
*class gender cvd;
var height bmi sbp dbp age glucose cholesterol CVD;
run;

proc sgplot data = CVD3; 
histogram BMI AGE; 
run; 

proc univariate data = CVD3; 
	*class gender; 
	var bmi bp sbp dbp age height weight; 
	histogram BMI sbp dbp age height weight/ kernal overlay/ nrows=5 odstitle="Height";
	ods select histogram; 
	run;
	
*	vars histogram;
proc univariate data = CVD3; 
	*class gender; 
	var bmi bp sbp dbp age height weight; 
	histogram BMI sbp dbp age height weight/ nrows=5 odstitle="Height";
	ods select histogram; 
	run;
	
proc univariate data = CVD; 
	*class gender; 
	var age ; 
	histogram age / nrows=5 odstitle="Age";
	ods select histogram; 
	run;

*summary statistics for cvd;
proc univariate data=CVD;
class gender;
var weight;
run;

proc univariate data=CVD;
class gender;
var height;
run;


proc univariate data=CVD;
class gender;
var age;
run;

proc univariate data=CVD;
var height ap_high ap_low age weight;
run;

proc iml;
use Sashelp.class;
summary class gender var height;

*use this for the analysis; 
proc logistic descending data=CVD3 ; 
class HEIGHT BP(REF="3") AGE BMI(REF= "Overweight") SMOKE(REF="0") ALCOHOL(REF = "0") PHYSICAL_ACTIVITY(REF="1");
	model CVD(REF="No") = HEIGHT AGE BP BMI ALCOHOL SMOKE CHOLESTEROL PHYSICAL_ACTIVITY GLUCOSE GENDER/ selection = backward lackfit ; 
	run;
	
proc logistic descending data= CVD3 ; 
class HH(REF="Normal") BP(REF="High Blood Pressure (Hypertension STG 1)") AGE BMI(REF= "Overweight") SMOKE(REF="0") ALCOHOL(REF = "0") PHYSICAL_ACTIVITY(REF="1") GENDER / param=ref;
	freq count;
	model CVD(REF="Yes") = HH AGE BP BMI ALCOHOL SMOKE CHOLESTEROL PHYSICAL_ACTIVITY GLUCOSE GENDER/ selection = backward  lackfit ;  
	output out = prob PREDPROBS=I;	
run;




PROC FREQ DATA = CVD3;
RUN;


()

*msc;
proc genmod descending DATA = CVD3; 
	model HEIGHT = CVD / dist = bin; link = logit; lrci covb; 
	output  p=pred upper=ucl lower=lcl; 
	run;

*msc;
PROC FREQ DATA = CVD3; 
	tables BP*CARDIO_DISEASE*HEIGHT*BMI;
	RUN;
	
proc genmod descending data=CVD3 ; 
	model CVD = HEIGHT BP  / dist = bin link=logit; 
	run;
	

PROC CONTENTS DATA = CVD3;
RUN;









*recode WEIGHT AND BP ; 
*want to code WEIGHT to BMI so convert; 
DATA=CVD3; 
	SET CVD;
	BMI = ((703* WEIGHT) / ((HEIGHT * HEIGHT))) ;
run; 

















proc freq DATA=CVD3;
	
proc univariate data=CVD3;
   HISTOGRAM ;
run;



















DATA CVD3; 
	SET CVD; 
	*HEIGHT = .;
	IF (HEIGHT <= 74.5) THEN HEIGHT = 1; 
	ELSE IF (74.5 < HEIGHT <= 94) THEN HEIGHT = 2; 
	ELSE IF (94 < HEIGHT <= 113.5) THEN HEIGHT = 3; 
	ELSE IF (113.5 < HEIGHT <= 133) THEN HEIGHT = 4; 
	ELSE IF (133 < HEIGHT <= 152.5) THEN HEIGHT = 5;
	ELSE IF (152.5 < HEIGHT <= 172) THEN HEIGHT = 6; 
	ELSE IF (172 < HEIGHT <= 191.5) THEN HEIGHT = 7; 
	ELSE IF (191.5 < HEIGHT <= 211) THEN HEIGHT = 8; 
	ELSE IF (211 < HEIGHT <= 230.5) THEN HEIGHT = 9; 
	ELSE IF (230.5 < HEIGHT <= 250) THEN HEIGHT = 10; 
RUN;







DATA CVD4; 
	SET CVD; 
	*HEIGHT = .;
	IF (HEIGHT <= 74.5) THEN HEIGHT = 1; 
	IF (HEIGHT > 94 AND HEIGHT <= 133) THEN HEIGHT = 2; 
	IF (HEIGHT > 133 AND HEIGHT <= 172) THEN HEIGHT = 3; 
	IF (HEIGHT > 172 AND HEIGHT <= 211) THEN HEIGHT = 4; 
	IF (HEIGHT > 211 AND HEIGHT <= 250) THEN HEIGHT = 5;
	IF (HEIGHT > 94 AND HEIGHT <= 133) THEN HEIGHT = 6; 
	IF (HEIGHT > 133 AND HEIGHT <= 172) THEN HEIGHT = 7; 
	IF (HEIGHT > 172 AND HEIGHT <= 211) THEN HEIGHT = 8; 
	IF (HEIGHT > 211 AND HEIGHT <= 250) THEN HEIGHT = 9;
	IF (HEIGHT > 211 AND HEIGHT <= 250) THEN HEIGHT = 10;

RUN; 

PROC FREQ DATA = CVD4; 
	tables HEIGHT*CARDIO_DISEASE;
	RUN;











DATA CVD5; 
	SET CVD; 
	HEIGHT = .;
	IF (HEIGHT <= 94) THEN HEIGHT = 1; 
	ELSE IF (94 < HEIGHT <= 133) THEN HEIGHT = 2; 
	ELSE IF (133 < HEIGHT <= 172) THEN HEIGHT = 3; 
	ELSE IF (172 < HEIGHT <= 211) THEN HEIGHT = 4; 
	ELSE IF (211 < HEIGHT <= 250) THEN HEIGHT = 5; 
RUN;

