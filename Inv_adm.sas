/* Create a permanent library in the specified folder */
LIBNAME mydata "/home/u63882635/mydata/";

/* Import the first sheet - SLPP+SLP */
PROC IMPORT DATAFILE="/home/u63882635/survival/Psihiatrie/27.09.2024.xlsx"
    OUT=mydata.SLPP_SLP
    DBMS=XLSX
    REPLACE;
    SHEET="SLPP+SLP";
    GETNAMES=YES;
RUN;

/* Import the second sheet - SLPP */
PROC IMPORT DATAFILE="/home/u63882635/survival/Psihiatrie/27.09.2024.xlsx"
    OUT=mydata.SLPP
    DBMS=XLSX
    REPLACE;
    SHEET="SLPP";
    GETNAMES=YES;
RUN;

/* Import the third sheet - SLP */
PROC IMPORT DATAFILE="/home/u63882635/survival/Psihiatrie/27.09.2024.xlsx"
    OUT=mydata.SLP
    DBMS=XLSX
    REPLACE;
    SHEET="SLP";
    GETNAMES=YES;
RUN;

/* Import the fourth sheet - SLPP+SLP-informed consent 0 */
PROC IMPORT DATAFILE="/home/u63882635/survival/Psihiatrie/27.09.2024.xlsx"
    OUT=mydata.SLPP_SLP_informed_consent_0
    DBMS=XLSX
    REPLACE;
    SHEET="SLPP+SLP-informed consent 0";
    GETNAMES=YES;
RUN;

/* Import the fifth sheet - SLPP +SLP -informed consent 1 */
PROC IMPORT DATAFILE="/home/u63882635/survival/Psihiatrie/27.09.2024.xlsx"
    OUT=mydata.SLPP_SLP_informed_consent_1
    DBMS=XLSX
    REPLACE;
    SHEET="SLPP +SLP -informed consent 1";
    GETNAMES=YES;
RUN;

/* Run PROC FREQ for each hypothesis, adjusting for Group_study and Informed_Consent */


/* Sociodemographic & Economic Factors */
PROC FREQ DATA=mydata.SLPP_SLP;
    TITLE "Sociodemographic & Economic Factors";
    TABLES Group_study*Gender*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Age_Group*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Marital_Status*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Income_Src*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Edu_Level*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Insured_Status*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Residence_Type*Informed_Consent / CHISQ CMH;
RUN;

/* Clinical & Psychiatric Symptoms */
PROC FREQ DATA=mydata.SLPP_SLP;
    TITLE "Clinical & Psychiatric Symptoms";
    TABLES Group_study*Psych_Symptoms*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Agg_Behaviorc*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Suicide_Attempt*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Prim_Diag*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Comorbid*Informed_Consent / CHISQ CMH;
RUN;

/* Substance Use & Behavioral Factors */
PROC FREQ DATA=mydata.SLPP_SLP;
    TITLE "Substance Use & Behavioral Factors";
    TABLES Group_study*Alcohol_Cons*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Psycho_Sub*Informed_Consent / CHISQ CMH;
    TABLES Group_study*First_Adm*Informed_Consent / CHISQ CMH;
RUN;

/* Legal & Admission Circumstances */
PROC FREQ DATA=mydata.SLPP_SLP;
    TITLE "Legal & Admission Circumstances";
    TABLES Group_study*Police_Inv*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Inv_Req*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Recurrence*Informed_Consent / CHISQ CMH;
RUN;

/* Restraint & Timing Factors */
PROC FREQ DATA=mydata.SLPP_SLP;
    TITLE "Restraint & Timing Factors";
    TABLES Group_study*Phys_Restraint*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Psych_Agitation*Informed_Consent / CHISQ CMH;
    TABLES Group_study*Time_Slot*Informed_Consent / CHISQ CMH;
RUN;


/* Sociodemographic& economic factors */
proc tabulate data=mydata.SLPP_SLP; 
   class Group_study Informed_Consent Gender Age_Group Marital_Status Edu_Level Income_Src Insured_Status Residence_Type;
   
   table 
         (Gender='Gender'
          Age_Group='Age Group' 
          Marital_Status='Marital Status' 
          Edu_Level='Education Level' 
          Income_Src='Employment Status' 
          Insured_Status='Insurance Status' 
          Residence_Type='Residence Type'
          ALL='Total'), /* Adds a total row for demographics */

         (Group_study='Group Study' * 
          (Informed_Consent='Informed Consent' ALL='Total') 
          ALL='Total') *  /* Adds a total row for all Informed Consent categories */

         (N='Count' colpctn='% Column' rowpctn='% Row')

         / box='Demographics & Socioeconomic Factors';
run;

/* Clinical & Psychiatric Symptoms */ 
proc tabulate data=mydata.SLPP_SLP;
   class Group_study Informed_Consent Psych_Symptoms Agg_Behaviorc Suicide_Attempt Prim_Diag Comorbid;
   
   table 
         (Psych_Symptoms='Psychotic Symptoms' 
          Agg_Behaviorc='Aggressive Behavior' 
          Suicide_Attempt='Suicidal Behavior' 
          Prim_Diag='Primary Diagnosis'
          ALL='Total'),

         (Group_study='Group Study' * (Informed_Consent='Informed Consent' ALL='Total') ALL='Total') * 
         (N='Count' colpctn='% Column' rowpctn='% Row')

         / box='Clinical & Psychiatric Symptoms';
run;

/* Substance Use & Behavioral Factors */
proc tabulate data=mydata.SLPP_SLP;
   class Group_study Informed_Consent Alcohol_Cons Psycho_Sub First_Adm Comorbid;
   
   table 
         (Comorbid='Comorbidities'
          Alcohol_Cons='Alcohol Consumption' 
          Psycho_Sub='Psychoactive Substance Use' 
          First_Adm='First-time Admission' 
          ALL='Total'),

         (Group_study='Group Study' * (Informed_Consent='Informed Consent' ALL='Total') ALL='Total') * 
         (N='Count' colpctn='% Column' rowpctn='% Row')

         / box='Substance Use & Behavioral Factors';
run;

/* Legal & Admission Circumstances */
proc tabulate data=mydata.SLPP_SLP;
   class Group_study Informed_Consent Police_Inv Inv_Req Recurrence;
   
   table 
         (Police_Inv='Police Involvement' 
          Inv_Req='Involuntary Admission Request Source' 
          Recurrence='Recurrence of Admission' 
          ALL='Total'),

         (Group_study='Group Study' * (Informed_Consent='Informed Consent' ALL='Total') ALL='Total') * 
         (N='Count' colpctn='% Column' rowpctn='% Row')

         / box='Legal & Admission Circumstances';
run;

/* Restraint & Timing Factors */
proc tabulate data=mydata.SLPP_SLP;
   class Group_study Informed_Consent Phys_Restraint Psych_Agitation Time_Slot;
   
   table 
         (Phys_Restraint='Physical Restraint Used' 
          Psych_Agitation='Psychomotor Agitation'
          Time_Slot='Admission Time'
          ALL='Total'),

         (Group_study='Group Study' * (Informed_Consent='Informed Consent' ALL='Total') ALL='Total') * 
         (N='Count' colpctn='% Column' rowpctn='% Row')

         / box='Restraint & Timing Factors';
run;

/* Step 1: Fit Baseline Multinomial Logistic Regression Model */
PROC LOGISTIC DATA=mydata.SLPP_SLP DESCENDING PLOTS=ROC;
    CLASS 
        Gender (REF='1') /* 0=Male, 1=Female */
        Psych_Symptoms (REF='0') /* 0=No, 1=Yes */
        Edu_Level (REF='5') /* 0=No education, 5=Higher education */
        Insured_Status (REF='0') /* 0=Uninsured, 1=Insured */
        Alcohol_Cons (REF='0') /* 0=No, 1=Yes */
        Police_Inv (REF='0') /* 0=No, 1=Yes */
        Prim_Diag (REF='0') /* 0=F00-F09, Other categories included */
        Marital_Status (REF='0') /* 0=Single, 1=Married */
        Comorbid (REF='0') /* 0=Without comorbidities, 1=At least one */
    / PARAM=REF;
    
    MODEL Informed_Consent = 
        Gender 
        Psych_Symptoms 
        Edu_Level 
        Insured_Status 
        Alcohol_Cons 
        Police_Inv 
        Prim_Diag 
        Marital_Status 
        Comorbid
    / LINK=LOGIT FIRTH;
    
    OUTPUT OUT=BaseModel P=PredProbs;
RUN;
/* Step 2: Print AUC */
PROC PRINT DATA=AUC_Results;
    TITLE "Area Under the Curve (AUC) with Interaction Terms";
RUN;



/* Step 1: Fit Multinomial Logistic Regression Model & Save Predictions */
PROC LOGISTIC DATA=mydata.SLPP_SLP DESCENDING PLOTS=ROC;
    CLASS 
        Gender (REF='1') /* 0=Male, 1=Female */
        Psych_Symptoms (REF='0') /* 0=No, 1=Yes */
        Edu_Level (REF='5') /* 0=No education, 5=Higher education */
        Insured_Status (REF='0') /* 0=Uninsured, 1=Insured */
        Alcohol_Cons (REF='0') /* 0=No, 1=Yes */
        Police_Inv (REF='0') /* 0=No, 1=Yes */
        Prim_Diag (REF='0') /* 0=F00-F09, Other categories included */
        Marital_Status (REF='0') /* 0=Single, 1=Married */
        Comorbid (REF='0') /* 0=Without comorbidities, 1=At least one */
    / PARAM=REF;
    
    MODEL Informed_Consent(EVENT='1') = 
        Gender 
        Psych_Symptoms 
        Edu_Level 
        Insured_Status 
        Alcohol_Cons 
        Police_Inv 
        Prim_Diag 
        Marital_Status 
        Comorbid
        Agg_Behaviorc
        Inv_Req
        /*Gender*Psych_Symptoms
        Alcohol_Cons*Police_Inv
        Comorbid*Prim_Diag
        Marital_Status*Insured_Status
        Time_Slot*Psych_Agitation */
    / LINK=LOGIT FIRTH MAXITER=1000;

    /* Save predicted probabilities */
    OUTPUT OUT=Pred_Probs P=Pred_Prob;
    /* Extract AUC */
    ODS OUTPUT Association=AUC_Results;
RUN;

/* Step 2: Print AUC */
PROC PRINT DATA=AUC_Results;
    TITLE "Area Under the Curve (AUC) with Interaction Terms";
RUN;

