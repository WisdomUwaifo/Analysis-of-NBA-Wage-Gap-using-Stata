ssc install bcuse 
bcuse nbasal
* Summary Statistics 
sum wage points exper minutes black age coll
*Scatter Plot
ssc install asdoc
asdoc twoway (scatter wage points, sort), replace
* Histogram of the Wage Structure of NBA Players  
histogram wage, percent

ssc install estout, replace


**** Store regression results ***
eststo simple: reg lwage points
eststo mult: reg lwage points exper minutes age black coll

**** Label variables so they look nice/are easy to read***
label var points "Points per game"
label var exper  "Years as professional player"
label var minutes  "Average minutes per year"
label var age  "age in years"

**** Produce Stata Table ***
esttab *, mlabels("Simple" "Multiple")  ///
mgroups("Outcome: Wage",  ///
pattern(1 0 0 0 ) span) ///
se  label r2 ar2  ///
star(+ 0.10 * 0.05 ** 0.01 *** 0.001)

**** Output to Word***
esttab using mydoc.rtf, mlabels("Simple" "Multiple")  ///
mgroups("Outcome: Wage" ) ///
se  label r2 ar2  ///
star(+ 0.10 * 0.05 ** 0.01 *** 0.001) replace

*Test for heteroskedasticity/white test 
ssc install whitetst
eststo mult: reg lwage points exper minutes age black coll
whitetst, fitted

* Correct for heteroskedasticity/ robust
eststo simple: reg lwage points
eststo mult: reg lwage points exper minutes age black coll, robust