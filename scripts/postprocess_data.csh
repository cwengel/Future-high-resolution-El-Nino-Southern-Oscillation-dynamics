#!/bin/csh

set echo

set dir_data = /home/cwengel/_proj/shared_data/cesm_hires/BC5.ne120_t12.pop62.lagrangian.off
set dir_work = /proj/cwengel/CESM_data_processed_pop62_lagroff

cd ${dir_work}

set yri = 71
set IYEAR=`printf "%04d" ${yri}`
set yre = 140
set EYEAR=`printf "%04d" ${yre}`

##SST
#starting at 0001
if ( -e SST.mon.0001-$EYEAR.1x1.nc ) then
rm SST.mon.0001-$EYEAR.1x1.nc
else
endif
cdo cat $dir_data/ocn/mon/SST.mon.0001-0070.1x1.nc $dir_data/ocn/mon/SST.mon.0071-0090.1x1.nc $dir_data/ocn/mon/SST.mon.0091-$EYEAR.1x1.nc SST.mon.0001-$EYEAR.1x1.nc

cdo sellonlatbox,30,280,-30,30 SST.mon.0001-$EYEAR.1x1.nc SST.mon.0001-$EYEAR.1x1.pac.nc
cp SST.mon.0001-$EYEAR.1x1.pac.nc SST.mon.0001-xxxx.1x1.pac.nc

if ( -e SST.mon.0001-xxxx.1x1.pac.detrend_quadr.pre.nc ) then
rm SST.mon.0001-xxxx.1x1.pac.detrend_quadr.pre.nc
else
endif

ncl detrend_sst_0001-xxxx_1x1.ncl

ferret -nojnl << STOP
set mem/size=2200
use/order=xyt SST.mon.0001-xxxx.1x1.pac.detrend_quadr.pre.nc
use SST.mon.0001-$EYEAR.1x1.pac.nc
save/clobber/file=SST.mon.0001-$EYEAR.1x1.pac.detrend_quadr.nc SST_QUADR_DETR[d=1,gxyt=sst[d=2]@asn]
q
STOP

cdo ymonsub SST.mon.0001-$EYEAR.1x1.pac.detrend_quadr.nc -ymonmean SST.mon.0001-$EYEAR.1x1.pac.detrend_quadr.nc SST.mon.0001-$EYEAR.1x1.pac.detrend_quadr.a.nc

#starting at 0071
if ( -e SST.mon.0071-$EYEAR.1x1.nc ) then
rm SST.mon.0071-$EYEAR.1x1.nc
else
endif
cdo cat $dir_data/ocn/mon/SST.mon.0071-0090.1x1.nc $dir_data/ocn/mon/SST.mon.0091-$EYEAR.1x1.nc SST.mon.0071-$EYEAR.1x1.nc
cdo sellonlatbox,30,280,-30,30 SST.mon.0071-$EYEAR.1x1.nc SST.mon.0071-$EYEAR.1x1.pac.nc
cp SST.mon.0071-$EYEAR.1x1.pac.nc SST.mon.1x1.pac.nc

if ( -e SST.mon.1x1.pac.detrend_quadr.pre.nc ) then
rm SST.mon.1x1.pac.detrend_quadr.pre.nc
else
endif

ncl detrend_sst_1x1.ncl

ferret -nojnl << STOP
set mem/size=2200
use/order=xyt SST.mon.1x1.pac.detrend_quadr.pre.nc
use SST.mon.0071-$EYEAR.1x1.pac.nc
save/clobber/file=SST.mon.0071-$EYEAR.1x1.pac.detrend_quadr.nc SST_QUADR_DETR[d=1,gxyt=sst[d=2]@asn]
q
STOP

cdo ymonsub SST.mon.0071-$EYEAR.1x1.pac.detrend_quadr.nc -ymonmean SST.mon.0071-$EYEAR.1x1.pac.detrend_quadr.nc SST.mon.0071-$EYEAR.1x1.pac.detrend_quadr.a.nc
