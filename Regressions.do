cd "C:\Users\gatla\OneDrive\BSE\Thesis\git_repo\Thesis---War-Image-Classification\data"

* Load weekly panel data
import delimited "weekly_panel.csv", clear

* Drop final week as not complete data for all channels
drop if week == "2024-04-29"

* Encode channel and convert string to date
encode channel, generate(channel_numeric)
generate numdate = date(week, "YMD")

* Log all variables for easier interpretation
gen ln_launched = log(launched)
gen ln_fatalities = log(fatalities)
gen ln_coverage = log(coverage)
gen ln_war_images = log(war_images)

* Set panel variables
xtset channel_numeric numdate


* Panel regressions with channel fixed effects

* Coverage
xtreg coverage ln_fatalities, fe vce(cluster channel_numeric)
xtreg coverage ln_launched, fe vce(cluster channel_numeric)

* Share of war images
xtreg war_images ln_fatalities, fe vce(cluster channel_numeric)
xtreg war_images ln_launched, fe vce(cluster channel_numeric)


* Channel  by channel regressions - level log
reg coverage ln_fatalities if channel=="a3"
reg coverage ln_fatalities if channel=="la6"
reg coverage ln_fatalities if channel=="t5"

reg coverage ln_launched if channel=="a3"
reg coverage ln_launched if channel=="la6"
reg coverage ln_launched if channel=="t5"

reg war_images ln_fatalities if channel=="a3"
reg war_images ln_fatalities if channel=="la6"
reg war_images ln_fatalities if channel=="t5"

reg war_images ln_launched if channel=="a3"
reg war_images ln_launched if channel=="la6"
reg war_images ln_launched if channel=="t5"

