#!/bin/csh 

set echo

set dir_data_ocn = /home/cwengel/_proj/CESM_data_processed_pop62_lagroff
set dir_data_qnet = /home/cwengel/_proj/CESM_data_processed_pop62_lagroff
set dir_BJ = /home/cwengel/_proj/CESM_data_processed_pop62_lagroff/BJ_index
set mask_dir = /proj/cwengel/masks

set monthlist = (01 02 03 04 05 06 07 08 09 10 11 12)

cd ${dir_BJ}

set yri = 0061
set yre = 0140

if ( -e input_data ) then
 rm -r input_data/ output_from_shscript/
endif

mkdir input_data
mkdir output_from_shscript

cd output_from_shscript
mkdir m1
mkdir m2
mkdir m3
mkdir m4
mkdir m5
mkdir m6
mkdir m7
mkdir m8
mkdir m9
mkdir m10
mkdir m11
mkdir m12

cd ../input_data
mkdir m1
mkdir m2
mkdir m3
mkdir m4
mkdir m5
mkdir m6
mkdir m7
mkdir m8
mkdir m9
mkdir m10
mkdir m11
mkdir m12

cdo sellonlatbox,120,80,-5,5 ${dir_data_ocn}/SST.mon.${yri}-${yre}.1x1.nc SST.mon.1x1.nc #ocean
cdo sellonlatbox,120,80,-5,5 ${dir_data_ocn}/TAUX.mon.${yri}-${yre}.1x1.nc TAUX.mon.1x1.nc #ocean, positive eastward
cdo sellonlatbox,120,80,-5,5 ${dir_data_ocn}/TEMP.mon.${yri}-${yre}.1x1.nc TEMP.mon.1x1.nc #ocean
cdo sellonlatbox,120,80,-5,5 ${dir_data_ocn}/UVEL.mon.${yri}-${yre}.1x1.nc UVEL.mon.1x1.nc #ocean 
cdo sellonlatbox,120,80,-5,5 ${dir_data_ocn}/VVEL.mon.${yri}-${yre}.1x1.nc VVEL.mon.1x1.nc #oceam
cdo sellonlatbox,120,80,-5,5 ${dir_data_ocn}/WVEL.mon.${yri}-${yre}.1x1.nc WVEL.mon.1x1.nc #ocean
cdo sellonlatbox,120,80,-5,5 ${dir_data_qnet}/SRFRAD.mon.${yri}-${yre}.1x1.nc SRFRAD.mon.1x1.nc #atm
cdo sellonlatbox,120,80,-5,5 ${dir_data_qnet}/LHFLX.mon.${yri}-${yre}.1x1.nc LHFLX.mon.1x1.nc #atm
cdo sellonlatbox,120,80,-5,5 ${dir_data_qnet}/SHFLX.mon.${yri}-${yre}.1x1.nc SHFLX.mon.1x1.nc #atm
cdo sellonlatbox,120,80,-5,5 ${dir_data_qnet}/FSNS.mon.${yri}-${yre}.1x1.nc FSNS.mon.1x1.nc #atm
cdo sellonlatbox,120,80,-5,5 ${dir_data_qnet}/FLNS.mon.${yri}-${yre}.1x1.nc FLNS.mon.1x1.nc #atm
cdo sellonlatbox,120,80,-5,5 ${mask_dir}/land_sea_mask_1x1.nc land_sea_mask_1x1.nc
ln -s /proj/cwengel/masks/lat_1x1.nc 

cp ../detrend_*.ncl .

foreach VAR  ( SST TAUX SRFRAD LHFLX SHFLX FSNS FLNS )
if ( -e $VAR.mon.1x1.detrend.pre.nc ) then
rm $VAR.mon.1x1.detrend.pre.nc
else
endif

ncl detrend_$VAR.ncl

ferret -nojnl << STOP
set mem/size=10000
use/order=xyt ${VAR}.mon.1x1.detrend.pre.nc
use/order=xyt ${VAR}.mon.1x1.nc
let ${VAR}_gr = ${VAR}_quadr_detr[d=1,gxyt=${VAR}[d=2]@asn]
save/clobber/file = ${VAR}.mon.1x1.detrend.pre2.nc ${VAR}_gr
q
STOP

cdo setname,$VAR $VAR.mon.1x1.detrend.pre2.nc $VAR.mon.1x1.detrend.nc

end

foreach VAR  ( TEMP UVEL VVEL WVEL )

if ( -e $VAR.mon.1x1.detrend.pre.nc ) then
rm $VAR.mon.1x1.detrend.pre.nc
else
endif

ncl detrend_$VAR.ncl

ferret -nojnl << STOP
set mem/size=10000
use/order=xyzt ${VAR}.mon.1x1.detrend.pre.nc
use/order=xyzt ${VAR}.mon.1x1.nc
let ${VAR}_gr = ${VAR}_quadr_detr[d=1,gxyzt=${VAR}[d=2]@asn]
save/clobber/file = ${VAR}.mon.1x1.detrend.pre2.nc ${VAR}_gr
q
STOP

cdo setname,$VAR $VAR.mon.1x1.detrend.pre2.nc $VAR.mon.1x1.detrend.nc

end

#THERMOCLINE VIA TEMP GRAD
ncl detrend_thermocline.ncl

ferret -nojnl << STOP
set mem/size=10000
use/order=xyzt TEMP.mon.detrend.pre.nc
use/order=xyzt TEMP.mon.1x1.nc
let temp_gr = temp_quadr_detr[d=1,gxyzt=temp[d=2]@asn]
save/clobber/file = TEMP.mon.1x1.detrend.nc temp_gr
q
STOP

ferret -nojnl << STOP
set mem/Size=2200
use TEMP.mon.1x1.detrend.nc
let dT_dz = (temp_gr[d=1,z=@ddc])*-1
let dT_dz_max = dT_dz[z=@max]
let dT_dz_0 = dT_dz-dT_dz_max
let thermocline = dT_dz_0[z=@loc:0]
save/clobber/file=thermocline.mon.1x1.detrend.nc thermocline
q
STOP

ferret -nojnl << STOP
set mem/Size=2200
use TEMP.mon.1x1.nc
let dT_dz = (temp[d=1,z=@ddc])*-1
let dT_dz_max = dT_dz[z=@max]
let dT_dz_0 = dT_dz-dT_dz_max
let thermocline = dT_dz_0[z=@loc:0]
save/clobber/file=thermocline.raw.mon.1x1.nc thermocline
q
STOP

cdo sellonlatbox,180,280,-5,5 thermocline.mon.1x1.detrend.nc thermocline_E.detrend.nc
cdo sellonlatbox,120,180,-5,5 thermocline.mon.1x1.detrend.nc thermocline_W.detrend.nc


#Z20
ferret -nojnl << STOP
set mem/Size=2200
use TEMP.mon.1x1.nc
let Z20 = temp[d=1,z=@LOC:20]
save/clobber/file=Z20_0.nc Z20
q
STOP
cdo -setmisstoc,999 Z20_0.nc Z20_1.nc
cdo -mul Z20_1.nc land_sea_mask_1x1.nc Z20_2.nc
cdo -setctomiss,0 Z20_2.nc Z20_3.nc
cdo -setvals,999,500 Z20_3.nc Z20.nc

if ( -e Z20.detrend.pre.nc ) then
rm Z20.detrend.pre.nc
else
endif

ncl detrend_Z20.ncl

ferret -nojnl << STOP
set mem/size=10000
use/order=xyt Z20.mon.detrend.pre.nc
use Z20.nc
let Z20_gr = Z20_quadr_detr[d=1,gxyzt=Z20[d=2]@asn]
save/clobber/file = Z20.mon.detrend.pre2.nc Z20_gr
q
STOP

cdo setname,Z20 Z20.mon.detrend.pre2.nc Z20.mon.1x1.detrend.nc

cdo sellonlatbox,180,280,-5,5 Z20.mon.1x1.detrend.nc Z20_E.detrend.nc
cdo sellonlatbox,120,180,-5,5 Z20.mon.1x1.detrend.nc Z20_W.detrend.nc

foreach mm ($monthlist)

# cdo selmon,${mm} SST.mon.1x1.nc m${mm}/SST.mon.1x1.nc
# cdo selmon,${mm} TAUX.mon.1x1.nc m${mm}/TAUX.mon.1x1.nc
# cdo selmon,${mm} SRFRAD.mon.1x1.nc m${mm}/SRFRAD.mon.1x1.nc
# cdo selmon,${mm} SHFLX.mon.1x1.nc m${mm}/SHFLX.mon.1x1.nc
# cdo selmon,${mm} LHFLX.mon.1x1.nc m${mm}/LHFLX.mon.1x1.nc
# cdo selmon,${mm} FLNS.mon.1x1.nc m${mm}/FLNS.mon.1x1.nc
# cdo selmon,${mm} FSNS.mon.1x1.nc m${mm}/FSNS.mon.1x1.nc
# cdo selmon,${mm} TEMP.mon.1x1.nc m${mm}/TEMP.mon.1x1.nc
# cdo selmon,${mm} UVEL.mon.1x1.nc m${mm}/UVEL.mon.1x1.nc
# cdo selmon,${mm} VVEL.mon.1x1.nc m${mm}/VVEL.mon.1x1.nc
# cdo selmon,${mm} WVEL.mon.1x1.nc m${mm}/WVEL.mon.1x1.nc
#
# cdo selmon,${mm} SST.mon.1x1.detrend.nc m${mm}/SST.mon.1x1.detrend.nc
# cdo selmon,${mm} TAUX.mon.1x1.detrend.nc m${mm}/TAUX.mon.1x1.detrend.nc
# cdo selmon,${mm} SRFRAD.mon.1x1.detrend.nc m${mm}/SRFRAD.mon.1x1.detrend.nc
# cdo selmon,${mm} FSNS.mon.1x1.detrend.nc m${mm}/FSNS.mon.1x1.detrend.nc
# cdo selmon,${mm} FLNS.mon.1x1.detrend.nc m${mm}/FLNS.mon.1x1.detrend.nc
# cdo selmon,${mm} LHFLX.mon.1x1.detrend.nc m${mm}/LHFLX.mon.1x1.detrend.nc
# cdo selmon,${mm} SHFLX.mon.1x1.detrend.nc m${mm}/SHFLX.mon.1x1.detrend.nc
# cdo selmon,${mm} TEMP.mon.1x1.detrend.nc m${mm}/TEMP.mon.1x1.detrend.nc
# cdo selmon,${mm} UVEL.mon.1x1.detrend.nc m${mm}/UVEL.mon.1x1.detrend.nc
# cdo selmon,${mm} VVEL.mon.1x1.detrend.nc m${mm}/VVEL.mon.1x1.detrend.nc
# cdo selmon,${mm} WVEL.mon.1x1.detrend.nc m${mm}/WVEL.mon.1x1.detrend.nc
 cdo selmon,${mm} thermocline_E.detrend.nc m${mm}/thermocline_E.detrend.nc
 cdo selmon,${mm} thermocline_W.detrend.nc m${mm}/thermocline_W.detrend.nc

end

cd ../

#mv input_data/m1 input_data/m01
#mv input_data/m2 input_data/m02
#mv input_data/m3 input_data/m03
#mv input_data/m4 input_data/m04
#mv input_data/m5 input_data/m05
#mv input_data/m6 input_data/m06
#mv input_data/m7 input_data/m07
#mv input_data/m8 input_data/m08
#mv input_data/m9 input_data/m09
#
#mv output_from_shscript/m1 output_from_shscript/m01
#mv output_from_shscript/m2 output_from_shscript/m02
#mv output_from_shscript/m3 output_from_shscript/m03
#mv output_from_shscript/m4 output_from_shscript/m04
#mv output_from_shscript/m5 output_from_shscript/m05
#mv output_from_shscript/m6 output_from_shscript/m06
#mv output_from_shscript/m7 output_from_shscript/m07
#mv output_from_shscript/m8 output_from_shscript/m08
#mv output_from_shscript/m9 output_from_shscript/m09

cd ../
