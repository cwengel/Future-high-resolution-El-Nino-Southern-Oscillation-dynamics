#!/bin/sh
set -xe

monthlist="01 02 03 04 05 06 07 08 09 10 11 12"

for mont in ${monthlist};do

work_dir=/home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/output_from_shscript/m${mont} #output to this directory

yri_raw=61
yre_raw=140
#depth_level=8

if [[ $mont -eq 01 ]]
then
depth_level=9
elif [[ $mont -eq 02 ]]
then
depth_level=8
elif [[ $mont -eq 03 ]]
then
depth_level=7
elif [[ $mont -eq 04 ]]
then
depth_level=7
elif [[ $mont -eq 05 ]]
then
depth_level=7
elif [[ $mont -eq 06 ]]
then
depth_level=8
elif [[ $mont -eq 07 ]]
then
depth_level=8
elif [[ $mont -eq 08 ]]
then
depth_level=9
elif [[ $mont -eq 09 ]]
then
depth_level=9
elif [[ $mont -eq 10 ]]
then
depth_level=8
elif [[ $mont -eq 11 ]]
then
depth_level=8
else
depth_level=9
fi

depth_int=1000 #in cm

yri=$(printf "%04d" ${yri_raw})
yre=$(printf "%04d" ${yre_raw})

cd ${work_dir}
#rm *.nc

data_dir=/home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/input_data/m${mont}
data_dir_lat=/home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index/input_data

##TD term
varlist="SST SRFRAD SHFLX LHFLX FLNS FSNS"
for var in ${varlist};do
cdo sellonlatbox,180,280,-5,5 ${data_dir}/${var}.mon.1x1.detrend.nc ${var}.mon.1x1.east.detrend.nc
done
#QNET
varlist="SHFLX LHFLX FLNS FSNS"
for var in ${varlist};do
 cdo fldmean ${var}.mon.1x1.east.detrend.nc ${var}.mon.1x1.east.fldmean.detrend.nc
 cdo -f nc ymonsub ${var}.mon.1x1.east.fldmean.detrend.nc -ymonmean ${var}.mon.1x1.east.fldmean.detrend.nc ${var}.mon.1x1.east.fldmean.a.nc
done
cdo copy SRFRAD.mon.1x1.east.detrend.nc QNET.mon.1x1.east.detrend.nc
rm SRFRAD.mon.1x1.east.detrend.nc
cdo fldmean QNET.mon.1x1.east.detrend.nc QNET.mon.1x1.east.fldmean.detrend.nc
cdo -f nc ymonsub QNET.mon.1x1.east.fldmean.detrend.nc -ymonmean QNET.mon.1x1.east.fldmean.detrend.nc QNET.mon.1x1.east.fldmean.a.nc
#SST
cdo fldmean SST.mon.1x1.east.detrend.nc SST.mon.1x1.east.fldmean.detrend.nc
cdo fldmean -sellonlatbox,210,280,-5,5 SST.mon.1x1.east.detrend.nc SST.mon.1x1.east.fldmean.detrend_n3.nc

cdo -f nc ymonsub SST.mon.1x1.east.fldmean.detrend.nc -ymonmean SST.mon.1x1.east.fldmean.detrend.nc SST.mon.1x1.east.fldmean.a.nc
cdo -f nc ymonsub SST.mon.1x1.east.fldmean.detrend_n3.nc -ymonmean SST.mon.1x1.east.fldmean.detrend_n3.nc SST.mon.1x1.east.fldmean_n3.a.nc

##miua term (taux)
cdo selname,TAUX ${data_dir}/TAUX.mon.1x1.detrend.nc TAUX.mon.1x1.detrend.nc
cdo sellonlatbox,120,280,-5,5 TAUX.mon.1x1.detrend.nc TAUX.mon.1x1.eq.detrend.nc
cdo fldmean TAUX.mon.1x1.eq.detrend.nc TAUX.mon.1x1.eq.fldmean.detrend.nc
cdo -f nc ymonsub TAUX.mon.1x1.eq.fldmean.detrend.nc -ymonmean TAUX.mon.1x1.eq.fldmean.detrend.nc TAUX.mon.1x1.eq.fldmean.a.nc

#zonal SST grad
cdo -timmean -sellonlatbox,179,279,-5,5 ${data_dir}/SST.mon.1x1.nc SST.mon.1x1.east1.nc
cdo -timmean -sellonlatbox,180,280,-5,5 ${data_dir}/SST.mon.1x1.nc SST.mon.1x1.east2.nc
cdo sub SST.mon.1x1.east1.nc SST.mon.1x1.east2.nc SST.mon.1x1.zonal_delta.nc
cdo -mulc,-1 -divc,11132000 SST.mon.1x1.zonal_delta.nc Zonal_SST_grad_E.nc
cdo -f nc fldmean Zonal_SST_grad_E.nc Zonal_SST_grad_E.nc

#ocean currents
cdo sellonlatbox,180,280,-5,5 -selname,UVEL ${data_dir}/UVEL.mon.1x1.nc UVEL.nc
cdo sellonlatbox,180,280,-5,5 -selname,VVEL ${data_dir}/VVEL.mon.1x1.nc VVEL.nc
cdo sellonlatbox,180,280,-5,5 -selname,WVEL ${data_dir}/WVEL.mon.1x1.nc WVEL.nc

cdo sellonlatbox,180,280,-5,5 -selname,UVEL ${data_dir}/UVEL.mon.1x1.detrend.nc UVEL_detrend.nc
cdo -sellonlatbox,180,280,-30,30 -sellevidx,1/${depth_level} -selname,UVEL ${data_dir}/UVEL.mon.1x1.detrend.nc UVEL_detrend.trop.nc
cdo sellonlatbox,180,280,-5,5 -selname,WVEL ${data_dir}/WVEL.mon.1x1.detrend.nc WVEL_detrend.nc

cdo sellevidx,1/${depth_level} UVEL.nc Upper_U.nc
cdo sellevidx,1/${depth_level} VVEL.nc Upper_V.nc
cdo sellevidx,1/${depth_level} WVEL.nc Upper_W.nc

cdo sellevidx,1/${depth_level} UVEL_detrend.nc Upper_U.detrend.nc
cdo sellevidx,1/${depth_level} WVEL_detrend.nc Upper_W.detrend.nc

cdo -fldmean -vertmean Upper_U.nc Upper_U.mean.nc
cdo -vertmean Upper_V.nc Upper_V.mean.nc
cdo -f nc -fldmean -vertmean Upper_W.nc Upper_fldmeanW.nc
#DD_U
cdo -f nc divc,11132000 Upper_U.mean.nc  DD_Term1.nc
#DD_V
cdo selindexbox,80,180,86,96 -selname,nav_lat ${data_dir_lat}/lat_1x1.nc lat_1x1_east1.nc
cdo selindexbox,80,180,86,96 -selname,nav_lat ${data_dir_lat}/lat_1x1.nc lat_1x1_east2.nc
cdo abs -add lat_1x1_east1.nc lat_1x1_east2.nc lat_mesh_mask.nc
cdo -f nc -fldmean -divc,111320000 -divc,111320000 -mulc,-1 -mul Upper_V.mean.nc lat_mesh_mask.nc DD_Term2.nc
#DD_W will be later devided by MLD in matlab script

##Upper Ua
cdo ymonsub Upper_U.detrend.nc -ymonmean Upper_U.detrend.nc Upper_U.a.nc
cdo -f nc -fldmean -vertmean Upper_U.a.nc Upper_fldmeanUa.nc

cdo ymonsub UVEL_detrend.trop.nc -ymonmean UVEL_detrend.trop.nc UVEL_detrend.trop.a.nc
cdo -f nc -vertmean UVEL_detrend.trop.a.nc UVEL_detrend.trop.a.vertmean.nc


##hfunc
cdo gtc,0 Upper_W.nc Hfunc.nc

##w for EF and TF
#mean W for TF
cdo mul Upper_W.nc Hfunc.nc Upper_W.hfunc.nc
cdo setctomiss,0 Upper_W.hfunc.nc Upper_W.hfunc.setctomiss.nc
cdo -f nc -fldmean -vertmean Upper_W.hfunc.setctomiss.nc Hfunc_upper_W.nc
#anomalous W for EF
cdo ymonsub Upper_W.detrend.nc -ymonmean Upper_W.detrend.nc Upper_W.a.nc
cdo mul Upper_W.a.nc Hfunc.nc Upper_W.a.hfunc.nc
cdo setctomiss,0 Upper_W.a.hfunc.nc Upper_W.a.hfunc.setctomiss.nc
cdo -f nc -fldmean -vertmean Upper_W.a.hfunc.setctomiss.nc Hfunc_upper_Wa.nc

##temp for a_h
cdo selname,TEMP ${data_dir}/TEMP.mon.1x1.nc TEMP.mon.1x1.nc
cdo selname,TEMP ${data_dir}/TEMP.mon.1x1.detrend.nc TEMP.mon.1x1.detrend.nc
cdo sellevidx,${depth_level} -sellonlatbox,180,280,-5,5 TEMP.mon.1x1.nc Upper_T.nc
cdo sellevidx,${depth_level} -sellonlatbox,180,280,-5,5 TEMP.mon.1x1.detrend.nc Upper_T.detrend.nc
cdo ymonsub Upper_T.detrend.nc -ymonmean Upper_T.detrend.nc Upper_T.a.nc
cdo -setname,temp -mul Upper_T.a.nc -sellevidx,${depth_level} Hfunc.nc Upper_T.a.hfunc.nc 
cdo setctomiss,0 Upper_T.a.hfunc.nc Upper_T.a.hfunc.setctomiss.nc
cdo -f nc -fldmean -vertmean Upper_T.a.hfunc.setctomiss.nc Hfunc_Tsuba.nc 
cdo -f nc -fldmean -vertmean -sellonlatbox,210,280,-5,5 Upper_T.a.hfunc.setctomiss.nc Hfunc_Tsuba.n3.nc

##vert. temp. grad.
ferret -nojnl << STOP
set mem/size=2200
use TEMP.mon.1x1.nc
let temp_grad = temp[k=1:$depth_level@ddf]
save/clobber/file = Vertical_SST_grad_E.mean.nc temp_grad[x=180E:80W@ave,y=5S:5N@ave,k=@ave,l=@ave]
q
STOP

##thermocline
cdo -copy ${data_dir}/thermocline_E.detrend.nc thermocline_E.nc
cdo -copy ${data_dir}/thermocline_W.detrend.nc thermocline_W.nc #in the west, over shallow regions can be no thermocline, because water too warm
cdo settaxis,${yri}-$mont-16,12:00:00,1year thermocline_W.nc thermocline_WTset.nc
cdo settaxis,${yri}-$mont-16,12:00:00,1year thermocline_E.nc thermocline_ETset.nc
cdo fldmean thermocline_ETset.nc thermocline_E_fldmean.nc
cdo fldmean -sellonlatbox,210,280,-5,5 thermocline_ETset.nc thermocline_E_fldmean_n3.nc
cdo fldmean thermocline_WTset.nc thermocline_W_fldmean.nc
cdo sub thermocline_E_fldmean.nc thermocline_W_fldmean.nc thermocline_grad_E-W_fldmean.nc
cdo ymonsub thermocline_W_fldmean.nc -ymonmean thermocline_W_fldmean.nc thermoclinea_W_fldmean.nc
cdo ymonsub thermocline_E_fldmean.nc -ymonmean thermocline_E_fldmean.nc thermoclinea_E_fldmean.nc
cdo ymonsub thermocline_E_fldmean_n3.nc -ymonmean thermocline_E_fldmean_n3.nc thermoclinea_E_fldmean_n3.nc
cdo sub thermoclinea_E_fldmean.nc thermoclinea_W_fldmean.nc thermoclinea_grad_E-W_fldmean.nc
done #mont
