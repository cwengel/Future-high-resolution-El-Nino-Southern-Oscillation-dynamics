#!/bin/csh

set echo

set yri = 61
set IYEAR=`printf "%04d" ${yri}`
set yre = 140
set EYEAR=`printf "%04d" ${yre}`
@ ll = ($yre - $yri) + 1 #have one extra year in beginning and end
@ end_index = $ll * 73 - 7
@ end_index_ferret = $ll * 73 
@ end_index_ferret_mon = $ll * 12

## TIW (highpass 70days) ###
#T
if ( -e TEMP.daily.east.55m.detrend.pre.nc ) then
rm TEMP.daily.east.55m.detrend.pre.nc
else
endif

ncl detrend_temp.ncl

ferret -nojnl << STOP
set mem/size=10000
use TEMP.daily.east.55m.detrend.pre.nc
use TEMP.daily.east.55m.nc
let temp_gr = temp_quadr_detr[d=1,gxyzt=temp[d=2]@asn]
save/file = TEMP.daily.east.55m.detrend.nc/llimits=1:$end_index_ferret/clobber temp_gr[l=1]
repeat/l=2:$end_index_ferret \
(save/file=TEMP.daily.east.55m.detrend.nc/append/clobber temp_gr)
q
STOP

cdo setmisstoc,-999 TEMP.daily.east.55m.detrend.nc TEMP.daily.east.55m.detrend.setmisstoc.nc
cdo highpass,5.214 TEMP.daily.east.55m.detrend.setmisstoc.nc TEMP.daily.east.55m.detrend.setmisstoc.highpass_70day.nc
cdo setctomiss,-999 TEMP.daily.east.55m.detrend.setmisstoc.highpass_70day.nc TEMP.TIW.nc
rm TEMP.daily.east.55m.detrend.setmisstoc.highpass_70day.nc

##same for U
if ( -e UVEL.daily.east.55m.detrend.pre.nc ) then
rm UVEL.daily.east.55m.detrend.pre.nc
else
endif

ncl detrend_uvel.ncl

ferret -nojnl << STOP
set mem/size=10000
use UVEL.daily.east.55m.detrend.pre.nc
use UVEL.daily.east.55m.nc
let UVEL_gr = uvel_quadr_detr[d=1,gxyzt=UVEL[d=2]@asn]
save/file = UVEL.daily.east.55m.detrend.nc/llimits=1:$end_index_ferret/clobber UVEL_gr[l=1]
repeat/l=2:$end_index_ferret \
(save/file=UVEL.daily.east.55m.detrend.nc/append/clobber UVEL_gr)
q
STOP

cdo setmisstoc,-999 UVEL.daily.east.55m.detrend.nc UVEL.daily.east.55m.detrend.setmisstoc.nc
cdo highpass,5.214 UVEL.daily.east.55m.detrend.setmisstoc.nc UVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc
cdo setctomiss,-999 UVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc UVEL.TIW.nc
rm UVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc 

##same for V
if ( -e VVEL.daily.east.55m.detrend.pre.nc ) then
rm VVEL.daily.east.55m.detrend.pre.nc
else
endif

ncl detrend_vvel.ncl

ferret -nojnl << STOP
set mem/size=10000
use VVEL.daily.east.55m.detrend.pre.nc
use VVEL.daily.east.55m.nc
let VVEL_gr = VVEL_quadr_detr[d=1,gxyzt=VVEL[d=2]@asn]
save/file = VVEL.daily.east.55m.detrend.nc/llimits=1:$end_index_ferret/clobber VVEL_gr[l=1]
repeat/l=2:$end_index_ferret \
(save/file=VVEL.daily.east.55m.detrend.nc/append/clobber VVEL_gr)
q
STOP

cdo setmisstoc,-999 VVEL.daily.east.55m.detrend.nc VVEL.daily.east.55m.detrend.setmisstoc.nc
cdo highpass,5.214 VVEL.daily.east.55m.detrend.setmisstoc.nc VVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc
cdo setctomiss,-999 VVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc VVEL.TIW.nc
rm VVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc

##same for W
if ( -e WVEL.daily.east.55m.detrend.pre.nc ) then
rm WVEL.daily.east.55m.detrend.pre.nc
else
endif

ncl detrend_wvel.ncl

ferret -nojnl << STOP
set mem/size=10000
use WVEL.daily.east.55m.detrend.pre.nc
use WVEL.daily.east.55m.nc
let WVEL_gr = WVEL_quadr_detr[d=1,gxyzt=WVEL[d=2]@asn]
save/file = WVEL.daily.east.55m.detrend.nc/llimits=1:$end_index_ferret/clobber WVEL_gr[l=1]
repeat/l=2:$end_index_ferret \
(save/file=WVEL.daily.east.55m.detrend.nc/append/clobber WVEL_gr)
q
STOP

cdo setmisstoc,-999 WVEL.daily.east.55m.detrend.nc WVEL.daily.east.55m.detrend.setmisstoc.nc
cdo highpass,5.214 WVEL.daily.east.55m.detrend.setmisstoc.nc WVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc
cdo setctomiss,-999 WVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc WVEL.TIW.nc
rm WVEL.daily.east.55m.detrend.setmisstoc.highpass_70day.nc

##Calc. product terms
cdo -setname,u_tiw_t_tiw -divc,1e2 -mul UVEL.TIW.nc TEMP.TIW.nc UVEL_TIW.T_TIW.nc
cdo -setname,v_tiw_t_tiw -divc,1e2 -mul VVEL.TIW.nc TEMP.TIW.nc VVEL_TIW.T_TIW.nc
cdo -setname,w_tiw_t_tiw -divc,1e2 -mul WVEL.TIW.nc TEMP.TIW.nc WVEL_TIW.T_TIW.nc

#VEL_TIW.T_TIW
ferret -nojnl << STOP
set mem/size=2200
use UVEL_TIW.T_TIW.nc
use VVEL_TIW.T_TIW.nc
use WVEL_TIW.T_TIW.nc
let zonal_dx = U_TIW_T_TIW[d=1,x=@ddc]
let mer_dy = V_TIW_T_TIW[d=2,y=@ddc]
let vert_dz = W_TIW_T_TIW[d=3,z=@ddc]
let sum = (zonal_dx+mer_dy+vert_dz)*-1
let int = sum[x=@din,y=@din,z=@din]
let lon_dim = 100*111321
let lat_dim = 10*110567
let depth_dim = 50
let vol = lon_dim*lat_dim*depth_dim
let HFC_VEL_TIW_T_TIW = int/vol
save/file = HFC.VEL_TIW.T_TIW.nc/llimits=1:$end_index_ferret/clobber HFC_VEL_TIW_T_TIW[l=1]
repeat/l=2:$end_index_ferret \
(save/file=HFC.VEL_TIW.T_TIW.nc/append/clobber HFC_VEL_TIW_T_TIW)
q
STOP

##calc monthly means and convert to K/month
#east
cdo -mulc,2628000 -monmean HFC.VEL_TIW.T_TIW.nc HFC.VEL_TIW.T_TIW.monmean.nc

#subtract AC
cdo -ymonsub HFC.VEL_TIW.T_TIW.monmean.nc -ymonmean HFC.VEL_TIW.T_TIW.monmean.nc HFC.VEL_TIW.T_TIW.monmean.a.nc

#calc. running mean
cdo -r runmean,3 HFC.VEL_TIW.T_TIW.monmean.a.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.nc

#select months for monthly regression
#HFC
cdo selmon,1 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.1.nc
cdo selmon,2 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.2.nc
cdo selmon,3 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.3.nc
cdo selmon,4 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.4.nc
cdo selmon,5 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.5.nc
cdo selmon,6 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.6.nc
cdo selmon,7 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.7.nc
cdo selmon,8 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.8.nc
cdo selmon,9 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.9.nc
cdo selmon,10 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.10.nc
cdo selmon,11 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.11.nc
cdo selmon,12 HFC.VEL_TIW.T_TIW.monmean.a.rm.nc HFC.VEL_TIW.T_TIW.monmean.a.rm.12.nc

cdo -fldmean -sellonlatbox,180,280,-5,5 -selyear,0057/0104 ../SST.mon.0001-0140.1x1.pac.detrend_quadr.a.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.nc
cdo runmean,3 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc


cdo selmon,1 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.1.nc
cdo selmon,2 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.2.nc
cdo selmon,3 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.3.nc
cdo selmon,4 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.4.nc
cdo selmon,5 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.5.nc
cdo selmon,6 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.6.nc
cdo selmon,7 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.7.nc
cdo selmon,8 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.8.nc
cdo selmon,9 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.9.nc
cdo selmon,10 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.10.nc
cdo selmon,11 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.11.nc
cdo selmon,12 SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.nc SST.mon.0057-0104.1x1.pac.detrend_quadr.a.east.rm.12.nc
